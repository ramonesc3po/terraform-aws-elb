#!/bin/bash

set -x

elasticsearch_log(){
    NOW=$(($(date +'%s * 1000 + %-N / 1000000'))) && \
    curl -H "Content-Type: application/json" \
    -X POST "https://elastic:gcYvL9T5GDDE88ZDQqHF5NJO@696cc71501ee4b2d93d71faf735c347a.us-east-1.aws.found.io:9243/deploys-terraform/_doc" \
    -d '
      {
        "timestamp": "'"${NOW}"'",
        "environment": "modules"
      }
      ' \
     -data-binary @output.json
}

command_exists () {
    type "$1" > /dev/null;
    return 1
}

help(){
    what_help="$1"
    if [ $what_help ==  required ]; then
        echo -e "===> You need Terraform tool.\n
        ====> Get download in https://www.terraform.io/downloads.html.
        "
    fi

    if [ $what_help == terraform_validate ]; then
        echo -e "Usage path to files. Example $0 path_tf_files"
    fi
}

required(){
    if command_exists terraform; then
        help "required"
        exit 1
    else
        export TERRAFORM=`which terraform12.4`
        echo -e "===> Terraform version:\n"
        $TERRAFORM version | grep -i "Terraform" | head -n 1
    fi
}

terraform_validate(){
    $TERRAFORM validate -no-color -json $1
}

run_test(){
    tf_files="$1"
    if required; then
        terraform_validate . > output.json
    fi
}

if [ -z "$1" ]; then
   help "terraform_validate"
   exit 1
else
   tf_files="$1"
fi

run_test $1
#!/bin/bash

echo "*********************"
echo "Generate open api modules"
echo "*********************"
ls
mkdir -p "open-api-modules"
ls
pwd

openapi-generator-cli generate -i open-api-yaml/customer-docs.yaml -g typescript-axios -o ./open-api-modules/customer-api-docs

ls

#!/bin/bash

stackName=${1:-${STACK_NAME}}
: ${stackName:?'Stack name env var or argument is required'}

echo "Getting CF stack '${stackName}' output variables"

# Get variables from stack output and export into env
outputs=$(aws cloudformation describe-stacks --stack-name ${stackName} --region ${AWS_REGION} | jq -r '.Stacks[0].Outputs')
outputsExpr=$(echo ${outputs} | jq -c '.[] |  [.OutputKey, .OutputValue] | join("=")' | sed "s/\"//g")
for i in ${outputsExpr}; do eval "${i}"; done
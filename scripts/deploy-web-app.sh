#!/bin/bash
# Deploy stacks with parameters using aws sam

: ${AWS_REGION:?'AWS_REGION env var or argument is required'}
: ${NETWORK_STACK_NAME:?'NETWORK_STACK_NAME env var or argument is required'}
: ${WEBAPP_STACK_NAME:?'WEBAPP_STACK_NAME env var or argument is required'}

# Get outputs from stack and set variables
. ./get-cfn-stack-output.sh ${NETWORK_STACK_NAME}

: ${VPCId:?"VPCId ${NETWORK_STACK_NAME} output is required"}

TemplateFile=../web-app.yaml
PackageFile=./.aws-sam/build/template.yaml

echo "Deploying stack ${WEBAPP_STACK_NAME}..."

sam build --template ${TemplateFile} && \

sam deploy --template-file ${PackageFile} \
    --stack-name ${WEBAPP_STACK_NAME} \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
    --region ${AWS_REGION} \
    --parameter-overrides \
        EnvNameParam=${ENVIRONMENT} \
        AppNameParam=${APP_NAME} \
        VPCIdParam=${VPCId} \
        PublicSubnetIdsParam="${PublicSubnet1},${PublicSubnet2}" \
        WepAppPrivateSubnetIdsParam="${PrivateSubnet1},${PrivateSubnet2}" \
        InstanceTypeParam=${INSTANCE_TYPE_NAME} \
        ImageIdParam=${IMAGE_ID} \
        KeyPairNameParam=${KEY_PAIR_NAME}
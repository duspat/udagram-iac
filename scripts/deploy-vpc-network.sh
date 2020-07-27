#!/bin/bash
# Deploy stacks with parameters using aws sam

: ${AWS_REGION:?'AWS_REGION env var or argument is required'}
: ${NETWORK_STACK_NAME:?'NETWORK_STACK_NAME env var or argument is required'}

TemplateFile=../vpc-network.yaml
PackageFile=./.aws-sam/build/template.yaml

echo "Deploying stack ${NETWORK_STACK_NAME}..."

sam build --template ${TemplateFile} && \

sam deploy --template-file ${PackageFile} \
    --stack-name ${NETWORK_STACK_NAME} \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
    --region ${AWS_REGION} \
    --parameter-overrides \
        EnvNameParam=${ENVIRONMENT} \
        VpcCIDRParam=${VPC_CIDR_BLOCK} \
        PrivateSubnet1CIDRParam=${VPC_PRIVATE_SUBNET_1_CIDR} \
        PrivateSubnet2CIDRParam=${VPC_PRIVATE_SUBNET_2_CIDR} \
        PublicSubnet1CIDRParam=${VPC_PUBLIC_SUBNET_1_CIDR} \
        PublicSubnet2CIDRParam=${VPC_PUBLIC_SUBNET_2_CIDR}
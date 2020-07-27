#!/bin/bash
# Only necessary if SSH is available for EC2

SSH_PUBLIC_KEY_FILE=${SSH_PUBLIC_KEY_FILE:-"~/.ssh/id_rsa.pub"}
KEY_PAIR_NAME=${KEY_PAIR_NAME:-"jump-box"}

aws ec2 import-key-pair --key-name "${KEY_PAIR_NAME}" --public-key-material "file://${SSH_PUBLIC_KEY_FILE}" --region ${AWS_REGION}

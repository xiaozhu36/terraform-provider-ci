#!/usr/bin/env bash

set -e

: ${ALICLOUD_ACCESS_KEY:?}
: ${ALICLOUD_SECRET_KEY:?}
: ${ALICLOUD_REGION:?}
: ${TEST_CASE_CODE:?}

export ALICLOUD_ACCESS_KEY=${ALICLOUD_ACCESS_KEY_ID}
export ALICLOUD_SECRET_KEY=${ALICLOUD_SECRET_KEY}
export ALICLOUD_REGION=${ALICLOUD_REGION}

CURRENT_PATH=$(pwd)

echo -e "******** run testcase start ********\n"

echo -e $CURRENT_PATH

TF_ACC=1 go test ./alicloud -v -run=TestAccAlicloud"$TEST_CASE_CODE" -timeout=120m

echo -e "******** run testcase end ********\n"

#CURRENT_PATH=$(pwd)
##WORK_PATH=$CURRENT_PATH/${ENVIRONMENT_DIR}
#SOURCE_PATH=$CURRENT_PATH/${ENVIRONMENT_DIR}
#TERRAFORM_PATH=$CURRENT_PATH/terraform
#TERRAFORM_MODULE=$SOURCE_PATH/ci/assets/terraform
##TERRAFORM_METADATA=$CURRENT_PATH/environment
#METADATA=metadata
#TERRAFORM_VERSION=0.10.8
#TERRAFORM_PROVIDER_VERSION=1.3.0

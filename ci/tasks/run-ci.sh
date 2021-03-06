#!/usr/bin/env bash

set -e

: ${ALICLOUD_ACCESS_KEY:?}
: ${ALICLOUD_SECRET_KEY:?}
: ${ALICLOUD_REGION:?}
: ${TEST_CASE_CODE:?}
: ${SWEEPER_CODE: ?}

export ALICLOUD_ACCESS_KEY=${ALICLOUD_ACCESS_KEY}
export ALICLOUD_SECRET_KEY=${ALICLOUD_SECRET_KEY}
export ALICLOUD_REGION=${ALICLOUD_REGION}

CURRENT_PATH=$(pwd)

ls -l $CURRENT_PATH

go version

cd $GOPATH
mkdir -p src/github.com/terraform-providers
cd src/github.com/terraform-providers
git clone https://github.com/terraform-providers/terraform-provider-alicloud.git
cd terraform-provider-alicloud

echo -e "******** run testcase start ********\n"

TF_ACC=1 go test ./alicloud -v -run=TestAccAlicloud${TEST_CASE_CODE} -timeout=120m

echo -e "******** run testcase end ********\n"

if [[ ${SWEEPER_CODE} != "" ]]; then
echo -e "******** run sweeper test ${SWEEPER_CODE} start ********\n"
TF_ACC=1 go test ./alicloud -v  -sweep=${ALICLOUD_REGION} -sweep-run=${SWEEPER_CODE}
echo -e "******** run sweeper test ${SWEEPER_CODE} end ********\n"
fi


#CURRENT_PATH=$(pwd)
##WORK_PATH=$CURRENT_PATH/${ENVIRONMENT_DIR}
#SOURCE_PATH=$CURRENT_PATH/${ENVIRONMENT_DIR}
#TERRAFORM_PATH=$CURRENT_PATH/terraform
#TERRAFORM_MODULE=$SOURCE_PATH/ci/assets/terraform
##TERRAFORM_METADATA=$CURRENT_PATH/environment
#METADATA=metadata
#TERRAFORM_VERSION=0.10.8
#TERRAFORM_PROVIDER_VERSION=1.3.0

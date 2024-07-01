#!/bin/bash


helpFunction()
{
   echo ""
   echo "Usage: generateTestVariablesFile.sh -c cluster -r repo -b branch -p product"
   echo -e "\t-c Cluster to run the tests against it"
   echo -e "\t-r Repo where the configuration for the tests is being stored"
   echo -e "\t-b Branch of the configuration repo"
   echo -e "\t-p Product installed in the cluster (RHODS, ODH)"
   exit 1 # Exit script after printing help
}

while getopts "c:r:b:" opt
do
   case "$opt" in
      c ) CLUSTER="$OPTARG" ;;
      r ) REPO="$OPTARG" ;;
      b ) BRANCH="$OPTARG" ;;
      p ) PRODUCT="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

if [ -z "$CLUSTER" ]
then
   echo "CLUSTER parameter is mandatory";
   helpFunction
fi

REPO="${REPO:-https://gitlab.cee.redhat.com/ods/odhcluster.git}"
BRANCH="${VARIABLE:-master}"
PRODUCT=${PRODUCT:-RHODS}
GH_USER=rhodsjenkins

ODS_CI_PATH=$(find . -name ods_ci)
TEST_VARIABLES_FILE="$ODS_CI_PATH"/utils/scripts/testconfig/test-variables.yml

python --directory "$ODS_CI_PATH" run python -u "$ODS_CI_PATH"/utils/scripts/testconfig/generateTestConfigFile.py -u "$GH_USER" -p **** -t "$CLUSTER" -r "$REPO" -b "$BRANCH" -d "$PWD"/odhcluster -c "$TEST_VARIABLES_FILE" -s --components dashboard:Managed,datasciencepipelines:Managed,ray:Managed,codeflare:Managed,modelmeshserving:Managed,workbenches:Managed,kserve:Managed,trustyai:Managed,kueue:Managed,trainingoperator:Removed

if [ "$PRODUCT" == "RHODS" ]; then
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
    sed -i 's/OPERATOR_NAME:*/OPERATOR_NAME: rhods-operator/g' "$TEST_VARIABLES_FILE"
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
elif [ "$PRODUCT" == "ODH" ]; then
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
else
    echo -e "Wrong product: $PRODUCT. Only RHODS and ODH are accepted as values"
    exit 1
fi

// Set the RHODS namespace as per the RHODS or ODH product
        if ("${product}" == "ODH") {
            testConfigData."PRODUCT" = "${product}"
            testConfigData."OPERATOR_NAME" = "opendatahub-operator"
            testConfigData."APPLICATIONS_NAMESPACE" = "opendatahub"
            testConfigData."MONITORING_NAMESPACE" = "opendatahub"
            testConfigData."OPERATOR_NAMESPACE" = "opendatahub-operators"
            testConfigData."NOTEBOOKS_NAMESPACE" = "opendatahub"
        } else if ("${product}" == "RHODS") {
            testConfigData."PRODUCT" = "${product}"
            testConfigData."OPERATOR_NAME" = "rhods-operator"
            testConfigData."APPLICATIONS_NAMESPACE" = "redhat-ods-applications"
            testConfigData."MONITORING_NAMESPACE" = "redhat-ods-monitoring"
            testConfigData."OPERATOR_NAMESPACE" = "redhat-ods-operator"
            testConfigData."NOTEBOOKS_NAMESPACE" = "rhods-notebooks"
        }

#!/bin/bash


helpFunction()
{
   echo ""
   echo "Usage: generateTestVariablesFile.sh -c cluster -p product"
   echo -e "\t-c Cluster to run the tests against it"
   echo -e "\t-p Product installed in the cluster (RHODS, ODH)"
   exit 1 # Exit script after printing help
}

while getopts "c:r:b:p:" opt
do
   case "$opt" in
      c ) CLUSTER="$OPTARG" ;;
      p ) PRODUCT="$OPTARG" ;;
      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

if [ -z "$CLUSTER" ]
then
   echo "CLUSTER parameter is mandatory";
   helpFunction
fi

REPO=https://gitlab.cee.redhat.com/ods/odhcluster.git
BRANCH=master
PRODUCT=${PRODUCT:-RHODS}
GH_USER=rhodsjenkins

ODS_CI_PATH=$(find . -name ods_ci)
TEST_VARIABLES_FILE="$ODS_CI_PATH"/utils/scripts/testconfig/test-variables.yml

python --directory "$ODS_CI_PATH" run python -u "$ODS_CI_PATH"/utils/scripts/testconfig/generateTestConfigFile.py -u "$GH_USER" -p **** -t "$CLUSTER" -r "$REPO" -b "$BRANCH" -d "$PWD"/odhcluster -c "$TEST_VARIABLES_FILE" -s --components dashboard:Managed,datasciencepipelines:Managed,ray:Managed,codeflare:Managed,modelmeshserving:Managed,workbenches:Managed,kserve:Managed,trustyai:Managed,kueue:Managed,trainingoperator:Removed

if [ "$PRODUCT" == "RHODS" ]; then
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
    sed -i 's/OPERATOR_NAME:*/OPERATOR_NAME: rhods-operator/g' "$TEST_VARIABLES_FILE"
    sed -i 's/APPLICATIONS_NAMESPACE:*/APPLICATION_NAMESPACE: redhat-ods-applications/g' "$TEST_VARIABLES_FILE"
    sed -i 's/MONITORING_NAMESPACE:*/MONITORING_NAMESPACE: redhat-ods-monitoring/g' "$TEST_VARIABLES_FILE"
    sed -i 's/OPERATOR_NAMESPACE:*/OPERATOR_NAMESPACE: redhat-ods-operator/g' "$TEST_VARIABLES_FILE"
    sed -i 's/NOTEBOOKS_NAMESPACE:*/NOTEBOOKS_NAMESPACE: rhods-notebooks/g' "$TEST_VARIABLES_FILE"
elif [ "$PRODUCT" == "ODH" ]; then
    sed -i 's/PRODUCT:*/PRODUCT: $PRODUCT/g' "$TEST_VARIABLES_FILE"
    sed -i 's/OPERATOR_NAME:*/OPERATOR_NAME: opendatahub-operator/g' "$TEST_VARIABLES_FILE"
    sed -i 's/APPLICATIONS_NAMESPACE:*/APPLICATION_NAMESPACE: opendatahub/g' "$TEST_VARIABLES_FILE"
    sed -i 's/MONITORING_NAMESPACE:*/MONITORING_NAMESPACE: opendatahub/g' "$TEST_VARIABLES_FILE"
    sed -i 's/OPERATOR_NAMESPACE:*/OPERATOR_NAMESPACE: opendatahub-operators/g' "$TEST_VARIABLES_FILE"
    sed -i 's/NOTEBOOKS_NAMESPACE:*/NOTEBOOKS_NAMESPACE: opendatahub/g' "$TEST_VARIABLES_FILE"
else
    echo -e "Wrong product: $PRODUCT. Only RHODS and ODH are accepted as values"
    exit 1
fi

cat "$TEST_VARIABLES_FILE"

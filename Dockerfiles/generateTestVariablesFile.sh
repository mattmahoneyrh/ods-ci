#!/bin/bash


helpFunction()
{
   echo ""
   echo "Usage: generateTestVariablesFile.sh -c cluster -r repo -b branch"
   echo -e "\t-c Cluster to run the tests against it"
   echo -e "\t-r Repo where the configuration for the tests is being stored"
   echo -e "\t-b Branch of the configuration repo"
   exit 1 # Exit script after printing help
}

while getopts "c:r:b:" opt
do
   case "$opt" in
      c ) CLUSTER="$OPTARG" ;;
      r ) REPO="$OPTARG" ;;
      b ) BRANCH="$OPTARG" ;;
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
GH_USER=rhodsjenkins

ODS_CI_PATH=$(find . -name ods_ci)

python --directory "$ODS_CI_PATH" run python -u "$ODS_CI_PATH"/utils/scripts/testconfig/generateTestConfigFile.py -u "$GH_USER" -p **** -t "$CLUSTER" -r "$REPO" -b "$BRANCH" -d "$PWD"/odhcluster -c "$ODS_CI_PATH"/utils/scripts/testconfig/test-variables.yml -s --components dashboard:Managed,datasciencepipelines:Managed,ray:Managed,codeflare:Managed,modelmeshserving:Managed,workbenches:Managed,kserve:Managed,trustyai:Managed,kueue:Managed,trainingoperator:Removed

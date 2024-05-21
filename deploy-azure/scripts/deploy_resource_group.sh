#! /bin/bash

LOCATION="westeurope"
TEMPLATE_FILE="resourceGroup.bicep"

az deployment sub create --name resourceGroupDeploy --location $LOCATION --template-file $TEMPLATE_FILE

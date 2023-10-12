#!/bin/bash

location="westus"
resource_group_name="airlift001"

az group create --name "rg-${resource_group_name}" --location "${location}" --tags "TeamName=DevOps"

az deployment group create --name "${resource_group_name}" --resource-group "rg-${resource_group_name}" --template-file "./bicep/main.bicep" --parameters "./bicep/main.bicepparam"

#!/bin/bash

location="eastus2"
resource_group_name="airlift2025"

az group create --name "${resource_group_name}" --location "${location}" --tags "TeamName=DevOps"

az deployment group create --name "${resource_group_name}" --resource-group "rg-${resource_group_name}" --template-file "./bicep/main.bicep"

#!/bin/bash

location="westus"
resource_group_name="airlift_${environmentName}"

output=$(az deployment group show --resource-group "rg-${resource_group_name}" --name "${resource_group_name}" --query "properties.outputs" --output "json")

appServiceName=$(echo $output | jq -r '.appServiceName.value')
sqlServerName=$(echo $output | jq -r '.sqlServerName.value')

connectionStrings=$(az webapp config connection-string list --name "${appServiceName}" --resource-group "rg-${resource_group_name}")

catalogConnectionString=$(echo $connectionStrings | jq -r '.[] | select(.name == "CatalogConnection") | .value')
identityConnectionString=$(echo $connectionStrings | jq -r '.[] | select(.name == "IdentityConnection") | .value')

if [[ $catalogConnectionString == *"${sqlServerName}"* ]]; then
  echo "CatalogConnection string contains ${sqlServerName}"
else
  echo "CatalogConnection string is not correct 😦"
  exit 1
fi

if [[ $identityConnectionString == *"${sqlServerName}"* ]]; then
  echo "IdentityConnection string contains ${sqlServerName}"
else
  echo "IdentityConnection string is not correct 😦"
  exit 1
fi

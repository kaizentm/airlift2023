using './main.bicep'

param environmentName = 'dev'
param acrName = 'acrairlift2023'
param dockerImage = 'acrairlift2023.azurecr.io/eshopwebmvc'
param acrResourceGroupName = 'rg-airlift2023'

param sqlServerAdministratorPassword = readEnvironmentVariable('sqlServerAdministratorPassword')

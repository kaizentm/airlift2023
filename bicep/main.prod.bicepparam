using './main.bicep'

param environmentName = 'prod'
param acrName = 'acrairlift2023'
param dockerImage = 'acrairlift2023.azurecr.io/eshopwebmvc'
param acrResourceGroupName = 'rg-airlift2023'

param webAppSize = 'Standard_P3V3'

param sqlServerAdministratorPassword = readEnvironmentVariable('sqlServerAdministratorPassword')

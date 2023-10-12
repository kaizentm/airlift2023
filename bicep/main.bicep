param environmentName string = 'dev'
param acrName string
param acrResourceGroupName string
param dockerImage string

@secure()
param sqlServerAdministratorPassword string

module sql_layer '01_sql/02_deployment/main.bicep' = {
  name: 'sql_layer'
  params: {
    environment: environmentName
    layerName: 'sql_layer'
    deploymentName: 'sql_layer'
    location: resourceGroup().location
    sqlServerAdministratorLogin: 'sqladmin'
    sqlServerAdministratorPassword: sqlServerAdministratorPassword
  }
}

module web_layer '02_webapp/02_deployment/main.bicep' = {
  name: 'web_layer'
  params: {
    environment: environmentName
    layerName: 'web_layer'
    deploymentName: 'web_layer'
    location: resourceGroup().location
    sqlServerAdministratorLogin: sql_layer.outputs.sqlServerAdministratorLogin
    sqlDatabaseCatalogDbName: sql_layer.outputs.sqlDatabaseCatalogDbName
    sqlDatabaseIdentityDbName: sql_layer.outputs.sqlDatabaseIdentityDbName
    sqlServerAdministratorPassword: sql_layer.outputs.sqlServerAdministratorPassword
    appSvcDockerImage: dockerImage
    appSvcDockerImageTag: 'latest'
    appSvcPlanSkuName: 'B1'
    appSvcPlanSkuTier: 'Basic'
    containerRegistryName: acrName
    containerRegistryResourceGroupName: acrResourceGroupName
    sqlServerFqdn: sql_layer.outputs.sqlServerFqdn
  }
}

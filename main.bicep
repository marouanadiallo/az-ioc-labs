// params and their default value
param location string = 'westeurope'

@minLength(5)
@maxLength(30)
@description('The unique name of the solution. This is used to ensure that resource names are unique.')
param solutionName string = 'toyhr${uniqueString(resourceGroup().id)}'

@minValue(1)
@maxValue(10)
@description('The number of App Service plan instances.')
param appServicePlanInstanceCount int = 1

@description('The name and tier of the App Service plan SKU.')
param appServicePlanSku object 


param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'

@secure()
@description('The administrator login username for the SQL server.')
param sqlServerAdministratorLogin string

@secure()
@description('The administrator login password for the SQL server.')
param sqlServerAdministratorPassword string

@description('The name and tier of the SQL database SKU.')
param sqlDatabaseSku object

@allowed([
  'dev'
  'test'
  'prod'
])
@description('The name of the environment. This must be dev, test, or prod.')
param environmentType string

// vars
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'
var appServicePlanName = '${environmentType}-${solutionName}-plan'
var appServiceAppName string = '${environmentType}-${solutionName}-app'

var sqlServerName string = toLower('${environmentType}-${solutionName}-sqlsrv')
var sqlDatabaseName string = 'EmployeesDB'

// resource: storage account
resource storageAcc 'Microsoft.Storage/storageAccounts@2025-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

// using appservie module
module appService 'modules/appService.bicep' = {
  name: 'appService'
  params: {
    location: location
    appserviceAppName: appServiceAppName
    appServicePlanSku: appServicePlanSku
    appServicePlanName: appServicePlanName
    appServicePlanCapacity: appServicePlanInstanceCount
  }
}

// using dbSqlServer module
module sqlDb 'modules/dbSqlServer.bicep' = {
  name: 'sqlDb'
 params: {
  location: location
  sqlDatabaseName: sqlDatabaseName
  sqlServerName: sqlServerName
  sqlDatabeSku: sqlDatabaseSku
  sqlServerAdministratorLogin: sqlServerAdministratorLogin
  sqlServerAdministratorLoginPassword: sqlServerAdministratorPassword
 }
}

// outputs
output appServiceAppHostName string = appService.outputs.appServiceAppHostName

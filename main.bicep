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


param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'

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
    appServicePlanName: appServicePlanName
    appServicePlanCapacity: appServicePlanInstanceCount
  }
}

// outputs
output appServiceAppHostName string = appService.outputs.appServiceAppHostName

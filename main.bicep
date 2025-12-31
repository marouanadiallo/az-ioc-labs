// params and their default value
param location string = 'westeurope'
param storageAccountName string = 'toylaunch${uniqueString(resourceGroup().id)}'
param appServiceAppName string = 'toylaunch${uniqueString(resourceGroup().id)}'

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

// vars
var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

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
    environmentType: environmentType
  }
}

// outputs
output appServiceAppHostName string = appService.outputs.appServiceAppHostName

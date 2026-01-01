@description('The Azure region into which the resources should be deployed.')
param location string

param appserviceAppName string
param appServicePlanCapacity int 
param appServicePlanName string = 'toy-product-launchplan'

@description('The name and tier of the App Service plan SKU.')
param appServicePlanSku object = {
  name: 'F1'
  tier: 'Free'
}


// resource: app service plan
resource appServicePlan 'Microsoft.Web/serverfarms@2025-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku.name
    tier: appServicePlanSku.tier
    capacity: appServicePlanCapacity
  }
}

// resource: app service app
resource appServiceApp 'Microsoft.Web/sites@2025-03-01' = {
  name: appserviceAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

// module outputs
output appServiceAppHostName string = appServiceApp.properties.defaultHostName




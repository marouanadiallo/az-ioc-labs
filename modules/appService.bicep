param location string
param appserviceAppName string

@allowed([
  'nonprod'
  'prod'
])
param environmentType string

var appServicePlanName = 'toy-product-launchplan'
var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

// resource: app service plan
resource appServicePlan 'Microsoft.Web/serverfarms@2025-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSkuName
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




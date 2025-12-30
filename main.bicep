resource storageAcc 'Microsoft.Storage/storageAccounts@2025-06-01' = {
  name: 'toylaunchstrg'
  location: 'westeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2025-03-01' = {
  name: 'toy-product-lplan'
  location: 'westeurope'
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2025-03-01' = {
  name: 'toy-product-lapp'
  location: 'westeurope'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

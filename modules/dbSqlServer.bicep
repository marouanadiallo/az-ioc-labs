param location string = resourceGroup().location

@secure()
@description('The administrator login for the SQL Server.')
param sqlServerAdministratorLogin string

@secure()
@description('The administrator login password for the SQL Server.')
param sqlServerAdministratorLoginPassword string

@description('The name and tier of the SQL Database SKU.')
param sqlDatabeSku object

@minLength(3)
@maxLength(63)
@description('The name of the SQL Server.')
param sqlServerName string

@minLength(3)
@maxLength(63)
@description('The name of the SQL Database.')
param sqlDatabaseName string

// database server resource
resource slqServer 'Microsoft.Sql/servers@2024-11-01-preview' = {
  name: sqlServerName
  location:location
  properties: {
    administratorLogin: sqlServerAdministratorLogin
    administratorLoginPassword: sqlServerAdministratorLoginPassword
  }
}

// database resource
resource sqlDatabase 'Microsoft.Sql/servers/databases@2024-11-01-preview' = {
  name: sqlDatabaseName
  location: location
  parent: slqServer
  sku: {
    name: sqlDatabeSku.name
    tier: sqlDatabeSku.tier
  }
}

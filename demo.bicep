// PARAMETERS:
param location string = resourceGroup().location
param accessTier string = 'Hot'
@allowed([
  'Hot'
  'Cold'
])

@description('Name of project that needs storage')
param projectName string

// VARIABLES:
var storageName = 'f3stgdemo${projectName}'
var sharedRg = 'bicep-demo-rg'
var vnetName = 'bicep-demo-vnet'

// EXISTING RESOURCES:
resource vnet 'Microsoft.Network/virtualNetworks@2022-01-01' existing = {
  name: vnetName
  scope: resourceGroup(sharedRg)
}

// NEW RESOURCES:
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: accessTier
  }
}

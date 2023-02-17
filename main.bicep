targetScope = 'subscription'

@description('Parameter for Allowed locations')
param policyAssignmentNameAl string = 'Allowed locations - Japan'
param policyDefinitionIDAl string = '/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c'
param valueAL array = [ 'japaneast', 'japanwest' ]

@description('Parameter for Allowed virtual machine size SKUs')
param policyAssignmentNameVM string = 'Allowed virtual machine size SKUs - b1s,b1ms'
param policyDefinitionIDVM string = '/providers/Microsoft.Authorization/policyDefinitions/cccc23c7-8427-4f53-ad12-b6a63eb452b3'
param valueVM array = [ 'Standard_b1ms', 'Standard_b1s' ]

param policyValues object = {
  AL: {
    name: policyAssignmentNameAl
    policyDefinitionId: policyDefinitionIDAl
    parameters: {
      listOfAllowedLocations: {
        value: valueAL
      }
    }
  }
  AVM: {
    name: policyAssignmentNameVM
    policyDefinitionId: policyDefinitionIDVM
    parameters: {
      listOfAllowedSKUs: {
        value: valueVM
      }
    }
  }
}

resource assignment 'Microsoft.Authorization/policyAssignments@2022-06-01' = [for policy in items(policyValues): {
  name: policy.value.name
  properties: {
    policyDefinitionId: policy.value.policyDefinitionID
    parameters: policy.value.parameters
  }
}]

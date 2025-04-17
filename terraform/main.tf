terraform{
    required_providers {
      azurerm={
        source ="hashicorp/azurerm"
        version = ">=3.0.0"
      }
    }
    required_version = ">=1.0.0"
}

provider "azurerm"{
    subscription_id = "3b70b1bc-e71c-411d-8e1c-5581934e526c"
    features{

    }
}

resource "azurerm_resource_group" "Example"{
    name= "codecraft-resource-grp"
    location="Central India"
}

resource "azurerm_container_registry" "codecraft_acr"{
    name = "codecraftacr"
    resource_group_name = "codecraft-resource-grp"
    location = "Central India"
    sku = "Basic"
    admin_enabled = false
}

resource "azurerm_kubernetes_cluster" "codecraft_aks"{
    name ="codecraft_aks"
    location = azurerm_resource_group.Example.location
    resource_group_name = azurerm_resource_group.Example.name
    dns_prefix = "codecraft"
    
    default_node_pool{
        name = "default"
        node_count = 2
        vm_size = "Standard_DS2_v2"
    }
    identity{
        type = "SystemAssigned"
    }
}

resource "azurerm_role_assignment" "aks_acr_pull"{
    scope = azurerm_container_registry.codecraft_acr.id
    role_definition_name ="AcrPull"
    principal_id = azurerm_kubernetes_cluster.codecraft_aks.identity[0].principal_id


}

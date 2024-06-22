resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "app_rg" {
  name     = "rg-${var.app_name}-${var.env}"
  location = var.azure_region
}

resource "azurerm_service_plan" "app_sp" {
  name                = "app-sp-${var.app_name}-${var.env}"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "app_svc" {
  name                = "app-svc-${var.app_name}-${var.env}"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  service_plan_id     = azurerm_service_plan.app_sp.id

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
  }
}

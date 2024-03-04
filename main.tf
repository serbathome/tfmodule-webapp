
resource "random_string" "random" {
  length  = 5
  special = false
  numeric = true
  upper   = false
  lower   = true
}

resource "azurerm_resource_group" "group" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_service_plan" "service_plan" {
  name                = "${var.service_plan_name}-${random_string.random.result}"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "web_app" {
  name                = "${var.web_app_name}-${random_string.random.result}"
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  service_plan_id     = azurerm_service_plan.service_plan.id
  site_config {
    always_on = false
  }
}


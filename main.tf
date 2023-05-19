resource "azurerm_resource_group" "tp-exercise" {
  for_each = var.environments
  name     = "${each.key}-terraform-servicebus"
  location = "West Europe"
}

/*
resource "azurerm_servicebus_namespace" "tp-exercise" {
  for_each = var.environments
  name                = "${each.key}--${each.value.asbn_names}-servicebus-namespace"
  location            = azurerm_resource_group.tp-exercise[0].location
  resource_group_name = azurerm_resource_group.tp-exercise[0].name
  sku                 = "Standard"

  tags = {
    costcentre = "terraform"
    procuctname = "tp-exercise"
  }
}
*/

/*
resource "azurerm_servicebus_queue" "tp-exercise" {
  name         = "tfex_servicebus_queue"
  namespace_id = azurerm_servicebus_namespace.tp-exercise.id

  enable_partitioning = true
}

resource "azurerm_servicebus_queue" "tp-exercise2" {
  name         = "tfex_servicebus_queue2"
  namespace_id = azurerm_servicebus_namespace.tp-exercise.id

  enable_partitioning = true
}

resource "azurerm_management_lock" "resource-group-level" {
  name       = "resource-group-level"
  scope      = azurerm_resource_group.tp-exercise.id
  lock_level = "ReadOnly"
  notes      = "This Resource Group is Read-Only"
}

*/

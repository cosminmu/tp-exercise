resource "azurerm_resource_group" "tp-exercise" {
  name     = "${terraform.workspace}-tpex-terraform-servicebus"
  location = "West Europe"
}

resource "azurerm_servicebus_namespace" "tp-exercise" {
  name                = "${terraform.workspace}-tpex-servicebus-namespace"
  location            = azurerm_resource_group.tp-exercise.location
  resource_group_name = azurerm_resource_group.tp-exercise.name
  sku                 = "Standard"

  tags = {
    costcentre = "${terraform.workspace}-terraform"
    productname = "tp-exercise"
  }
}

resource "azurerm_servicebus_queue" "tp-exercise" {
  name         = "${terraform.workspace}-tpex_servicebus_queue"
  namespace_id = azurerm_servicebus_namespace.tp-exercise.id

  enable_partitioning = true
}

resource "azurerm_servicebus_queue" "tp-exercise1" {
  name         = "${terraform.workspace}-tpex_servicebus_queue2"
  namespace_id = azurerm_servicebus_namespace.tp-exercise.id

  enable_partitioning = true
}
 
resource "azurerm_management_lock" "resource-group-level" {
  name       = "resource-group-level"
  scope      = azurerm_resource_group.tp-exercise.id
  lock_level = "ReadOnly"
  notes      = "This Resource Group is Read-Only"
}

resource "azurerm_resource_group" "tp-exercise2" {
  name     = "${terraform.workspace}-tpex2-terraform-servicebus"
  location = "West Europe"
}

resource "azurerm_servicebus_namespace" "tp-exercise2" {
  name                = "${terraform.workspace}-tpex2-servicebus-namespace"
  location            = azurerm_resource_group.tp-exercise2.location
  resource_group_name = azurerm_resource_group.tp-exercise2.name
  sku                 = "Standard"

  tags = {
    costcentre = "${terraform.workspace}-terraform"
    productname = "tp-exercise"
  }
}

resource "azurerm_servicebus_queue" "tp-exercise2" {
  name         = "${terraform.workspace}-tpex2_servicebus_queue"
  namespace_id = azurerm_servicebus_namespace.tp-exercise2.id

  enable_partitioning = true
}

resource "azurerm_servicebus_queue" "tp-exercise2-1" {
  name         = "${terraform.workspace}-tpex2_servicebus_queue2"
  namespace_id = azurerm_servicebus_namespace.tp-exercise2.id

  enable_partitioning = true
}

resource "azurerm_management_lock" "resource-group-level2" {
  name       = "resource-group-level"
  scope      = azurerm_resource_group.tp-exercise2.id
  lock_level = "ReadOnly"
  notes      = "This Resource Group is Read-Only"
}

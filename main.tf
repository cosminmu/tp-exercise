locals {
	environments = [ "test", "staging", "prod" ]
	asbns = {
		asbn1 = {
			name = "a1"
      location = "West Europe"
			queues = {
				q1 = {
					name = "q11"
				}
				q2 = {
					name = "q12"
				}
			}
		}
		asbn2 = {
			name = "a2"
      location = "West Europe"
			queues = {
				q1 = {
					name = "q21"
				}
				q2 = {
					name = "q22"
				}
			}
		}
	}
 
	asbn_list = flatten([
		for e in local.environments : [
			for a in local.asbns : {
				"name"  : a.name
        "location" : a.location
				"env"   : e
        "key"   : "${e}-${a.name}"
			}
		]
	])
 
	queue_list = flatten([
		for e in local.environments : [
			for a in local.asbns : [
				for q in a.queues : {
				"name"  : q.name
        "asbn-name" : a.name
        "location" : a.location
				"env"   : e
        "key"   : "${e}-${a.name}-${q.name}"
        "asbn-key" : "${e}-${a.name}"
				}
			]
		]
	])
}

resource "azurerm_resource_group" "tp-exercise" {
  for_each = {
    for asbn in local.asbn_list : asbn.key => asbn
  }
  name     = "${each.value.env}-${each.value.name}-terraform-servicebus"
  location = each.value.location
}


resource "azurerm_servicebus_namespace" "tp-exercise" {
  for_each = {
    for asbn in local.asbn_list : asbn.key => asbn
  }  
  name                = "${each.value.env}-${each.value.name}-servicebus-namespace"
  location            = each.value.location
  resource_group_name = "${each.value.env}-${each.value.name}-terraform-servicebus"
  sku                 = "Standard"

  tags = {
    costcentre = "terraform"
    procuctname = "tp-exercise"
  }
}



resource "azurerm_servicebus_queue" "tp-exercise" {
    for_each = {
      for queue in local.queue_list : queue.key => queue
  }  
  name         = "${each.value.env}-${each.value.asbn-name}-${each.value.name}_servicebus_queue"
  namespace_id = azurerm_servicebus_namespace.tp-exercise[each.value.asbn-key].id

  enable_partitioning = true
}

/*
resource "azurerm_management_lock" "resource-group-level" {
  name       = "resource-group-level"
  scope      = azurerm_resource_group.tp-exercise.id
  lock_level = "ReadOnly"
  notes      = "This Resource Group is Read-Only"
}

*/

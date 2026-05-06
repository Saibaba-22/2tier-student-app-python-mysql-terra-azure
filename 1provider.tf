# version setting block 

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.56.0"
    }
  }
}

# provider block 
provider "azurerm" {
  features {}
    # configuration options
    client_id = "CLIENT_ID"
    client_secret = "CLIENT-SECRET"
    tenant_id = "TENANT_ID"
    subscription_id = "SUBCRIPTION_ID"
}


/*
# backend block 
terraform {
  backend "azurerm" {
    access_key = "Access_key"
    storage_account_name = "storage_account_name"
    container_name = "container_name"
    key = "prod.terraform.tfstate"
  }
}
*/
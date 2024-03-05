# Terraform Digital Ocean Policy Index


This document provides a comprehensive index of Terraform policies available in BrainIAC(Terraform Digital Ocean).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TFDIO_001 | resource | digitalocean_spaces_bucket | Confirm that versioning is activated for the Spaces bucket | checker/terraform/rules/dio/digitalocean_spaces_bucket_versioning_active.rego |
| CB_TFDIO_002 | resource | digitalocean_droplet | Confirm that the droplet is configured with an SSH key | checker/terraform/rules/dio/digitalocean_droplet_ssh_key_specified.rego |
| CB_TFDIO_003 | resource | digitalocean_spaces_bucket | Confirm the Spaces bucket has restricted access settings | checker/terraform/rules/dio/digitalocean_spaces_bucket_private.rego |
| CB_TFDIO_004 | resource | digitalocean_firewall | Confirm that firewall allows only specific and trusted inbound traffic | checker/terraform/rules/dio/digitalocean_firewall_ingress_not_open.rego |
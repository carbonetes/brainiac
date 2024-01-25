# Terraform Linode Policy Index


This document provides a comprehensive index of Terraform policies available in BrainIAC(Terraform Linode).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TFLIN_001 | resource | linode_instance | Verify that an SSH key is configured within the authorized_keys file | checker/terraform/rules/lin/linode_instance_ssh_key_authorized.rego |
| CB_TFLIN_002 | resource | linode_user | Verify that email is configured | checker/terraform/rules/lin/linode_user_email_set.rego |
| CB_TFLIN_003 | resource | linode_user | Verify that username is configured | checker/terraform/rules/lin/linode_user_username_set.rego |
| CB_TFLIN_004 | resource | linode_firewall | Verify that the Inbound Firewall Policy is configured to a value other than ACCEPT | checker/terraform/rules/lin/linode_firewall_inbound_not_set_accept.rego |
| CB_TFLIN_005 | resource | linode_firewall | Verify that the Outbound Firewall Policy is configured to a value other than ACCEPT | checker/terraform/rules/lin/linode_firewall_outbound_not_set_accept.rego |
| CB_TFLIN_006 | resource | linode | Verify that Linode tokens are not hardcoded within the provider configuration | checker/terraform/rules/lin/linode_provider_no_hardcoded.rego |
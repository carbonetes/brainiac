# Terraform OPENSTACK Policy Index


This document provides a comprehensive index of Terraform policies available in BrainIAC(Terraform OPENSTACK).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TFOPENSTACK_001 | resource | openstack | Verify that there are no static OpenStack credentials, such as passwords, tokens, or application_credential_secrets, present in the provider configuration | checker/terraform/rules/openstack/openstack_no_hardcoded_password_token_credential.rego |
| CB_TFOPENSTACK_002 | resource | openstack_compute_secgroup_v2 | Verify that security groups don't permit incoming traffic from 0.0.0.0:0 to port 22 (TCP/UDP) | checker/terraform/rules/openstack/openstack_compute_secgroup_v2_ingress_port_22.rego |
| CB_TFOPENSTACK_002 | resource | openstack_networking_secgroup_rule_v2 | Verify that security groups don't permit incoming traffic from 0.0.0.0:0 to port 22 (TCP/UDP) | checker/terraform/rules/openstack/openstack_compute_secgroup_v2_ingress_port_22.rego |
| CB_TFOPENSTACK_003 | resource | openstack_compute_secgroup_v2 | Verify that security groups don't permit incoming traffic from 0.0.0.0:0 to port 3389 (TCP/UDP) | checker/terraform/rules/openstack/openstack_compute_secgroup_v2_ingress_port_3389.rego |
| CB_TFOPENSTACK_003 | resource | openstack_networking_secgroup_rule_v2 | Verify that security groups don't permit incoming traffic from 0.0.0.0:0 to port 3389 (TCP/UDP) | checker/terraform/rules/openstack/openstack_compute_secgroup_v2_ingress_port_3389.rego |
| CB_TFOPENSTACK_004 | resource | openstack_compute_instance_v2 | Verify that the instance doesn't employ basic credentials | checker/terraform/rules/openstack/openstack_compute_instance_v2_basic_cred_not_allowed.rego |
| CB_TFOPENSTACK_005 | resource | openstack_fw_rule_v1 | Verify that firewall rules define a destination IP address | checker/terraform/rules/openstack/openstack_fw_rule_v1_destination_ip.rego |
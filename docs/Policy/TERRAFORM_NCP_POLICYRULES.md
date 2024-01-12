# Terraform NCP Policy Index


This document provides a comprehensive index of Terraform policies available in BrainIAC(Terraform NCP).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TFNCP_001 | resource | ncloud_lb_target_group | Verify that the target group using HTTP or HTTPS protocols has a specified health check | checker/terraform/rules/ncp/ncloud_lb_target_group_http_https_healthcheck.rego |
| CB_TFNCP_002 | resource | ncloud_access_control_group | Make certain that each rule in the access control groups is accompanied by a description | checker/terraform/rules/ncp/ncloud_access_control_group_description.rego |
| CB_TFNCP_002 | resource | ncloud_access_control_group_rule | Make certain that each rule in the access control groups is accompanied by a description | checker/terraform/rules/ncp/ncloud_access_control_group_description.rego |
| CB_TFNCP_003 | resource | ncloud_access_control_group_rule | Prevent security group rules from permitting outbound traffic to the IP address range 0.0.0.0/0 | checker/terraform/rules/ncp/ncloud_access_control_group_rule_outbound_traffic.rego |
| CB_TFNCP_004 | resource | ncloud_access_control_group_rule | Confirm that there are no access control groups permitting inbound traffic from IP address 0.0.0.0 on port 22 | checker/terraform/rules/ncp/ncloud_access_control_group_rule_inbound_port_22.rego |
| CB_TFNCP_005 | resource | ncloud_access_control_group_rule | Confirm that there are no access control groups permitting inbound traffic from IP address 0.0.0.0 on port 3389 | checker/terraform/rules/ncp/ncloud_access_control_group_rule_inbound_port_3389.rego |
| CB_TFNCP_006 | resource | ncloud_server | Verify that the server instance is protected through encryption | checker/terraform/rules/ncp/ncloud_server_server_instance_encrypted.rego |
| CB_TFNCP_007 | resource | ncloud_launch_configuration | Verify that the Basic Block storage is protected through encryption | checker/terraform/rules/ncp/ncloud_launch_configuration_block_storage_encrypted.rego |
| CB_TFNCP_008 | resource | ncloud_network_acl_rule | Make certain that there are no Network Access Control Lists (NACLs) permitting inbound traffic from the IP address 0.0.0.0 to port 20 | checker/terraform/rules/ncp/ncloud_network_acl_rule_inbound_port_20.rego |
| CB_TFNCP_009 | resource | ncloud_network_acl_rule | Make certain that there are no Network Access Control Lists (NACLs) permitting inbound traffic from the IP address 0.0.0.0 to port 21 | checker/terraform/rules/ncp/ncloud_network_acl_rule_inbound_port_21.rego |
| CB_TFNCP_010 | resource | ncloud_network_acl_rule | Make certain that there are no Network Access Control Lists (NACLs) permitting inbound traffic from the IP address 0.0.0.0 to port 22 | checker/terraform/rules/ncp/ncloud_network_acl_rule_inbound_port_22.rego |
| CB_TFNCP_011 | resource | ncloud_network_acl_rule | Make certain that there are no Network Access Control Lists (NACLs) permitting inbound traffic from the IP address 0.0.0.0 to port 3389 | checker/terraform/rules/ncp/ncloud_network_acl_rule_inbound_port_3389.rego |
| CB_TFNCP_012 | resource | ncloud_network_acl_rule | An incoming Network Access Control List (NACL) rule must not permit traffic across all ports | checker/terraform/rules/ncp/ncloud_network_acl_rule_all_ports_restricted.rego |
| CB_TFNCP_013 | resource | ncloud_lb_listener | Guarantee that the Load Balancer (LB) Listener exclusively employs secure protocols | checker/terraform/rules/ncp/ncloud_lb_listener_secure_protocols.rego |
| CB_TFNCP_014 | resource | ncloud_nas_volume | Verify that the Network Attached Storage (NAS) is protected with robust encryption measures | checker/terraform/rules/ncp/ncloud_nas_volume_encrypted.rego |
| CB_TFNCP_015 | resource | ncloud_lb_target_group | Verify that the Load Balancer Target Group does not employ HTTP as its protocol | checker/terraform/rules/ncp/ncloud_lb_target_group_http_restricted.rego |
| CB_TFNCP_016 | resource | ncloud_lb | Guarantee that the Load Balancer is not accessible from the internet | checker/terraform/rules/ncp/ncloud_lb_internet_exposure_restricted.rego |
| CB_TFNCP_017 | resource | ncloud_auto_scaling_group | Verify that Auto Scaling groups linked with a load balancer utilize Load Balancing health checks | checker/terraform/rules/ncp/ncloud_auto_scaling_group_load_balancer.rego |
| CB_TFNCP_017 | resource | ncloud_lb_target_group | Verify that Auto Scaling groups linked with a load balancer utilize Load Balancing health checks | checker/terraform/rules/ncp/ncloud_auto_scaling_group_load_balancer.rego |
| CB_TFNCP_018 | resource | ncloud_nks_cluster | Verify that the public endpoint for the Naver Kubernetes Service is deactivated | checker/terraform/rules/ncp/ncloud_nks_cluster_public_endpoint_disabled.rego |
| CB_TFNCP_019 | resource | ncloud_route | Verify that the routing table linked to the Web tier subnet includes a default route (0.0.0.0/0) configuration to enable connectivity | checker/terraform/rules/ncp/ncloud_route_default_route.rego |
| CB_TFNCP_020 | resource | ncloud_route_table | Make certain that a route table is established for the public subnets | checker/terraform/rules/ncp/ncloud_subnet_public_subnets.rego |
| CB_TFNCP_020 | resource | ncloud_subnet | Make certain that a route table is established for the public subnets | checker/terraform/rules/ncp/ncloud_subnet_public_subnets.rego |
| CB_TFNCP_021 | resource | ncloud_nks_cluster | Verify that logging is activated for every log types within the control plane of Naver Kubernetes Service (NKS) | checker/terraform/rules/ncp/ncloud_nks_cluster_logging_enabled.rego |
| CB_TFNCP_022 | resource | ncloud_public_ip | Verify that the server instance does not possess a public IP address | checker/terraform/rules/ncp/ncloud_public_ip_server_instance_restricted.rego |
| CB_TFNCP_023 | resource | ncloud_lb_listener | Guarantee that the Load Balancer Listener is configured to use the HTTPS protocol | checker/terraform/rules/ncp/ncloud_lb_listener_utilizing_https.rego |
| CB_TFNCP_024 | resource | ncloud_access_control_group_rule | Verify that there are no access control groups permitting inbound traffic from the IP address 0.0.0.0 to port 80 | checker/terraform/rules/ncp/ncloud_access_control_group_rule_inbound_port_80.rego |
| CB_TFNCP_025 | resource | ncloud_access_control_group | Verify that an Access Control Group is associated with an Access Control Group Rule | checker/terraform/rules/ncp/ncloud_access_control_group_control_group_rule_attached.rego |
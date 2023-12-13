# Terraform ALI Policy Index


This document provides a comprehensive index of Terraform policies available in BrainIAC(Terraform ALI).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TFALI_001 | resource | alicloud_oss_bucket | The Alibaba Cloud OSS bucket is expected to be configured as private | checker/terraform/rules/ali/alicloud_oss_bucket_private.rego |
| CB_TFALI_002 | resource | alicloud_security_group_rule | Verify that ingress from all IP addresses (0.0.0.0:0) to port 22 is not permitted in any security groups | checker/terraform/rules/ali/alicloud_security_group_rule_ingress_restricted_port_22.rego |
| CB_TFALI_003 | resource | alicloud_security_group_rule | Verify that ingress from all IP addresses (0.0.0.0:0) to port 3389 is not permitted in any security groups | checker/terraform/rules/ali/alicloud_security_group_rule_ingress_restricted_port_3389.rego |
| CB_TFALI_004 | resource | alicloud_actiontrail_trail | Guarantee that Action Trail Logging is active in every region | checker/terraform/rules/ali/alicloud_actiontrail_trail_all_regions.rego |
| CB_TFALI_005 | resource | alicloud_api_gateway_api | Verify API Gateway API Uses HTTPS Protocol | checker/terraform/rules/ali/alicloud_api_gateway_api_protocol_https.rego |
| CB_TFALI_006 | resource | alicloud_db_instance | Verify Transparent Data Encryption is Enabled on Instances | checker/terraform/rules/ali/alicloud_db_instance_rds_transparent_data_encryption_enabled.rego |
| CB_TFALI_007 | resource | alicloud_actiontrail_trail | Guarantee that Action Trail Logging is active in every event | checker/terraform/rules/ali/alicloud_actiontrail_trail_all_events.rego |
| CB_TFALI_008 | resource | alicloud_ram_account_password_policy | Verify RAM Account Password Policy Max Login Attempts | checker/terraform/rules/ali/alicloud_ram_account_password_policy_max_login.rego |
| CB_TFALI_009 | resource | alicloud_ram_security_preference | Verify RAM Enforces Multi-Factor Authentication (MFA) | checker/terraform/rules/ali/alicloud_ram_security_preference_ram_security_enforce_mfa.rego |
| CB_TFALI_010 | resource | alicloud_db_instance | Verify RDS Instance SQL Collector Retention Period Exceeds 180 Days | checker/terraform/rules/ali/alicloud_db_instance_rds_retention.rego |
| CB_TFALI_011 | resource | alicloud_cs_kubernetes | Verify Kubernetes Installs Either Terway or Flannel Plugin for Standard Policy Support | checker/terraform/rules/ali/alicloud_cs_kubernetes_enable_network_policies.rego |
| CB_TFALI_012 | resource | alicloud_oss_bucket | Verify that the OSS bucket is protected with a Customer Master Key for encryption | checker/terraform/rules/ali/alicloud_oss_bucket_cmk_encrypted.rego |
| CB_TFALI_013 | resource | alicloud_db_instance | Confirm that the database instance is not accessible to the public | checker/terraform/rules/ali/alicloud_db_instance_db_instance_public_restricted.rego |
| CB_TFALI_014 | resource | alicloud_oss_bucket | Verify that versioning is activated for the OSS bucket | checker/terraform/rules/ali/alicloud_oss_bucket_versioning_active.rego |
| CB_TFALI_015 | resource | alicloud_oss_bucket | Verify that transfer acceleration is activated for the OSS bucket | checker/terraform/rules/ali/alicloud_oss_bucket_transfer_accl_active.rego |
| CB_TFALI_016 | resource | alicloud_oss_bucket | Verify that access logging is activated for the OSS bucket | checker/terraform/rules/ali/alicloud_oss_bucket_access_log_active.rego |
| CB_TFALI_017 | resource | alicloud_kms_key | Verify Key Rotation is Enabled for KMS Keys | checker/terraform/rules/ali/alicloud_kms_key_rotation_is_enabled.rego |
| CB_TFALI_018 | resource | alicloud_kms_key | Verify KMS Keys are Enabled | checker/terraform/rules/ali/alicloud_kms_key_is_enabled.rego |
| CB_TFALI_019 | resource | alicloud_ram_account_password_policy | Verify that the RAM password policy mandates a minimum length of 14 characters or more | checker/terraform/rules/ali/alicloud_ram_account_password_policy_password_min_length.rego |
| CB_TFALI_020 | resource | alicloud_alb_acl_entry_attachment | Verify Alibaba Cloud Load Balancer (ALB) ACL Restricts Access | checker/terraform/rules/ali/alicloud_alb_acl_entry_attachment_unrestricted.rego |
| CB_TFALI_021 | resource | alicloud_db_instance | Verify RDS Instance Auto-Upgrades for Minor Versions | checker/terraform/rules/ali/alicloud_db_instance_auto_upgrade.rego |
| CB_TFALI_022 | resource | alicloud_cs_kubernetes_node_pool | Verify Kubernetes Node Pools Auto-Repair Configuration | checker/terraform/rules/ali/alicloud_cs_kubernetes_node_pool_auto_repair.rego |
| CB_TFALI_023 | resource | alicloud_ram_account_password_policy | Verify that the RAM password policy mandates the inclusion of at least one numeric character | checker/terraform/rules/ali/alicloud_ram_account_password_policy_password_num_required.rego |
| CB_TFALI_024 | resource | alicloud_ram_account_password_policy | Verify that the RAM password policy mandates the inclusion of at least one special character | checker/terraform/rules/ali/alicloud_ram_account_password_policy_password_symbol_required.rego |
| CB_TFALI_025 | resource | alicloud_ram_account_password_policy | Guarantee that the password policy for RAM mandates password expiration within a period of 90 days or fewer | checker/terraform/rules/ali/alicloud_ram_account_password_policy_expire.rego |
| CB_TFALI_026 | resource | alicloud_ram_account_password_policy | Guarantee that the RAM password policy mandates the inclusion of at least one lowercase letter in passwords | checker/terraform/rules/ali/alicloud_ram_account_password_policy_lowercase_required.rego |
| CB_TFALI_027 | resource | alicloud_ram_account_password_policy | Guarantee that the RAM password policy inhibits the reuse of passwords | checker/terraform/rules/ali/alicloud_ram_account_password_policy_reuse.rego |
| CB_TFALI_028 | resource | alicloud_ram_account_password_policy | Verify that the password policy for RAM (Resource Access Management) mandates the inclusion of at least one uppercase letter for enhanced security | checker/terraform/rules/ali/alicloud_ram_account_password_policy_uppercase_required.rego |
| CB_TFALI_029 | resource | alicloud_db_instance | Guarantee the adoption of SSL for RDS instances | checker/terraform/rules/ali/alicloud_db_instance_rds_utilize_ssl.rego |
| CB_TFALI_030 | resource | alicloud_disk | Guarantee that the Disk is secured with a Customer Master Key for encryption | checker/terraform/rules/ali/alicloud_disk_cmk_encrypted.rego |
| CB_TFALI_031 | resource | alicloud_ecs_launch_template | Verify Encryption for Launch Template Data Disks | checker/terraform/rules/ali/alicloud_ecs_launch_template_disks_are_encrypted.rego |
| CB_TFALI_032 | resource | alicloud_slb_tls_cipher_policy | Verify Security of Alibaba Cloud Cypher Policy | checker/terraform/rules/ali/alicloud_slb_tls_cipher_policy_is_secured.rego |
| CB_TFALI_033 | resource | alicloud_db_instance | Verify Presence of log_duration in RDS Instance | checker/terraform/rules/ali/alicloud_db_instance_logs_enabled.rego |
| CB_TFALI_034 | resource | alicloud_db_instance | Verify Presence of log_disconnections in RDS Instance | checker/terraform/rules/ali/alicloud_db_instance_log_disconnections.rego |
| CB_TFALI_035 | resource | alicloud_db_instance | Verify Presence of log_connections in RDS Instance | checker/terraform/rules/ali/alicloud_db_instance_log_connections.rego |
| CB_TFALI_036 | resource | alicloud_disk | Guarantee the encryption of Alibaba Cloud Disk | checker/terraform/rules/ali/alicloud_disk_encrypted.rego |
| CB_TFALI_037 | resource | alicloud_log_audit | Verify Alibaba Cloud RDS Log Audit Configuration | checker/terraform/rules/ali/alicloud_log_audit_rds_enabled.rego |
| CB_TFALI_038 | resource | alicloud_mongodb_instance | Verify MongoDB Deployment within a Virtual Private Cloud (VPC) | checker/terraform/rules/ali/alicloud_mongodb_instance_inside_vcp.rego |
| CB_TFALI_039 | resource | alicloud_mongodb_instance | Verify MongoDB Instance SSL Usage | checker/terraform/rules/ali/alicloud_mongodb_instance_ssl_usage.rego |
| CB_TFALI_040 | resource | alicloud_mongodb_instance | Verify MongoDB Instance as Non-Public | checker/terraform/rules/ali/alicloud_mongodb_instance_not_public.rego |
| CB_TFALI_041 | resource | alicloud_mongodb_instance | Verify MongoDB Transparent Data Encryption | checker/terraform/rules/ali/alicloud_mongodb_instance_transpartent_data_encryption.rego |
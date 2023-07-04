# Terraform OCI Policy Index


This document provides a comprehensive index of Kubernetes policies available in BrainIAC(Terraform OCI).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TFOCI_001 | Provider | oci | Verify no hard coded OCI private key in provider | checker/terraform/rules/oci/verify_no_hard_coded_oci_private_key.rego |
| CB_TFOCI_002 | Resource | oci_core_volume | Verify OCI Block Storage Block Volume has backup enabled | checker/terraform/rules/oci/verify_oci_block_storage_block_volume_backup.rego |
| CB_TFOCI_003 | Resource | oci_file_storage_file_system | Verify that OCI File System is Encrypted with a customer Managed Key | checker/terraform/rules/oci/verify_file_system_encryption.rego |
| CB_TFOCI_004 | Resource | oci_core_volume | Verify OCI Block Storage Block Volumes are encrypted with a Customer Managed Key (CMK) | checker/terraform/rules/oci/verify_oci_block_storage_block_encrypted_using_kms.rego |
| CB_TFOCI_005 | Resource | oci_core_volume | Verify OCI Compute Instance boot volume has in-transit data encryption enabled | checker/terraform/rules/oci/verify_oci_instance_boot_volume_transit_encryption_enabled.rego |
| CB_TFOCI_006 | Resource | oci_core_volume | Verify OCI Compute Instance has Legacy MetaData service endpoint disabled | checker/terraform/rules/oci/verify_oci_compute_instance_legacy_service_endpoint_disabled.rego |
| CB_TFOCI_007 | Resource | oci_core_volume | Verify OCI Compute Instance has monitoring enabled | checker/terraform/rules/oci/verify_oci_compute_instance_monitoring_enabled.rego |
| CB_TFOCI_008 | Resource | oci_objectstorage_bucket | Verify OCI Object Storage bucket can emit object events | checker/terraform/rules/oci/verify_oci_storage_bucket_emit_events.rego |
| CB_TFOCI_009 | Resource | oci_objectstorage_bucket | Verify OCI Object Storage has versioning enabled | checker/terraform/rules/oci/verify_oci_storage_versioning _enabled.rego |
| CB_TFOCI_010 | Resource | oci_objectstorage_bucket | Verify OCI Object Storage is encrypted with Customer Managed Key | checker/terraform/rules/oci/verify_oci_storage_kms_encrypted_test.rego |
| CB_TFOCI_011 | Resource | oci_objectstorage_bucket | Verify OCI Object Storage is not Public | checker/terraform/rules/oci/verify_oci_storage_not_public.rego |
| CB_TFOCI_012 | Resource | oci_identity_authentication_policy | Verify OCI IAM password policy - must contain lower case | checker/terraform/rules/oci/verify_oci_iam_password_policy_lowercase.rego |
| CB_TFOCI_013 | Resource | oci_identity_authentication_policy | Verify OCI IAM password policy - must contain Numeric characters | checker/terraform/rules/oci/verify_oci_iam_password_policy_numeric.rego |
| CB_TFOCI_014 | Resource | oci_identity_authentication_policy | Verify OCI IAM password policy - must contain Special characters | checker/terraform/rules/oci/verify_oci_iam_password_policy_special_characters.rego |
| CB_TFOCI_015 | Resource | oci_identity_authentication_policy | Verify OCI IAM password policy - must contain Uppercase characters | checker/terraform/rules/oci/verify_oci_iam_password_policy_special_uppercase.rego |
| CB_TFOCI_016 | Resource | oci_core_security_list | Verify that VCN has an inbound security list | checker/terraform/rules/oci/verify_security_list_ingress.rego |
| CB_TFOCI_017 | Resource | oci_core_security_list | Verify that VCN inbound security lists are stateless | checker/terraform/rules/oci/verify_security_list_ingress_stateless.rego |
| CB_TFOCI_018 | Resource | oci_identity_authentication_policy | Verify that IAM password policy for local (non-federated) users has a minimum length of 14 characters | checker/terraform/rules/oci/iam/verify_iam_password_length.rego |
| CB_TFOCI_019 | Resource | oci_core_security_list | Verify that OCI security list does not allow ingress from 0.0.0.0/0 to port 22 | checker/terraform/rules/oci/verify_security_list_unrestricted_ingress.rego |
| CB_TFOCI_020 | Resource | oci_core_security_list | Verify that OCI security list does not allow ingress from 0.0.0.0/0 to port 3389 | checker/terraform/rules/oci/verify_security_list_unrestricted_ingress.rego |
| CB_TFOCI_021 | Resource | oci_core_network_security_group_security_rule | Verify that security group has stateless ingress security rules | checker/terraform/rules/oci/verify_security_groups_ingress_stateless_security_rules.rego |
| CB_TFOCI_022 | Resource | oci_core_network_security_group_security_rule | Verify that OCI security groups rules do not allow ingress from 0.0.0.0/0 to port 22 | checker/terraform/rules/oci/verify_security_group_unrestricted_ingress_22.rego |
| CB_TFOCI_023 | Resource | oci_identity_group | Verify that administrator users are not associated with API keys | checker/terraform/rules/oci/verify_administrator_user_not_associated_with_api_key.rego |
| CB_TFOCI_023 | Resource | oci_identity_user | Verify that administrator users are not associated with API keys | checker/terraform/rules/oci/verify_administrator_user_not_associated_with_api_key.rego |
| CB_TFOCI_023 | Resource | oci_identity_user_group_membership | Verify that administrator users are not associated with API keys | checker/terraform/rules/oci/verify_administrator_user_not_associated_with_api_key.rego |
| CB_TFOCI_024 | Resource | oci_core_network_security_group_security_rule | Verify that OCI security groups rules do not allow ingress from 0.0.0.0/0 to port 3389 | checker/terraform/rules/oci/verify_security_group_unrestricted_ingress_3389.rego |
| CB_TFOCI_025 | Resource | oci_containerengine_cluster | Verify that Kubernetes engine cluster is configured with NSG(s) | checker/terraform/rules/oci/verify_kubernetes_engine_cluster_endpoint_config.rego |
| CB_TFOCI_026 | Resource | oci_file_storage_export | Verify that File Storage File System access is restricted to root users | checker/terraform/rules/oci/verify_nfs_access_restricted_to_root_users.rego |
| CB_TFOCI_027 | Resource | oci_containerengine_node_pool | Verify that Kubernetes Engine Cluster boot volume is configured with in-transit data encryption | checker/terraform/rules/oci/verify_k8_engine_cluster_boot_volume_config_in_transit_encryption.rego |
| CB_TFOCI_028 | Resource | oci_containerengine_cluster | Verify that Kubernetes Engine Cluster pod security policy is enforced | checker/terraform/rules/oci/verify_k8_engine_cluster_pod_security_policy_enforced.rego |

# Terraform Yandex Policy Index


This document provides a comprehensive index of Terraform policies available in BrainIAC(Terraform Yandex).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TFYC_001 | resource | yandex_mdb_clickhouse_cluster | Assign Security Group to Database Cluster | checker/terraform/rules/yc/yandex_mdb_security_group.rego |
| CB_TFYC_001 | resource | yandex_mdb_elasticsearch_cluster | Assign Security Group to Database Cluster | checker/terraform/rules/yc/yandex_mdb_security_group.rego |
| CB_TFYC_001 | resource | yandex_mdb_greenplum_cluster | Assign Security Group to Database Cluster | checker/terraform/rules/yc/yandex_mdb_security_group.rego |
| CB_TFYC_001 | resource | yandex_mdb_kafka_cluster | Assign Security Group to Database Cluster | checker/terraform/rules/yc/yandex_mdb_security_group.rego |
| CB_TFYC_001 | resource | yandex_mdb_mongodb_cluster | Assign Security Group to Database Cluster | checker/terraform/rules/yc/yandex_mdb_security_group.rego |
| CB_TFYC_001 | resource | yandex_mdb_mysql_cluster | Assign Security Group to Database Cluster | checker/terraform/rules/yc/yandex_mdb_security_group.rego |
| CB_TFYC_001 | resource | yandex_mdb_postgresql_cluster | Assign Security Group to Database Cluster | checker/terraform/rules/yc/yandex_mdb_security_group.rego |
| CB_TFYC_001 | resource | yandex_mdb_redis_cluster | Assign Security Group to Database Cluster | checker/terraform/rules/yc/yandex_mdb_security_group.rego |
| CB_TFYC_001 | resource | yandex_mdb_sqlserver_cluster | Assign Security Group to Database Cluster | checker/terraform/rules/yc/yandex_mdb_security_group.rego |
| CB_TFYC_002 | resource | yandex_compute_instance | Disallow Public IP for Compute Instance | checker/terraform/rules/yc/yandex_compute_instance_vm_public_ip.rego |
| CB_TFYC_003 | resource | yandex_storage_bucket | Encrypt Storage Bucket Data-at-Rest | checker/terraform/rules/yc/yandex_storage_bucket_encryption.rego |
| CB_TFYC_004 | resource | yandex_compute_instance | Disable Serial Console for Compute Instances | checker/terraform/rules/yc/yandex_compute_instance_vm_serial_console.rego |
| CB_TFYC_005 | resource | yandex_kubernetes_cluster | Restrict Public IP Address in Kubernetes Cluster | checker/terraform/rules/yc/yandex_kubernetes_cluster_public_ip.rego |
| CB_TFYC_006 | resource | yandex_kubernetes_node_group | Avoid Public IP Addresses in Kubernetes Cluster Node Groups | checker/terraform/rules/yc/yandex_kubernetes_node_group_public_ip.rego |
| CB_TFYC_007 | resource | yandex_kubernetes_cluster | Enable Kubernetes Cluster Auto-Upgrade | checker/terraform/rules/yc/yandex_kubernetes_cluster_auto_upgrade_enabled.rego |
| CB_TFYC_008 | resource | yandex_kubernetes_node_group | Enable Kubernetes Node Group Auto-Upgrade | checker/terraform/rules/yc/yandex_kubernetes_node_group_auto_upgrade_enabled.rego |
| CB_TFYC_009 | resource | yandex_kms_symmetric_key | Rotate KMS Symmetric Key | checker/terraform/rules/yc/yandex_kms_symmetric_key_rotation_period_is_set.rego |
| CB_TFYC_010 | resource | yandex_kubernetes_cluster | Encrypt etcd Database with KMS Key | checker/terraform/rules/yc/yandex_kubernetes_cluster_kms_key_is_set.rego |
| CB_TFYC_011 | resource | yandex_compute_instance | Assign Security Group to Network Interface | checker/terraform/rules/yc/yandex_compute_instance_security_group_is_set.rego |
| CB_TFYC_012 | resource | yandex_mdb_clickhouse_cluster | Disallow Assignment of Public IP to Database Cluster | checker/terraform/rules/yc/yandex_compute_instance_security_group_is_set.rego |
| CB_TFYC_012 | resource | yandex_mdb_elasticsearch_cluster | Disallow Assignment of Public IP to Database Cluster | checker/terraform/rules/yc/yandex_compute_instance_security_group_is_set.rego |
| CB_TFYC_012 | resource | yandex_mdb_greenplum_cluster | Disallow Assignment of Public IP to Database Cluster | checker/terraform/rules/yc/yandex_compute_instance_security_group_is_set.rego |
| CB_TFYC_012 | resource | yandex_mdb_kafka_cluster | Disallow Assignment of Public IP to Database Cluster | checker/terraform/rules/yc/yandex_compute_instance_security_group_is_set.rego |
| CB_TFYC_012 | resource | yandex_mdb_mongodb_cluster | Disallow Assignment of Public IP to Database Cluster | checker/terraform/rules/yc/yandex_compute_instance_security_group_is_set.rego |
| CB_TFYC_012 | resource | yandex_mdb_mysql_cluster | Disallow Assignment of Public IP to Database Cluster | checker/terraform/rules/yc/yandex_compute_instance_security_group_is_set.rego |
| CB_TFYC_012 | resource | yandex_mdb_postgresql_cluster | Disallow Assignment of Public IP to Database Cluster | checker/terraform/rules/yc/yandex_compute_instance_security_group_is_set.rego |
| CB_TFYC_012 | resource | yandex_mdb_sqlserver_cluster | Disallow Assignment of Public IP to Database Cluster | checker/terraform/rules/yc/yandex_compute_instance_security_group_is_set.rego |
| CB_TFYC_013 | resource | yandex_resourcemanager_cloud_iam_binding | Restrict Cloud Member Elevated Access | checker/terraform/rules/yc/yandex_resourcemanager_cloud_iam_elevated_members.rego |
| CB_TFYC_013 | resource | yandex_resourcemanager_cloud_iam_member | Restrict Cloud Member Elevated Access | checker/terraform/rules/yc/yandex_resourcemanager_cloud_iam_elevated_members.rego |
| CB_TFYC_014 | resource | yandex_kubernetes_cluster | Assign Security Group to Kubernetes Cluster | checker/terraform/rules/yc/yandex_kubernetes_cluster_security_group_is_set.rego |
| CB_TFYC_015 | resource | yandex_kubernetes_node_group | Assign Security Group to Kubernetes Node Group | checker/terraform/rules/yc/yandex_kubernetes_node_group_security_group_is_set.rego |
| CB_TFYC_016 | resource | yandex_kubernetes_cluster | Assign Network Policy to Kubernetes Cluster | checker/terraform/rules/yc/yandex_kubernetes_cluster_network_policy_provider_is_set.rego |
| CB_TFYC_017 | resource | yandex_storage_bucket | Restrict Public Access Permissions for Storage Bucket | checker/terraform/rules/yc/yandex_storage_bucket_public_access.rego |
| CB_TFYC_018 | resource | yandex_compute_instance_group | Avoid Public IP for Compute Instance Group | checker/terraform/rules/yc/yandex_compute_instance_group_public_ip.rego |
| CB_TFYC_019 | resource | yandex_vpc_security_group | Restrictive Security Group Rules Enforcement | checker/terraform/rules/yc/yandex_vpc_security_group_allow_all.rego |
| CB_TFYC_020 | resource | yandex_vpc_security_group_rule | Prohibit Allow-All Security Group Rules | checker/terraform/rules/yc/yandex_vpc_security_group_rule_allow_all.rego |
| CB_TFYC_021 | resource | yandex_organizationmanager_organization_iam_binding | Prevent Elevated Access for Organization Members | checker/terraform/rules/yc/yandex_organizationmanager_organization_iam_restricted_roles.rego |
| CB_TFYC_021 | resource | yandex_organizationmanager_organization_iam_member | Prevent Elevated Access for Organization Members | checker/terraform/rules/yc/yandex_organizationmanager_organization_iam_restricted_roles.rego |
| CB_TFYC_022 | resource | yandex_compute_instance_group | Verify Security Group Assignment for Compute Instance Group | checker/terraform/rules/yc/yandex_compute_instance_group_security_group_ids.rego |
| CB_TFYC_023 | resource | yandex_resourcemanager_folder_iam_binding | Verify Elevated Access for Folder Members | checker/terraform/rules/yc/yandex_resourcemanager_folder_iam_restricted_roles.rego |
| CB_TFYC_023 | resource | yandex_resourcemanager_folder_iam_member | Verify Elevated Access for Folder Members | checker/terraform/rules/yc/yandex_resourcemanager_folder_iam_restricted_roles.rego |
| CB_TFYC_024 | resource | yandex_organizationmanager_organization_iam_binding | Verify Non-Usage of Passport Accounts for Assignments | checker/terraform/rules/yc/yandex_iam_passport_usage.rego |
| CB_TFYC_024 | resource | yandex_organizationmanager_organization_iam_member | Verify Non-Usage of Passport Accounts for Assignments | checker/terraform/rules/yc/yandex_iam_passport_usage.rego |
| CB_TFYC_024 | resource | yandex_resourcemanager_cloud_iam_binding | Verify Non-Usage of Passport Accounts for Assignments | checker/terraform/rules/yc/yandex_iam_passport_usage.rego |
| CB_TFYC_024 | resource | yandex_resourcemanager_cloud_iam_member | Verify Non-Usage of Passport Accounts for Assignments | checker/terraform/rules/yc/yandex_iam_passport_usage.rego |
| CB_TFYC_024 | resource | yandex_resourcemanager_folder_iam_binding | Verify Non-Usage of Passport Accounts for Assignments | checker/terraform/rules/yc/yandex_iam_passport_usage.rego |
| CB_TFYC_024 | resource | yandex_resourcemanager_folder_iam_member | Verify Non-Usage of Passport Accounts for Assignments | checker/terraform/rules/yc/yandex_iam_passport_usage.rego |
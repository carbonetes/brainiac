# Terraform Rancher Policy Index


This document provides a comprehensive index of Terraform policies available in BrainIAC(Terraform Rancher).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TFRAN_001 | resource | rancher2_app | Verify Setting of Rancher Project ID | checker/terraform/rules/rancher/rancher_app_set_project_id.rego |
| CB_TFRAN_002 | resource | rancher2_app | Verify Rancher App Template Version | checker/terraform/rules/rancher/rancher_app_template_version_latest.rego |
| CB_TFRAN_003 | resource | rancher2_app | Verify Rancher App Label Has Environment Set To Production | checker/terraform/rules/rancher/rancher_app_environment_label.rego |
| CB_TFRAN_003 | resource | rancher2_app_v2 | Verify Rancher App Label Has Environment Set To Production | checker/terraform/rules/rancher/rancher_app_environment_label.rego |
| CB_TFRAN_004 | resource | rancher2_app | Verify Rancher App Custom Annotation Enabled | checker/terraform/rules/rancher/rancher_app_custom_annotation_enabled.rego |
| CB_TFRAN_004 | resource | rancher2_app_v2 | Verify Rancher App Custom Annotation Enabled | checker/terraform/rules/rancher/rancher_app_custom_annotation_enabled.rego |
| CB_TFRAN_005 | resource | rancher2_app | Verify Rancher App Custom Label Enabled | checker/terraform/rules/rancher/rancher_app_custom_label.rego |
| CB_TFRAN_005 | resource | rancher2_app_v2 | Verify Rancher App Custom Label Enabled | checker/terraform/rules/rancher/rancher_app_custom_label.rego |
| CB_TFRAN_006 | resource | rancher2_auth_config_activedirectory | Verify Rancher Active Directory Configuration | checker/terraform/rules/rancher/rancher2_auth_config_activedirectory_configuration.rego |
| CB_TFRAN_007 | resource | rancher2_auth_config_activedirectory | Verify Rancher Active Directory Enabled | checker/terraform/rules/rancher/rancher2_auth_config_activedirectory_enabled.rego |
| CB_TFRAN_008 | resource | rancher2_auth_config_activedirectory | Verify Rancher Active Directory Configuration Servers | checker/terraform/rules/rancher/rancher2_auth_config_activedirectory_server.rego |
| CB_TFRAN_009 | resource | rancher2_auth_config_adfs | Verify Rancher ADFS Configuration | checker/terraform/rules/rancher/rancher2_auth_config_adfs_configuration.rego |
| CB_TFRAN_010 | resource | rancher2_auth_config_keycloak  | Verify Rancher Auth Configurations API Host uses HTTPS | checker/terraform/rules/rancher/rancher2_auth_rancher_api_host.rego |
| CB_TFRAN_010 | resource | rancher2_auth_config_adfs | Verify Rancher Auth Configurations API Host uses HTTPS | checker/terraform/rules/rancher/rancher2_auth_rancher_api_host.rego |
| CB_TFRAN_010 | resource | rancher2_auth_config_okta  | Verify Rancher Auth Configurations API Host uses HTTPS | checker/terraform/rules/rancher/rancher2_auth_rancher_api_host.rego |
| CB_TFRAN_011 | resource | rancher2_auth_config_azuread | Verify Rancher AzureAD Configuration | checker/terraform/rules/rancher/rancher2_auth_config_azuread_configuration.rego |
| CB_TFRAN_012 | resource | rancher2_auth_config_azuread | Verify Rancher AzureAD Configuration Uses HTTPS URL | checker/terraform/rules/rancher/rancher2_auth_config_azuread_configuration_https_url.rego |
| CB_TFRAN_013 | resource | rancher2_auth_config_azuread | Verify Secure AzureAD Endpoint URLs | checker/terraform/rules/rancher/rancher2_auth_config_azuread_endpoint_urls.rego |
| CB_TFRAN_014 | resource | rancher2_auth_config_freeipa | Verify Rancher FreeIPA Configuration | checker/terraform/rules/rancher/rancher2_auth_config_freeipa_configuration.rego |
| CB_TFRAN_015 | resource | rancher2_auth_config_freeipa | Verify Rancher FreeIPA Servers Configuration | checker/terraform/rules/rancher/rancher2_auth_config_freeipa_configuration_server.rego |
| CB_TFRAN_016 | resource | rancher2_auth_config_freeipa | Verify Rancher FreeIPA TLS Configuration | checker/terraform/rules/rancher/rancher2_auth_config_freeipa_tls_configuration.rego |
| CB_TFRAN_017 | resource | rancher2_auth_config_github | Verify Rancher GitHub Authentication Configuration | checker/terraform/rules/rancher/rancher2_auth_config_github_configuration.rego |
| CB_TFRAN_018 | resource | rancher2_auth_config_github | Verify Rancher GitHub Configuration is Disabled if Not Needed | checker/terraform/rules/rancher/rancher2_auth_config_github_configuration |
| CB_TFRAN_019 | resource | rancher2_auth_config_freeipa | Verify Rancher FreeIPA Configuration is Disabled if Not Needed | checker/terraform/rules/rancher/rancher2_auth_config_freeipa_configuration_disabled.rego |
| CB_TFRAN_020 | resource | rancher2_auth_config_azuread | Verify Rancher Azure AD Configuration is Disabled Properly | checker/terraform/rules/rancher/rancher2_auth_config_azuread_configuration_disabled.rego |
| CB_TFRAN_021 | resource | rancher2_auth_config_activedirectory | Verify Rancher Active Directory Configuration is Properly Disabled | checker/terraform/rules/rancher/rancher2_auth_config_activedirectory_configuration_disabled.rego |
| CB_TFRAN_022 | resource | rancher2_auth_config_keycloak | Verify Rancher KeyCloak Configuration | checker/terraform/rules/rancher/rancher2_auth_config_keycloa_configuration_test.rego |
| CB_TFRAN_023 | resource | rancher2_auth_config_keycloak | Verify Rancher KeyCloak Configuration is Properly Disabled | checker/terraform/rules/rancher/rancher2_auth_config_keycloak_configuration_disabled.rego |
| CB_TFRAN_024 | resource | rancher2_auth_config_okta | Verify Rancher Okta Configuration | checker/terraform/rules/rancher/rancher2_auth_config_okta_configuration.rego |
| CB_TFRAN_025 | resource | rancher2_auth_config_okta | Verify Rancher OKTA Configuration is Properly Disabled | checker/terraform/rules/rancher/rancher2_auth_config_okta_configuration_disabled.rego |
| CB_TFRAN_026 | resource | rancher2_auth_config_openldap | Verify Rancher OpenLDAP Configuration | checker/terraform/rules/rancher/rancher2_auth_config_openldap_configuration.rego |
| CB_TFRAN_027 | resource | rancher2_auth_config_openldap | Verify Rancher OpenLDAP TLS Configuration | checker/terraform/rules/rancher/rancher2_auth_config_openldap_tls_configuration.rego |
| CB_TFRAN_028 | resource | rancher2_auth_config_openldap | Verify Rancher OpenLDAP Nested Group Membership Configuration | checker/terraform/rules/rancher/rancher2_auth_config_openldap_nested_group_membership.rego |
| CB_TFRAN_029 | resource | rancher2_auth_config_openldap | Verify Rancher OpenLDAP Configuration is Properly Disabled | checker/terraform/rules/rancher/rancher2_auth_config_openldap_configuration_disabled.rego |
| CB_TFRAN_030 | resource | rancher2_auth_config_ping | Verify Rancher Ping Configuration | checker/terraform/rules/rancher/rancher2_auth_config_ping_configuration.rego |
| CB_TFRAN_031 | resource | rancher2_auth_config_okta | Verify Rancher Auth Configs SP Cert and SP Key Secure Configuration | checker/terraform/rules/rancher/rancher2_auth_configs_secure_sp_configuration.rego |
| CB_TFRAN_031 | resource | rancher2_auth_config_ping  | Verify Rancher Auth Configs SP Cert and SP Key Secure Configuration | checker/terraform/rules/rancher/rancher2_auth_configs_secure_sp_configuration.rego |
| CB_TFRAN_031 | resource | rancher2_auth_config_keycloak | Verify Rancher Auth Configs SP Cert and SP Key Secure Configuration | checker/terraform/rules/rancher/rancher2_auth_configs_secure_sp_configuration.rego |
| CB_TFRAN_031 | resource | rancher2_auth_config_adfs  | Verify Rancher Auth Configs SP Cert and SP Key Secure Configuration | checker/terraform/rules/rancher/rancher2_auth_configs_secure_sp_configuration.rego |
| CB_TFRAN_032 | resource | rancher2_auth_config_ping | Verify Rancher Ping Configuration is Properly Disabled | checker/terraform/rules/rancher/rancher2_auth_config_ping_configuration_disabled.rego |
| CB_TFRAN_033 | resource | rancher2_bootstrap | Verify Rancher Bootstrap Configuration connected with rancher2 provider | checker/terraform/rules/rancher/rancher2_bootstrap_config_with_rancher2_provider.rego |
| CB_TFRAN_034 | resource | rancher2_bootstrap | Verify Rancher Bootstrap Configuration | checker/terraform/rules/rancher/rancher2_bootstrap_configuration.rego |
| CB_TFRAN_035 | resource | rancher2_bootstrap | Verify Rancher Bootstrap Telemetry is Properly Disabled | checker/terraform/rules/rancher/rancher2_bootstrap_telemetry.rego |
| CB_TFRAN_036 | resource | rancher2_catalog | Verify Rancher Catalog Configuration for Project Scope | checker/terraform/rules/rancher/rancher2_catalog_project_scope.rego |
| CB_TFRAN_037 | resource | rancher2_catalog | Verify Rancher Catalog Configuration for Cluster Scope | checker/terraform/rules/rancher/rancher2_catalog_cluster_scope.rego |
| CB_TFRAN_038 | resource | rancher2_catalog | Verify Required Attributes in Rancher Catalog Configuration | checker/terraform/rules/rancher/rancher2_catalog_configuration.rego |
| CB_TFRAN_039 | resource | rancher2_catalog | Validate Rancher Catalog Version Attribute | checker/terraform/rules/rancher/rancher2_catalog_version_uses_helm.rego |
| CB_TFRAN_040 | resource | rancher2_catalog | Validate Rancher Catalog Scope Attribute | checker/terraform/rules/rancher/rancher2_catalog_scope_validation.rego |
| CB_TFRAN_041 | resource | rancher2_catalog_v2 | Verify Rancher Catalog V2 Configuration | checker/terraform/rules/rancher/rancher2_catalog_v2_configuration_validation.rego |
| CB_TFRAN_042 | resource | rancher2_catalog_v2 | Validate Exclusive Git Repository or URL for Rancher Catalog V2 Configuration | checker/terraform/rules/rancher/rancher2_catalog_v2_git_url_validation.rego |
| CB_TFRAN_043 | resource | rancher2_catalog_v2 | Validate Secret Name and Namespace in Rancher Catalog V2 Configuration | checker/terraform/rules/rancher/rancher2_catalog_v2_secrets.rego |
| CB_TFRAN_044 | resource | rancher2_certificate | Verify Rancher Certificate Configuration | checker/terraform/rules/rancher/rancher2_certificate_configuration.rego |
| CB_TFRAN_045 | resource | rancher2_certificate | Validate Rancher Certificate Namespace Configuration | checker/terraform/rules/rancher/rancher2_certificate_namespace.rego |
| CB_TFRAN_046 | resource | rancher2_certificate | Verify Proper Base64 Certificate and Key Configuration in Rancher Certificate | checker/terraform/rules/rancher/rancher2_certificate_base64_cert_key.rego |
| CB_TFRAN_047 | resource | rancher2_certificate | Validate Rancher Certificate Names Follow Naming Conventions | checker/terraform/rules/rancher/rancher2_certificate_naming_convention.rego |
| CB_TFRAN_048 | resource | rancher2_cloud_credential | Verify Supported Drivers in Rancher Cloud Credential | checker/terraform/rules/rancher/rancher2_cloud_credential_drivers.rego |
| CB_TFRAN_049 | resource | rancher2_cloud_credential | Verify Proper Configuration in Rancher Cloud Credentials for AmazonEC2 | checker/terraform/rules/rancher/rancher2_cloud_credential_amazonec2.rego |
| CB_TFRAN_050 | resource | rancher2_cloud_credential | Verify Proper Configuration in Rancher Cloud Credentials for Azure | checker/terraform/rules/rancher/rancher2_cloud_credential_azure.rego |
| CB_TFRAN_051 | resource | rancher2_cloud_credential | Verify Proper Configuration in Rancher Cloud Credentials for DigitalOcean | checker/terraform/rules/rancher/rancher2_cloud_credential_digitalocean.rego |
| CB_TFRAN_052 | resource | rancher2_cloud_credential | Verify Proper Configuration in Rancher Cloud Credentials for GoogleKubernetesEngine | checker/terraform/rules/rancher/rancher2_cloud_credential_gke.rego |
| CB_TFRAN_053 | resource | rancher2_cloud_credential | Verify Proper Configuration in Rancher Cloud Credentials for Linode | checker/terraform/rules/rancher/rancher2_cloud_credential_linoderego |
| CB_TFRAN_054 | resource | rancher2_cloud_credential | Verify Proper Configuration in Rancher Cloud Credentials for Harvester | checker/terraform/rules/rancher/rancher2_cloud_credential_harvester.rego |
| CB_TFRAN_055 | resource | rancher2_cloud_credential | Verify Proper Configuration in Rancher Cloud Credentials for OpenStack | checker/terraform/rules/rancher/rancher2_cloud_credential_openstack.rego |
| CB_TFRAN_056 | resource | rancher2_cloud_credential | Verify Proper Configuration in Rancher Cloud Credentials for S3 | checker/terraform/rules/rancher/rancher2_cloud_credential_s3.rego |
| CB_TFRAN_057 | resource | rancher2_cloud_credential | Verify Proper Configuration in Rancher Cloud Credentials for VMWarevSphere | checker/terraform/rules/rancher/rancher2_cloud_credential_vmwarevsphere.rego |
| CB_TFRAN_058 | resource | rancher2_cluster | Verify Cluster Name is Not Empty in Rancher2 Clusters | checker/terraform/rules/rancher/rancher2_cluster_name_specification.rego |
| CB_TFRAN_059 | resource | rancher2_cluster | Verify RKE Configuration for Rancher2 Cluster | checker/terraform/rules/rancher/rancher2_cluster_rke_config.rego |
| CB_TFRAN_060 | resource | rancher2_cluster | Verify RKE2 Configuration for Rancher2 Cluster | checker/terraform/rules/rancher/rancher2_cluster_rke2_config.rego |
| CB_TFRAN_061 | resource | rancher2_cluster | Verify K3S Configuration for Rancher2 Cluster | checker/terraform/rules/rancher/rancher2_cluster_k3s_config.rego |
| CB_TFRAN_062 | resource | rancher2_cluster | Verify AKS Configuration for Rancher2 Cluster | checker/terraform/rules/rancher/rancher2_cluster_aks_config.rego |
| CB_TFRAN_063 | resource | rancher2_cluster | Verify AKS Configuration V2 for Rancher2 Cluster | checker/terraform/rules/rancher/rancher2_cluster_aks_config_v2.rego |
| CB_TFRAN_064 | resource | rancher2_cluster | Verify EKS Configuration for Rancher2 Cluster | checker/terraform/rules/rancher/rancher2_cluster_eks_config.rego |
| CB_TFRAN_065 | resource | rancher2_cluster | Verify EKS Configuration V2 for Rancher2 Cluster | checker/terraform/rules/rancher/rancher2_cluster_eks_config_v2.rego |
| CB_TFRAN_066 | resource | rancher2_cluster | Verify GKE Configuration for Rancher2 Cluster | checker/terraform/rules/rancher/rancher2_cluster_gke_config.rego |
| CB_TFRAN_067 | resource | rancher2_cluster | Verify GKE Configuration V2 for Rancher2 Cluster | checker/terraform/rules/rancher/rancher2_cluster_gke_config_v2.rego |
| CB_TFRAN_068 | resource | rancher2_cluster | Verify OKE Configuration for Rancher2 Cluster | checker/terraform/rules/rancher/rancher2_cluster_oke_config.rego |
| CB_TFRAN_069 | resource | rancher2_cluster_alert_group | Verify Rancher2 Cluster Alert Group Configuration | checker/terraform/rules/rancher/rancher2_cluster_alert_group_configuration.rego |
| CB_TFRAN_070 | resource | rancher2_cluster_alert_group | Verify Rancher2 Cluster Alert Group Non-Zero Interval Seconds | checker/terraform/rules/rancher/rancher2_cluster_alert_group_interval_seconds.rego |
| CB_TFRAN_071 | resource | rancher2_cluster_alert_rule | Verify Rancher2 Cluster Alert Rule Configuration | checker/terraform/rules/rancher/rancher2_cluster_alert_rule_configuration.rego |
| CB_TFRAN_072 | resource | rancher2_cluster_driver | Verify Rancher2 Cluster Driver Configuration | checker/terraform/rules/rancher/rancher2_cluster_driver_configuration.rego |
| CB_TFRAN_073 | resource | rancher2_cluster_role_template_binding | Verify Rancher2 Cluster Role Template Binding Configuration | checker/terraform/rules/rancher/rancher2_cluster_role_template_binding_configuration.rego |
| CB_TFRAN_074 | resource | rancher2_cluster_sync | Verify Rancher2 Cluster Sync Configuration | checker/terraform/rules/rancher/rancher2_cluster_sync_configuration.rego |
| CB_TFRAN_075 | resource | rancher2_cluster_template | Verify Rancher2 Cluster Template Configuration | checker/terraform/rules/rancher/rancher2_cluster_template_configuration.rego |
| CB_TFRAN_076 | resource | rancher2_cluster_v2 | Verify Rancher2 Cluster V2 Configuration | checker/terraform/rules/rancher/rancher2_cluster_v2_configuration.rego |
| CB_TFRAN_077 | resource | rancher2_config_map_v2 | Verify Rancher2 Config Map V2 Configuration | checker/terraform/rules/rancher/rancher2_config_map_v2_configuration.rego |
| CB_TFRAN_078 | resource | rancher2_custom_user_token | Verify Rancher2 Custom User Token Configuration | checker/terraform/rules/rancher/rancher2_custom_user_token_configuration.rego |
| CB_TFRAN_079 | resource | rancher2_etcd_backup | Verify Rancher2 Etcd Backup Configuration | checker/terraform/rules/rancher/rancher2_etcd_backup_configuration.rego |
| CB_TFRAN_080 | resource | rancher2_feature | Verify Rancher2 Feature Configuration | checker/terraform/rules/rancher/rancher2_feature_configuration.rego |
| CB_TFRAN_081 | resource | rancher2_global_dns | Verify Rancher2 Global DNS Configuration | checker/terraform/rules/rancher/rancher2_global_dns_configuration.rego |
| CB_TFRAN_082 | resource | rancher2_global_dns_provider | Verify Rancher2 Global DNS Provider Configuration | checker/terraform/rules/rancher/rancher2_global_dns_provider_configuration.rego |
| CB_TFRAN_083 | resource | rancher2_global_role | Verify Rancher2 Global Role Configuration | checker/terraform/rules/rancher/rancher2_global_role_configuration.rego |
| CB_TFRAN_084 | resource | rancher2_global_role_binding | Verify Rancher2 Global Role Binding Configuration | checker/terraform/rules/rancher/rancher2_global_role_binding_configuration.rego |
| CB_TFRAN_085 | resource | rancher2_machine_config_v2 | Verify Rancher2 Machine Config V2 Configuration | checker/terraform/rules/rancher/rancher2_machine_config_v2_configuration.rego |
| CB_TFRAN_086 | resource | rancher2_multi_cluster_app | Verify Rancher2 Multi Cluster App Configuration | checker/terraform/rules/rancher/rancher2_multi_cluster_app_configuration.rego |
| CB_TFRAN_087 | resource | rancher2_namespace | Verify Rancher2 Namespace Configuration | checker/terraform/rules/rancher/rancher2_namespace_configuration.rego |
| CB_TFRAN_088 | resource | rancher2_node_driver | Verify Rancher2 Node Driver Configuration | checker/terraform/rules/rancher/rancher2_node_driver_configuration.rego |
| CB_TFRAN_089 | resource | rancher2_node_pool | Verify Rancher2 Node Pool Configuration | checker/terraform/rules/rancher/rancher2_node_pool_configuration.rego |
| CB_TFRAN_090 | resource | rancher2_node_template | Verify Rancher2 Node Template Configuration | checker/terraform/rules/rancher/rancher2_node_template_configuration.rego |
| CB_TFRAN_091 | resource | rancher2_notifier | Verify Rancher2 Notifier Configuration | checker/terraform/rules/rancher/rancher2_notifier_configuration.rego |
| CB_TFRAN_092 | resource | rancher2_pod_security_policy_template | Verify Rancher2 Pod Security Policy Template Configuration | checker/terraform/rules/rancher/rancher2_pod_security_policy_template_configuration.rego |
| CB_TFRAN_093 | resource | rancher2_project | Verify Rancher2 Project Configuration | checker/terraform/rules/rancher/rancher2_project_configuration.rego |
| CB_TFRAN_094 | resource | rancher2_project_alert_group | Verify Rancher2 Project Alert Group Configuration | checker/terraform/rules/rancher/rancher2_project_alert_group_configuration.rego |
| CB_TFRAN_095 | resource | rancher2_project_alert_rule | Verify Rancher2 Project Alert Rule Configuration | checker/terraform/rules/rancher/rancher2_project_alert_rule_configuration.rego |
| CB_TFRAN_096 | resource | rancher2_project_role_template_binding | Verify Rancher2 Project Role Template Binding Configuration | checker/terraform/rules/rancher/rancher2_project_role_template_binding_configuration.rego |
| CB_TFRAN_097 | resource | rancher2_registry | Verify Rancher2 Registry Configuration | checker/terraform/rules/rancher/rancher2_registry_configuration.rego |
| CB_TFRAN_098 | resource | rancher2_role_template | Verify Rancher2 Role Template Configuration | checker/terraform/rules/rancher/rancher2_role_template_configuration.rego |
| CB_TFRAN_099 | resource | rancher2_secret | Verify Rancher2 Secret Configuration | checker/terraform/rules/rancher/rancher2_secret_configuration.rego |
| CB_TFRAN_100 | resource | rancher2_secret_v2 | Verify Rancher2 Secret V2 Configuration | checker/terraform/rules/rancher/rancher2_secret_v2_configuration.rego |
| CB_TFRAN_101 | resource | rancher2_setting | Verify Rancher2 Setting Configuration | checker/terraform/rules/rancher/rancher2_setting_configuration.rego |
| CB_TFRAN_102 | resource | rancher2_storage_class_v2 | Verify Rancher2 Storage Class V2 Configuration | checker/terraform/rules/rancher/rancher2_storageClass_v2_configuration.rego |
| CB_TFRAN_103 | resource | rancher2_token | Verify Rancher2 Token Configuration | checker/terraform/rules/rancher/rancher2_token_configuration.rego |
| CB_TFRAN_104 | resource | rancher2_user | Verify Rancher2 User Configuration | checker/terraform/rules/rancher/rancher2_user_configuration.rego |
| CB_TFRAN_105 | resource | rancher2_cluster_alert_group | Verify Rancher2 Cluster Alert Group Recipients | checker/terraform/rules/rancher/rancher2_cluster_alert_group_recipients.rego |
| CB_TFRAN_106 | resource | rancher2_cluster_alert_rule | Validate Rancher2 Cluster Alert Rule Event Rule Usage | checker/terraform/rules/rancher/rancher2_cluster_alert_rule_event_rule.rego |
| CB_TFRAN_107 | resource | rancher2_cluster_alert_rule | Validate Rancher2 Cluster Alert Rule Metric Rule Usage | checker/terraform/rules/rancher/rancher2_cluster_alert_rule_metric_rule.rego |
| CB_TFRAN_108 | resource | rancher2_cluster_alert_rule | Validate Rancher2 Cluster Alert Rule Node Rule Usage | checker/terraform/rules/rancher/rancher2_cluster_alert_rule_node_rule.rego |
| CB_TFRAN_109 | resource | rancher2_multi_cluster_app | Verify Rancher2 Multi Cluster App Targets Configuration | checker/terraform/rules/rancher/rancher2_multi_cluster_app_targets_configuration.rego |
| CB_TFRAN_110 | resource | rancher2_node_pool | Verify Rancher2 Node Pool Configuration with Node Taints | checker/terraform/rules/rancher/rancher2_node_pool_configuration_with_node_taints.rego |
| CB_TFRAN_111 | resource | rancher2_project_alert_group | Verify Rancher2 Project Alert Non-Zero Interval Seconds | checker/terraform/rules/rancher/rancher2_project_alert_group_interval_seconds.rego |
| CB_TFRAN_112 | resource | rancher2_project_alert_group | Verify Rancher2 Project Alert Group Recipients | checker/terraform/rules/rancher/rancher2_project_alert_group_recipients.rego |
| CB_TFRAN_113 | resource | rancher2_registry | Verify Rancher2 Registry Configuration with Registries Data | checker/terraform/rules/rancher/rancher2_registry_configuration_with_registries_data.rego |
| CB_TFRAN_114 | resource | rancher2_secret | Verify Proper Base64 Data Values Configuration in Rancher2 Secret | checker/terraform/rules/rancher/rancher2_secret_base64_data_values.rego |
| CB_TFRAN_115 | resource | rancher2_cluster_driver | Verify Rancher2 Cluster Driver URLs uses HTTPS | checker/terraform/rules/rancher/rancher2_cluster_driver_https_urls.rego |
| CB_TFRAN_116 | resource | rancher2_cluster_driver | Verify Checksum and Whitelist Domains Configuration for Rancher2 Cluster Driver | checker/terraform/rules/rancher/rancher2_cluster_driver_checksum_whitelist_domains.rego |
| CB_TFRAN_117 | resource | rancher2_cluster_role_template_binding | Verify User and Group IDs in Rancher2 Cluster Role Template Binding Configuration | checker/terraform/rules/rancher/rancher2_cluster_role_template_binding_configuration_user_group_id.rego |
| CB_TFRAN_118 | resource | rancher2_cluster_sync | Verify Wait Configurations in Rancher2 Cluster Sync | checker/terraform/rules/rancher/rancher2_cluster_sync_wait_configuration.rego |
| CB_TFRAN_119 | resource | rancher2_cluster_sync | Verify Rancher2 Cluster Sync State Confirm is Non-Zero | checker/terraform/rules/rancher/rancher2_cluster_sync_state_confirm.rego |
| CB_TFRAN_120 | resource | rancher2_cluster_template | Verify Rancher2 Cluster Template Members | checker/terraform/rules/rancher/rancher2_cluster_template_members.rego |
| CB_TFRAN_121 | resource | rancher2_cluster_template | Verify Rancher2 Cluster Template Revisions | checker/terraform/rules/rancher/rancher2_cluster_template_revisions.rego |
| CB_TFRAN_122 | resource | rancher2_custom_user_token | Verify Rancher2 Custom User Token with Token Renewal | checker/terraform/rules/rancher/rancher2_custom_user_token_renew.rego |
| CB_TFRAN_123 | resource | rancher2_etcd_backup | Verify Backup Config for Rancher2 Etcd Backup | checker/terraform/rules/rancher/rancher2_etcd_backup_backup_config.rego |
| CB_TFRAN_124 | resource | rancher2_etcd_backup | Verify S3 Backup Config for Rancher2 Etcd Backup | checker/terraform/rules/rancher/rancher2_etcd_backup_s3_backup_config.rego |
| CB_TFRAN_125 | resource | rancher2_global_dns | Verify MultiCluster App ID for Rancher2 Global DNS | checker/terraform/rules/rancher/rancher2_global_dns_multi_cluster_app_id.rego |
| CB_TFRAN_126 | resource | rancher2_global_dns | Verify Project IDs for Rancher2 Global DNS | checker/terraform/rules/rancher/rancher2_global_dns_project_ids.rego |
| CB_TFRAN_127 | resource | rancher2_global_dns_provider | Verify AliDNS Domain for Rancher2 Global DNS Provider | checker/terraform/rules/rancher/rancher2_global_dns_provider_alidns_config.rego |
| CB_TFRAN_128 | resource | rancher2_global_dns_provider | Verify CloudFlare Domain for Rancher2 Global DNS Provider | checker/terraform/rules/rancher/rancher2_global_dns_provider_cloudflare_config.rego |
| CB_TFRAN_129 | resource | rancher2_global_dns_provider | Verify Route53 Domain for Rancher2 Global DNS Provider | checker/terraform/rules/rancher/rancher2_global_dns_provider_route53_config.rego |
| CB_TFRAN_130 | resource | rancher2_global_role | Verify Rancher 2 Global Role Configuration for New User Default | checker/terraform/rules/rancher/rancher2_global_role_new_user_default.rego |
| CB_TFRAN_131 | resource | rancher2_global_role_binding | Verify Rancher2 Global Role Binding Group Principal ID | checker/terraform/rules/rancher/rancher2_global_role_binding_group_principal_id.rego |
| CB_TFRAN_132 | resource | rancher2_global_role_binding | Verify Rancher2 Global Role Binding User ID | checker/terraform/rules/rancher/rancher2_global_role_binding_user_id.rego |
| CB_TFRAN_133 | resource | rancher2_machine_config_v2 | Verify AWS Configuration for Machine Config V2 | checker/terraform/rules/rancher/rancher2_machine_config_v2_amazonec2_config.rego |
| CB_TFRAN_134 | resource | rancher2_machine_config_v2 | Verify Azure Configuration for Machine Config V2 | checker/terraform/rules/rancher/rancher2_machine_config_v2_azure_config.rego |
| CB_TFRAN_135 | resource | rancher2_machine_config_v2 | Verify Digitalocean Configuration for Machine Config V2 | checker/terraform/rules/rancher/rancher2_machine_config_v2_digitalocean_config.rego |
| CB_TFRAN_136 | resource | rancher2_machine_config_v2 | Verify Harvester Configuration for Machine Config V2 | checker/terraform/rules/rancher/rancher2_machine_config_v2_harvester_config.rego |
| CB_TFRAN_137 | resource | rancher2_machine_config_v2 | Verify Linode Configuration for Machine Config V2 | checker/terraform/rules/rancher/rancher2_machine_config_v2_linode_config.rego |
| CB_TFRAN_138 | resource | rancher2_machine_config_v2 | Verify Openstack Configuration for Machine Config V2 | checker/terraform/rules/rancher/rancher2_machine_config_v2_openstack_config.rego |
| CB_TFRAN_139 | resource | rancher2_machine_config_v2 | Verify vSphere Configuration for Machine Config V2 | checker/terraform/rules/rancher/rancher2_machine_config_v2_vsphere_config.rego |
| CB_TFRAN_140 | resource | rancher2_multi_cluster_app | Verify Rancher2 Multi Cluster App Answers | checker/terraform/rules/rancher/rancher2_multi_cluster_app_answers.rego |
| CB_TFRAN_141 | resource | rancher2_namespace | Verify Rancher2 Namespace Container Resource Limit | checker/terraform/rules/rancher/rancher2_namespace_container_resource_limit.rego |
| CB_TFRAN_142 | resource | rancher2_namespace | Verify Rancher2 Namespace Resource Quota | checker/terraform/rules/rancher/rancher2_namespace_resource_quota.rego |
| CB_TFRAN_143 | resource | rancher2_node_driver | Verify Rancher2 Node Driver URLs uses HTTPS | checker/terraform/rules/rancher/rancher2_node_driver_https_urls.rego |
| CB_TFRAN_144 | resource | rancher2_node_driver | Verify Rancher2 Node Driver Specified Attributes not Empty | checker/terraform/rules/rancher/rancher2_node_driver_specified_attributes.rego |
| CB_TFRAN_145 | resource | rancher2_node_pool | Verify Rancher2 Node Pool Non-Zero Quantity | checker/terraform/rules/rancher/rancher2_node_pool_quantity.rego |
| CB_TFRAN_146 | resource | rancher2_node_pool | Verify Rancher2 Node Pool Roles for Created Nodes | checker/terraform/rules/rancher/rancher2_node_pool_roles.rego |
| CB_TFRAN_147 | resource | rancher2_node_template | Verify Supported Drivers in Rancher2 Node Template | checker/terraform/rules/rancher/rancher2_node_template_drivers.rego |
| CB_TFRAN_148 | resource | rancher2_node_template | Verify AmazonEC2 Configuration for Node Template | checker/terraform/rules/rancher/rancher2_node_template_amazonec2_config.rego |
| CB_TFRAN_149 | resource | rancher2_node_template | Verify Azure Configuration for Node Template | checker/terraform/rules/rancher/rancher2_node_template_azure_config.rego |
| CB_TFRAN_150 | resource | rancher2_node_template | Verify Digitalocean Configuration for Node Template | checker/terraform/rules/rancher/rancher2_node_template_digitalocean_config.rego |
| CB_TFRAN_151 | resource | rancher2_node_template | Verify Linode Configuration for Node Template | checker/terraform/rules/rancher/rancher2_node_template_linode_config.rego |
| CB_TFRAN_152 | resource | rancher2_node_template | Verify Harvester Configuration for Node Template | checker/terraform/rules/rancher/rancher2_node_template_harvester_config.rego |
| CB_TFRAN_153 | resource | rancher2_node_template | Verify Hetzner Configuration for Node Template | checker/terraform/rules/rancher/rancher2_node_template_hetzner_config.rego |
| CB_TFRAN_154 | resource | rancher2_node_template | Verify Opennebula Configuration for Node Template | checker/terraform/rules/rancher/rancher2_node_template_opennebula_config.rego |
| CB_TFRAN_155 | resource | rancher2_node_template | Verify Openstack Configuration for Node Template | checker/terraform/rules/rancher/rancher2_node_template_openstack_config.rego |
| CB_TFRAN_156 | resource | rancher2_node_template | Verify Outscale Configuration for Node Template | checker/terraform/rules/rancher/rancher2_node_template_outscale_config.rego |
| CB_TFRAN_157 | resource | rancher2_node_template | Verify vSphere Configuration for Node Template | checker/terraform/rules/rancher/rancher2_node_template_vsphere_config.rego |
| CB_TFRAN_158 | resource | rancher2_node_template | Verify Node Template Configuration Uses HTTPS URL | checker/terraform/rules/rancher/rancher2_node_template_https_url.rego |
| CB_TFRAN_159 | resource | rancher2_notifier | Verify Dingtalk Configuration for Rancher2 Notifier | checker/terraform/rules/rancher/rancher2_notifier_dingtalk_config.rego |
| CB_TFRAN_160 | resource | rancher2_notifier | Verify MSTeams Configuration for Rancher2 Notifier | checker/terraform/rules/rancher/rancher2_notifier_msteams_config.rego |
| CB_TFRAN_161 | resource | rancher2_notifier | Verify Pagerduty Configuration for Rancher2 Notifier | checker/terraform/rules/rancher/rancher2_notifier_pagerduty_config.rego |
| CB_TFRAN_162 | resource | rancher2_notifier | Verify Slack Configuration for Rancher2 Notifier | checker/terraform/rules/rancher/rancher2_notifier_slack_config.rego |
| CB_TFRAN_163 | resource | rancher2_notifier | Verify SMTP Configuration for Rancher2 Notifier | checker/terraform/rules/rancher/rancher2_notifier_smtp_config.rego |
| CB_TFRAN_164 | resource | rancher2_notifier | Verify Webhook Configuration for Rancher2 Notifier | checker/terraform/rules/rancher/rancher2_notifier_webhook_config.rego |
| CB_TFRAN_165 | resource | rancher2_notifier | Verify Wechat Configuration for Rancher2 Notifier | checker/terraform/rules/rancher/rancher2_notifier_wechat_config.rego |
| CB_TFRAN_166 | resource | rancher2_pod_security_policy_template | Verify Rancher2 Pod Security Policy Template Allowed Host Path | checker/terraform/rules/rancher/rancher2_pod_security_policy_template_allowed_host_path.rego |
| CB_TFRAN_167 | resource | rancher2_pod_security_policy_template | Verify Rancher2 Pod Security Policy Template Range | checker/terraform/rules/rancher/rancher2_pod_security_policy_template_range.rego |
| CB_TFRAN_168 | resource | rancher2_pod_security_policy_template | Verify Rancher2 Pod Security Policy Template Host Port | checker/terraform/rules/rancher/rancher2_pod_security_policy_template_host_port.rego |
| CB_TFRAN_169 | resource | rancher2_pod_security_policy_template | Verify Rancher2 Pod Security Policy Template Run As User | checker/terraform/rules/rancher/rancher2_pod_security_policy_template_run_as_user.rego |
| CB_TFRAN_170 | resource | rancher2_pod_security_policy_template | Verify Rancher2 Pod Security Policy Template Run As Group | checker/terraform/rules/rancher/rancher2_pod_security_policy_template_run_as_group.rego |
| CB_TFRAN_171 | resource | rancher2_pod_security_policy_template | Verify Rancher2 Pod Security Policy Template Runtime Class | checker/terraform/rules/rancher/rancher2_pod_security_policy_template_runtime_class.rego |
| CB_TFRAN_172 | resource | rancher2_pod_security_policy_template | Verify Rancher2 Pod Security Policy Template SE Linux | checker/terraform/rules/rancher/rancher2_pod_security_policy_template_se_linux.rego |
| CB_TFRAN_173 | resource | rancher2_pod_security_policy_template | Verify Rancher2 Pod Security Policy Template Supplemental Group | checker/terraform/rules/rancher/rancher2_pod_security_policy_template_supplemental_group.rego |
| CB_TFRAN_174 | resource | rancher2_project | Verify Rancher2 Project Container Resource Limit | checker/terraform/rules/rancher/rancher2_project_container_resource_limit.rego |
| CB_TFRAN_175 | resource | rancher2_project | Verify Rancher2 Project Resource Quota | checker/terraform/rules/rancher/rancher2_project_resource_quota.rego |
| CB_TFRAN_176 | resource | rancher2_project_alert_rule | Verify Rancher2 Project Alert Rule Metric Rule Usage | checker/terraform/rules/rancher/rancher2_project_alert_rule_metric_rule_usage.rego |
| CB_TFRAN_177 | resource | rancher2_project_alert_rule | Verify Rancher2 Project Alert Rule Pod Rule Usage | checker/terraform/rules/rancher/rancher2_project_alert_rule_pod_rule_usage.rego |
| CB_TFRAN_178 | resource | rancher2_project_alert_rule | Verify Rancher2 Project Alert Rule Workload Rule Usage | checker/terraform/rules/rancher/rancher2_project_alert_rule_workload_rule_usage.rego |
| CB_TFRAN_179 | resource | rancher2_project_role_template_binding | Verify User and Group IDs in Rancher2 Project Role Template Binding Configuration | checker/terraform/rules/rancher/rancher2_project_role_template_binding_user_group_id.rego |
| CB_TFRAN_180 | resource | rancher2_registry | Verify Rancher2 Registry Namespaced Registry | checker/terraform/rules/rancher/rancher2_registry_namespace_registry.rego |
| CB_TFRAN_181 | resource | rancher2_role_template | Verify Rancher Role Template Supported Context | checker/terraform/rules/rancher/rancher2_role_template_supported_context.rego |
| CB_TFRAN_182 | resource | rancher2_role_template | Verify Rancher Role Template Rules | checker/terraform/rules/rancher/rancher2_role_template_rules.rego |
| CB_TFRAN_183 | resource | rancher2_secret | Verify Rancher2 Secret Namespaced Secret | checker/terraform/rules/rancher/rancher2_secret_namespaced_secret.rego |
| CB_TFRAN_184 | resource | rancher2_storage_class_v2 | Verify Rancher2 Storage Class v2 Reclaim Policy | checker/terraform/rules/rancher/rancher2_storage_class_v2_reclaim_policy.rego |
| CB_TFRAN_185 | resource | rancher2_storage_class_v2 | Verify Rancher2 Storage Class v2 Volume Binding Mode | checker/terraform/rules/rancher/rancher2_storage_class_v2_volume_binding_mode.rego |
| CB_TFRAN_186 | resource | rancher2_token | Verify Rancher2 Token Renew | checker/terraform/rules/rancher/rancher2_token_renew.rego |
| CB_TFRAN_187 | resource | rancher2_user | Verify Rancher2 User Name | checker/terraform/rules/rancher/rancher2_user_name.rego |
| CB_TFRAN_188 | resource | rancher2_cluster_v2 | Verify Rancher2 Cluster V2 Agent Environment Variables | checker/terraform/rules/rancher/rancher2_cluster_v2_agent_env_vars.rego |
| CB_TFRAN_189 | resource | rancher2_feature | Verify Rancher2 Feature Value | checker/terraform/rules/rancher/rancher2_feature_value.rego |
| CB_TFRAN_190 | resource | rancher2_cluster_v2 | Verify Rancher2 Cluster V2 Pod Security Admission Configuration Template | checker/terraform/rules/rancher/rancher2_cluster_v2_pod_security_admission_configuration_template.rego |
| CB_TFRAN_191 | resource | rancher2_cluster_v2 | Verify Rancher2 Cluster V2 Pod Security Policies | checker/terraform/rules/rancher/rancher2_cluster_v2_pod_security_policy_template.rego |
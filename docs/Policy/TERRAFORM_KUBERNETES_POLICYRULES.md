# Terraform Kubernetes Policy Index


This document provides a comprehensive index of Terraform policies available in BrainIAC(Terraform Kubernetes).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TFK8S_001 | resource | kubernetes_pod_security_policy | Disallow containers that aim to distribute the host process ID namespace | checker/terraform/rules/kubernetes/kubernetes_pod_security_policy_host_pid_restricted.rego |
| CB_TFK8S_002 | resource | kubernetes_deployment | Verify Absence of Added Capabilities for Containers | checker/terraform/rules/kubernetes_pod_development_allow_capabilities.rego |
| CB_TFK8S_002 | resource | kubernetes_deployment_v1 | Verify Absence of Added Capabilities for Containers | checker/terraform/rules/kubernetes_pod_development_allow_capabilities.rego |
| CB_TFK8S_002 | resource | kubernetes_pod | Verify Absence of Added Capabilities for Containers | checker/terraform/rules/kubernetes_pod_development_allow_capabilities.rego |
| CB_TFK8S_002 | resource | kubernetes_pod_v1 | Verify Absence of Added Capabilities for Containers | checker/terraform/rules/kubernetes_pod_development_allow_capabilities.rego |
| CB_TFK8S_003 | resource | kubernetes_pod_security_policy | Disallow the inclusion of containers with elevated privileges | checker/terraform/rules/kubernetes/kubernetes_pod_security_policy_privileged_restricted.rego |
| CB_TFK8S_004 | resource | kubernetes_pod_security_policy | Prevent the inclusion of containers seeking to share the host IPC namespace | checker/terraform/rules/kubernetes/kubernetes_pod_security_policy_host_ipc_restricted.rego |
| CB_TFK8S_005 | resource | kubernetes_pod_security_policy | Containers must refrain from executing with the allowPrivilegeEscalation setting | checker/terraform/rules/kubernetes/kubernetes_pod_security_policy_allowprivilegeescalation_restricted.rego |
| CB_TFK8S_006 | resource | kubernetes_deployment | Confirm that the Liveness Probe is properly set up | checker/terraform/rules/kubernetes/kubernetes_deployment_liveness_probe_configured.rego |
| CB_TFK8S_006 | resource | kubernetes_deployment_v1 | Confirm that the Liveness Probe is properly set up | checker/terraform/rules/kubernetes/kubernetes_deployment_liveness_probe_configured.rego |
| CB_TFK8S_006 | resource | kubernetes_pod | Confirm that the Liveness Probe is properly set up | checker/terraform/rules/kubernetes/kubernetes_deployment_liveness_probe_configured.rego |
| CB_TFK8S_006 | resource | kubernetes_pod_v1 | Confirm that the Liveness Probe is properly set up | checker/terraform/rules/kubernetes/kubernetes_deployment_liveness_probe_configured.rego |
| CB_TFK8S_007 | resource | kubernetes_pod_security_policy | Disallow the admission of containers with root privileges | checker/terraform/rules/kubernetes/kubernetes_root_containers_restricted.rego |
| CB_TFK8S_008 | resource | kubernetes_deployment | Verify Absence of Unnecessary hostPort Specification | checker/terraform/rules/kubernetes_pod_development_host_port.rego |
| CB_TFK8S_008 | resource | kubernetes_deployment_v1 | Verify Absence of Unnecessary hostPort Specification | checker/terraform/rules/kubernetes_pod_development_host_port.rego |
| CB_TFK8S_008 | resource | kubernetes_pod | Verify Absence of Unnecessary hostPort Specification | checker/terraform/rules/kubernetes_pod_development_host_port.rego |
| CB_TFK8S_008 | resource | kubernetes_pod_v1 | Verify Absence of Unnecessary hostPort Specification | checker/terraform/rules/kubernetes_pod_development_host_port.rego |
| CB_TFK8S_009 | resource | kubernetes_daemon_set_v1 | Verify Absence of Exposed Docker Daemon Socket to Containers | checker/terraform/rules/kubernetes_pod_development_docker_socket_volume.rego |
| CB_TFK8S_009 | resource | kubernetes_daemonset | Verify Absence of Exposed Docker Daemon Socket to Containers | checker/terraform/rules/kubernetes_pod_development_docker_socket_volume.rego |
| CB_TFK8S_009 | resource | kubernetes_deployment | Verify Absence of Exposed Docker Daemon Socket to Containers | checker/terraform/rules/kubernetes_pod_development_docker_socket_volume.rego |
| CB_TFK8S_009 | resource | kubernetes_pod | Verify Absence of Exposed Docker Daemon Socket to Containers | checker/terraform/rules/kubernetes_pod_development_docker_socket_volume.rego |
| CB_TFK8S_009 | resource | kubernetes_pod_v1 | Verify Absence of Exposed Docker Daemon Socket to Containers | checker/terraform/rules/kubernetes_pod_development_docker_socket_volume.rego |
| CB_TFK8S_010 | resource | kubernetes_pod_security_policy | Disallow containers that possess the NET_RAW capability | checker/terraform/rules/kubernetes/kubernetes_pod_security_policy_containers_net_raw_restricted.rego |
| CB_TFK8S_011 | resource | kubernetes_deployment | Confirm that the readiness Probe is properly set up | checker/terraform/rules/kubernetes/kubernetes_deployment_readiness_probe_configured.rego |
| CB_TFK8S_011 | resource | kubernetes_deployment_v1 | Confirm that the readiness Probe is properly set up | checker/terraform/rules/kubernetes/kubernetes_deployment_readiness_probe_configured.rego |
| CB_TFK8S_011 | resource | kubernetes_pod | Confirm that the readiness Probe is properly set up | checker/terraform/rules/kubernetes/kubernetes_deployment_readiness_probe_configured.rego |
| CB_TFK8S_011 | resource | kubernetes_pod_v1 | Confirm that the readiness Probe is properly set up | checker/terraform/rules/kubernetes/kubernetes_deployment_readiness_probe_configured.rego |
| CB_TFK8S_012 | resource | kubernetes_deployment | Verify Minimization of Containers with NET_RAW Capability | checker/terraform/rules/kubernetes_pod_development_drop_capabilities.rego |
| CB_TFK8S_012 | resource | kubernetes_deployment_v1 | Verify Minimization of Containers with NET_RAW Capability | checker/terraform/rules/kubernetes_pod_development_drop_capabilities.rego |
| CB_TFK8S_012 | resource | kubernetes_pod | Verify Minimization of Containers with NET_RAW Capability | checker/terraform/rules/kubernetes_pod_development_drop_capabilities.rego |
| CB_TFK8S_012 | resource | kubernetes_pod_v1 | Verify Minimization of Containers with NET_RAW Capability | checker/terraform/rules/kubernetes_pod_development_drop_capabilities.rego |
| CB_TFK8S_013 | resource | kubernetes_deployment | Confirm that CPU requests are configured | checker/terraform/rules/kubernetes/kubernetes_deployment_cpu_requests_set.rego |
| CB_TFK8S_013 | resource | kubernetes_deployment_v1 | Confirm that CPU requests are configured | checker/terraform/rules/kubernetes/kubernetes_deployment_cpu_requests_set.rego |
| CB_TFK8S_013 | resource | kubernetes_pod | Confirm that CPU requests are configured | checker/terraform/rules/kubernetes/kubernetes_deployment_cpu_requests_set.rego |
| CB_TFK8S_013 | resource | kubernetes_pod_v1 | Confirm that CPU requests are configured | checker/terraform/rules/kubernetes/kubernetes_deployment_cpu_requests_set.rego |
| CB_TFK8S_014 | resource | kubernetes_deployment | Confirm that CPU limits are configured appropriately | checker/terraform/rules/kubernetes/kubernetes_deployment_cpu_limits_set.rego |
| CB_TFK8S_014 | resource | kubernetes_deployment_v1 | Confirm that CPU limits are configured appropriately | checker/terraform/rules/kubernetes/kubernetes_deployment_cpu_limits_set.rego |
| CB_TFK8S_014 | resource | kubernetes_pod | Confirm that CPU limits are configured appropriately | checker/terraform/rules/kubernetes/kubernetes_deployment_cpu_limits_set.rego |
| CB_TFK8S_014 | resource | kubernetes_pod_v1 | Confirm that CPU limits are configured appropriately | checker/terraform/rules/kubernetes/kubernetes_deployment_cpu_limits_set.rego |
| CB_TFK8S_015 | resource | kubernetes_pod_security_policy | Disallow containers attempting to distribute the host network namespace | checker/terraform/rules/kubernetes/kubernetes_pod_security_policy_host_network_restricted.rego |
| CB_TFK8S_016 | resource | kubernetes_daemon_set_v1 | Verify Application of Security Context to Pods, Deployments, and DaemonSets | checker/terraform/rules/kubernetes_pod_development_daemonsets_security_context.rego |
| CB_TFK8S_016 | resource | kubernetes_daemonset | Verify Application of Security Context to Pods, Deployments, and DaemonSets | checker/terraform/rules/kubernetes_pod_development_daemonsets_security_context.rego |
| CB_TFK8S_016 | resource | kubernetes_deployment | Verify Application of Security Context to Pods, Deployments, and DaemonSets | checker/terraform/rules/kubernetes_pod_development_daemonsets_security_context.rego |
| CB_TFK8S_016 | resource | kubernetes_deployment_v1 | Verify Application of Security Context to Pods, Deployments, and DaemonSets | checker/terraform/rules/kubernetes_pod_development_daemonsets_security_context.rego |
| CB_TFK8S_016 | resource | kubernetes_pod | Verify Application of Security Context to Pods, Deployments, and DaemonSets | checker/terraform/rules/kubernetes_pod_development_daemonsets_security_context.rego |
| CB_TFK8S_016 | resource | kubernetes_pod_v1 | Verify Application of Security Context to Pods, Deployments, and DaemonSets | checker/terraform/rules/kubernetes_pod_development_daemonsets_security_context.rego |
| CB_TFK8S_017 | resource | kubernetes_deployment |Verify Application of Security Context to Pods and Containers | checker/terraform/rules/kubernetes_pod_development_security_context.rego |
| CB_TFK8S_017 | resource | kubernetes_deployment_v1 | Verify Application of Security Context to Pods and Containers | checker/terraform/rules/kubernetes_pod_development_security_context.rego |
| CB_TFK8S_017 | resource | kubernetes_pod | Verify Application of Security Context to Pods and Containers | checker/terraform/rules/kubernetes_pod_development_security_context.rego |
| CB_TFK8S_017 | resource | kubernetes_pod_v1 | Verify Application of Security Context to Pods and Containers | checker/terraform/rules/kubernetes_pod_development_security_context.rego |
| CB_TFK8S_018 | resource | kubernetes_pod_security_policy | Verify Default Seccomp Profile Configuration | checker/terraform/rules/kubernetes_pod_security_policy_seccomp.rego |
| CB_TFK8S_019 | resource | kubernetes_deployment | Verify Absence of Tiller (Helm v2) Deployment | checker/terraform/rules/kubernetes_pod_development_tiller.rego |
| CB_TFK8S_019 | resource | kubernetes_deployment_v1 | Verify Absence of Tiller (Helm v2) Deployment | checker/terraform/rules/kubernetes_pod_development_tiller.rego |
| CB_TFK8S_019 | resource | kubernetes_pod | Verify Absence of Tiller (Helm v2) Deployment | checker/terraform/rules/kubernetes_pod_development_tiller.rego |
| CB_TFK8S_019 | resource | kubernetes_pod_v1 | Verify Absence of Tiller (Helm v2) Deployment | checker/terraform/rules/kubernetes_pod_development_tiller.rego |
| CB_TFK8S_020 | resource | kubernetes_deployment | Confirm that memory limits are configured appropriately | checker/terraform/rules/kubernetes/kubernetes_deployment_memory_limits_set.rego |
| CB_TFK8S_020 | resource | kubernetes_deployment_v1 | Confirm that memory limits are configured appropriately | checker/terraform/rules/kubernetes/kubernetes_deployment_memory_limits_set.rego |
| CB_TFK8S_020 | resource | kubernetes_pod | Confirm that memory limits are configured appropriately | checker/terraform/rules/kubernetes/kubernetes_deployment_memory_limits_set.rego |
| CB_TFK8S_020 | resource | kubernetes_pod_v1 | Confirm that memory limits are configured appropriately | checker/terraform/rules/kubernetes/kubernetes_deployment_memory_limits_set.rego |
| CB_TFK8S_021 | resource | kubernetes_deployment | Confirm that CPU requests are configured appropriately | checker/terraform/rules/kubernetes/kubernetes_deployment_cpu_requests_set.rego |
| CB_TFK8S_021 | resource | kubernetes_deployment_v1 | Confirm that CPU requests are configured appropriately | checker/terraform/rules/kubernetes/kubernetes_deployment_cpu_requests_set.rego |
| CB_TFK8S_021 | resource | kubernetes_pod | Confirm that CPU requests are configured appropriately | checker/terraform/rules/kubernetes/kubernetes_deployment_cpu_requests_set.rego |
| CB_TFK8S_021 | resource | kubernetes_pod_v1 | Confirm that CPU requests are configured appropriately | checker/terraform/rules/kubernetes/kubernetes_deployment_cpu_requests_set.rego |
| CB_TFK8S_022 | resource | kubernetes_deployment | Confirm that the image tag is set to a specific value and not left as latest or left blank | checker/terraform/rules/kubernetes/kubernetes_deployment_fixed_image_tag.rego |
| CB_TFK8S_022 | resource | kubernetes_deployment_v1 | Confirm that the image tag is set to a specific value and not left as latest or left blank | checker/terraform/rules/kubernetes/kubernetes_deployment_fixed_image_tag.rego |
| CB_TFK8S_022 | resource | kubernetes_pod | Confirm that the image tag is set to a specific value and not left as latest or left blank | checker/terraform/rules/kubernetes/kubernetes_deployment_fixed_image_tag.rego |
| CB_TFK8S_022 | resource | kubernetes_pod_v1 | Confirm that the image tag is set to a specific value and not left as latest or left blank | checker/terraform/rules/kubernetes/kubernetes_deployment_fixed_image_tag.rego |
| CB_TFK8S_023 | resource | kubernetes_deployment | Prefer Secrets as Files Over Environment Variables | checker/terraform/rules/kubernetes_pod_development_secrets.rego |
| CB_TFK8S_023 | resource | kubernetes_deployment_v1 | Prefer Secrets as Files Over Environment Variables | checker/terraform/rules/kubernetes_pod_development_secrets.rego |
| CB_TFK8S_023 | resource | kubernetes_pod | Prefer Secrets as Files Over Environment Variables | checker/terraform/rules/kubernetes_pod_development_secrets.rego |
| CB_TFK8S_023 | resource | kubernetes_pod_v1 | Prefer Secrets as Files Over Environment Variables | checker/terraform/rules/kubernetes_pod_development_secrets.rego |
| CB_TFK8S_024 | resource | kubernetes_pod_security_policy | Limit Container Capabilities during Admission | checker/terraform/rules/kubernetes_pod_security_policy_mimimize_capabilities.rego |
| CB_TFK8S_025 | resource | kubernetes_deployment | Disallow the inclusion of containers with elevated privileges | checker/terraform/rules/kubernetes/kubernetes_deployment_privileged_containers_restricted.rego |
| CB_TFK8S_025 | resource | kubernetes_deployment_v1 | Disallow the inclusion of containers with elevated privileges | checker/terraform/rules/kubernetes/kubernetes_deployment_privileged_containers_restricted.rego |
| CB_TFK8S_025 | resource | kubernetes_pod | Disallow the inclusion of containers with elevated privileges | checker/terraform/rules/kubernetes/kubernetes_deployment_privileged_containers_restricted.rego |
| CB_TFK8S_025 | resource | kubernetes_pod_v1 | Disallow the inclusion of containers with elevated privileges | checker/terraform/rules/kubernetes/kubernetes_deployment_privileged_containers_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_config_map | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_config_map_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_cron_job | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_cron_job_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_daemon_set_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_daemon_set | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_deployment | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_deployment_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_ingress | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_ingress_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_job | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_job_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_pod | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_pod_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_replication_controller | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_replication_controller_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_role_binding | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_role_binding_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_secret | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_secret_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_service | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_service_account | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_service_account_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_service_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_stateful_set | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_026 | resource | kubernetes_stateful_set_v1 | Avoid utilizing the default namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_default_namespace_restricted.rego |
| CB_TFK8S_027 | resource | kubernetes_deployment | Restrict Containers with Assigned Capabilities | checker/terraform/rules/kubernetes_pod_deployment_mimimize_capabilities.rego |
| CB_TFK8S_027 | resource | kubernetes_deployment_v1 | Restrict Containers with Assigned Capabilities | checker/terraform/rules/kubernetes_pod_deployment_mimimize_capabilities.rego |
| CB_TFK8S_027 | resource | kubernetes_pod | Restrict Containers with Assigned Capabilities | cchecker/terraform/rules/kubernetes_pod_deployment_mimimize_capabilities.rego |
| CB_TFK8S_027 | resource | kubernetes_pod_v1 | Restrict Containers with Assigned Capabilities | checker/terraform/rules/kubernetes_pod_deployment_mimimize_capabilities.rego |
| CB_TFK8S_028 | resource | kubernetes_deployment | Avoid Using CAP_SYS_ADMIN Linux Capability | checker/terraform/rules/kubernetes_pod_deployment_do_not_use_cap_sys_admin.rego |
| CB_TFK8S_028 | resource | kubernetes_deployment_v1 | Avoid Using CAP_SYS_ADMIN Linux Capability | checker/terraform/rules/kubernetes_pod_deployment_do_not_use_cap_sys_admin.rego |
| CB_TFK8S_028 | resource | kubernetes_pod_v1 | Avoid Using CAP_SYS_ADMIN Linux Capability | checker/terraform/rules/kubernetes_pod_deployment_do_not_use_cap_sys_admin.rego |
| CB_TFK8S_028 | resource | kubernetes_pod_v1 | Avoid Using CAP_SYS_ADMIN Linux Capability | checker/terraform/rules/kubernetes_pod_deployment_do_not_use_cap_sys_admin.rego |
| CB_TFK8S_029 | resource | kubernetes_service_account | Avoid Active Usage of Default Service Accounts | checker/terraform/rules/kubernetes_service_account_default_not_used.rego |
| CB_TFK8S_029 | resource | kubernetes_service_account_v1 | Avoid Active Usage of Default Service Accounts | checker/terraform/rules/kubernetes_service_account_default_not_used.rego |
| CB_TFK8S_030 | resource | kubernetes_cluster_role_binding | Prevent Active Usage of Default Service Accounts | checker/terraform/rules/kubernetes_cluster_role_binding_default_not_used.rego |
| CB_TFK8S_030 | resource | kubernetes_cluster_role_binding_v1 | Prevent Active Usage of Default Service Accounts | checker/terraform/rules/kubernetes_cluster_role_binding_default_not_used.rego |
| CB_TFK8S_030 | resource | kubernetes_role_binding | Prevent Active Usage of Default Service Accounts | checker/terraform/rules/kubernetes_cluster_role_binding_default_not_used.rego |
| CB_TFK8S_030 | resource | kubernetes_role_binding_v1 | Prevent Active Usage of Default Service Accounts | checker/terraform/rules/kubernetes_cluster_role_binding_default_not_used.rego |
| CB_TFK8S_031 | resource | kubernetes_deployment | Mandate the Use of Image Digests | checker/terraform/rules/kubernetes_pod_deployment_image_digest.rego |
| CB_TFK8S_031 | resource | kubernetes_deployment_v1 | Mandate the Use of Image Digests | checker/terraform/rules/kubernetes_pod_deployment_image_digest.rego |
| CB_TFK8S_031 | resource | kubernetes_pod | Mandate the Use of Image Digests | checker/terraform/rules/kubernetes_pod_deployment_image_digest.rego |
| CB_TFK8S_031 | resource | kubernetes_pod_v1 | Mandate the Use of Image Digests | checker/terraform/rules/kubernetes_pod_deployment_image_digest.rego |
| CB_TFK8S_032 | resource | kubernetes_service | Remove Tiller Service (Helm v2) | checker/terraform/rules/kubernetes_service_tiller_deleted.rego |
| CB_TFK8S_032 | resource | kubernetes_service_v1 | Remove Tiller Service (Helm v2) | checker/terraform/rules/kubernetes_service_tiller_deleted.rego |
| CB_TFK8S_033 | resource | kubernetes_role | Limit Wildcard Use in Roles and ClusterRoles | checker/terraform/rules/kubernetes_cluster_role_wild_card.rego |
| CB_TFK8S_033 | resource | kubernetes_role_v1 | Limit Wildcard Use in Roles and ClusterRoles | checker/terraform/rules/kubernetes_cluster_role_wild_card.rego |
| CB_TFK8S_033 | resource | kubernetes_cluster_role | Limit Wildcard Use in Roles and ClusterRoles | checker/terraform/rules/kubernetes_cluster_role_wild_card.rego |
| CB_TFK8S_033 | resource | kubernetes_cluster_role_v1 | Limit Wildcard Use in Roles and ClusterRoles | checker/terraform/rules/kubernetes_cluster_role_wild_card.rego |
| CB_TFK8S_034 | resource | kubernetes_deployment | Avoid allowing containers that intend to distribute the host process ID namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_container_host_process_id_namespace.rego |
| CB_TFK8S_034 | resource | kubernetes_deployment_v1 | Avoid allowing containers that intend to distribute the host process ID namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_container_host_process_id_namespace.rego |
| CB_TFK8S_035 | resource | kubernetes_pod | Avoid allowing containers that intend to distribute the host process ID namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_container_host_process_id_namespace.rego |
| CB_TFK8S_035 | resource | kubernetes_pod_v1 | Avoid allowing containers that intend to distribute the host process ID namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_container_host_process_id_namespace.rego |
| CB_TFK8S_036 | resource | kubernetes_deployment | Avoid allowing containers that intend to distribute the host IPC namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_host_ipc_namespace.rego |
| CB_TFK8S_036 | resource | kubernetes_deployment_v1 | Avoid allowing containers that intend to distribute the host IPC namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_host_ipc_namespace.rego |
| CB_TFK8S_037 | resource | kubernetes_pod | Avoid allowing containers that intend to distribute the host IPC namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_host_ipc_namespace.rego |
| CB_TFK8S_037 | resource | kubernetes_pod_v1 | Avoid allowing containers that intend to distribute the host IPC namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_host_ipc_namespace.rego |
| CB_TFK8S_038 | resource | kubernetes_deployment | Avoid allowing containers that intend to distribute the host network namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_host_network_namespace.rego |
| CB_TFK8S_038 | resource | kubernetes_deployment_v1 | Avoid allowing containers that intend to distribute the host network namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_host_network_namespace.rego |
| CB_TFK8S_039 | resource | kubernetes_pod | Avoid allowing containers that intend to distribute the host network namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_host_network_namespace.rego |
| CB_TFK8S_039 | resource | kubernetes_pod_v1 | Avoid allowing containers that intend to distribute the host network namespace | checker/terraform/rules/kubernetes/kubernetes_deployment_host_network_namespace.rego |
| CB_TFK8S_040 | resource | kubernetes_deployment | Employ a read-only filesystem whenever feasible for containers | checker/terraform/rules/kubernetes/kubernetes_deployment_read_only.rego |
| CB_TFK8S_040 | resource | kubernetes_deployment_v1 | Employ a read-only filesystem whenever feasible for containers | checker/terraform/rules/kubernetes/kubernetes_deployment_read_only.rego |
| CB_TFK8S_040 | resource | kubernetes_pod | Employ a read-only filesystem whenever feasible for containers | checker/terraform/rules/kubernetes/kubernetes_deployment_read_only.rego |
| CB_TFK8S_040 | resource | kubernetes_pod_v1 | Employ a read-only filesystem whenever feasible for containers | checker/terraform/rules/kubernetes/kubernetes_deployment_read_only.rego |
| CB_TFK8S_041 | resource | kubernetes_pod_security_policy | Prevent containers from having supplementary capabilities | checker/terraform/rules/kubernetes/kubernetes_pod_security_policy_container_capability.rego |
| CB_TFK8S_042 | resource | kubernetes_deployment | Confirm that the Image Pull Policy is set to 'Always' for containers | checker/terraform/rules/kubernetes/kubernetes_deployment_image_pull_policy.rego |
| CB_TFK8S_042 | resource | kubernetes_deployment_v1 | Confirm that the Image Pull Policy is set to 'Always' for containers | checker/terraform/rules/kubernetes/kubernetes_deployment_image_pull_policy.rego |
| CB_TFK8S_042 | resource | kubernetes_pod | Confirm that the Image Pull Policy is set to 'Always' for containers | checker/terraform/rules/kubernetes/kubernetes_deployment_image_pull_policy.rego |
| CB_TFK8S_042 | resource | kubernetes_pod_v1 | Confirm that the Image Pull Policy is set to 'Always' for containers | checker/terraform/rules/kubernetes/kubernetes_deployment_image_pull_policy.rego |
| CB_TFK8S_043 | resource | kubernetes_deployment | Containers must avoid operating with the allowPrivilegeEscalation setting | checker/terraform/rules/kubernetes/kubernetes_deployment_allow_privilege_esc_restricted.rego |
| CB_TFK8S_043 | resource | kubernetes_deployment_v1 | Containers must avoid operating with the allowPrivilegeEscalation setting | checker/terraform/rules/kubernetes/kubernetes_deployment_allow_privilege_esc_restricted.rego |
| CB_TFK8S_043 | resource | kubernetes_pod | Containers must avoid operating with the allowPrivilegeEscalation setting | checker/terraform/rules/kubernetes/kubernetes_deployment_allow_privilege_esc_restricted.rego |
| CB_TFK8S_043 | resource | kubernetes_pod_v1 | Containers must avoid operating with the allowPrivilegeEscalation setting | checker/terraform/rules/kubernetes/kubernetes_deployment_allow_privilege_esc_restricted.rego |
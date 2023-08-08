# Kubernetes Policy Index


This document provides a comprehensive index of Kubernetes policies available in BrainIAC.


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_K8S_001 | Resource | ConfigMap | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | CronJob | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | DaemonSet | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | Deployment | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | Ingress | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | Job | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | Pod | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | ReplicaSet | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | ReplicationController | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | Role | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | RoleBinding | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | Secret | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | Service | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | ServiceAccount | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_001 | Resource | StatefulSet | The default namespace should not be used | checker/kubernetes/rules/default_namespace.rego |
| CB_K8S_002 | Resource | CronJob | CPU requests should be specified | checker/kubernetes/rules/set_cpu_request.rego |
| CB_K8S_002 | Resource | DaemonSet | CPU requests should be specified | checker/kubernetes/rules/set_cpu_request.rego |
| CB_K8S_002 | Resource | Deployment | CPU requests should be specified | checker/kubernetes/rules/set_cpu_request.rego |
| CB_K8S_002 | Resource | Job | CPU requests should be specified | checker/kubernetes/rules/set_cpu_request.rego |
| CB_K8S_002 | Resource | Pod | CPU requests should be specified | checker/kubernetes/rules/set_cpu_request.rego |
| CB_K8S_002 | Resource | ReplicaSet | CPU requests should be specified | checker/kubernetes/rules/set_cpu_request.rego |
| CB_K8S_002 | Resource | ReplicationController | CPU requests should be specified | checker/kubernetes/rules/set_cpu_request.rego |
| CB_K8S_002 | Resource | StatefulSet | CPU requests should be specified | checker/kubernetes/rules/set_cpu_request.rego |
| CB_K8S_003 | Resource | CronJob | CPU limits should be set | checker/checker/kubernetes/rules/set_cpu_limit.rego |
| CB_K8S_003 | Resource | DaemonSet | CPU limits should be set | checker/checker/kubernetes/rules/set_cpu_limit.rego |
| CB_K8S_003 | Resource | Deployment | CPU limits should be set | checker/checker/kubernetes/rules/set_cpu_limit.rego |
| CB_K8S_003 | Resource | Job | CPU limits should be set | checker/checker/kubernetes/rules/set_cpu_limit.rego |
| CB_K8S_003 | Resource | Pod | CPU limits should be set | checker/checker/kubernetes/rules/set_cpu_limit.rego |
| CB_K8S_003 | Resource | ReplicaSet | CPU limits should be set | checker/checker/kubernetes/rules/set_cpu_limit.rego |
| CB_K8S_003 | Resource | ReplicationController | CPU limits should be set | checker/checker/kubernetes/rules/set_cpu_limit.rego |
| CB_K8S_003 | Resource | StatefulSet | CPU limits should be set | checker/checker/kubernetes/rules/set_cpu_limit.rego |
| CB_K8S_004 | Resource | Admission Configuration | Ensure that the admission control plugin EventRateLimit is set | checker/kubernetes/rules/admission_configuration.rego |
| CB_K8S_005 | Resource | ServiceAccount | Make sure default service accounts are not being utilized | checker/kubernetes/rules/service_accounts.rego |
| CB_K8S_005 | Resource | ClusterRoleBinding | Make sure default service accounts are not being utilized | checker/kubernetes/rules/service_accounts.rego |
| CB_K8S_005 | Resource | RoleBinding | Make sure default service accounts are not being utilized | checker/kubernetes/rules/service_accounts.rego |
| CB_K8S_006 | Resource | CronJob | Memory requests should be specified | checker/kubernetes/rules/set_memory_request.rego|
| CB_K8S_006 | Resource | DaemonSet | Memory requests should be specified | checker/kubernetes/rules/set_memory_request.rego|
| CB_K8S_006 | Resource | Deployment | Memory requests should be specified | checker/kubernetes/rules/set_memory_request.rego|
| CB_K8S_006 | Resource | Job | Memory requests should be specified | checker/kubernetes/rules/set_memory_request.rego|
| CB_K8S_006 | Resource | Pod | Memory requests should be specified | checker/kubernetes/rules/set_memory_request.rego|
| CB_K8S_006 | Resource | ReplicaSet | Memory requests should be specified | checker/kubernetes/rules/set_memory_request.rego|
| CB_K8S_006 | Resource | ReplicationController | Memory requests should be specified | checker/kubernetes/rules/set_memory_request.rego|
| CB_K8S_006 | Resource | StatefulSet | Memory requests should be specified | checker/kubernetes/rules/set_memory_request.rego|
| CB_K8S_007 | Resource | CronJob | Memory limits should be specified | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_007 | Resource | DaemonSet | Memory limits should be specified | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_007 | Resource | Deployment | Memory limits should be specified | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_007 | Resource | Job | Memory limits should be specified | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_007 | Resource | Pod | Memory limits should be specified | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_007 | Resource | ReplicaSet | Memory limits should be specified | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_007 | Resource | ReplicationController | Memory limits should be specified | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_007 | Resource | StatefulSet | Memory limits should be specified | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_008 | Resource | CronJob | Avoid using Image tag ':latest' | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_008 | Resource | DaemonSet | Avoid using Image tag ':latest' | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_008 | Resource | Deployment | Avoid using Image tag ':latest' | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_008 | Resource | Job | Avoid using Image tag ':latest' | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_008 | Resource | Pod | Avoid using Image tag ':latest' | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_008 | Resource | ReplicaSet | Avoid using Image tag ':latest' | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_008 | Resource | ReplicationController | Avoid using Image tag ':latest' | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_008 | Resource | StatefulSet | Avoid using Image tag ':latest' | checker/kubernetes/rules/avoid_using_image_latest.rego |
| CB_K8S_009 | Resource | ClusterRole | Should avoid the use of wildcard in Roles and ClusterRoles | checker/kubernetes/rules/rbac/wildcard_roles.rego |
| CB_K8S_009 | Resource | Role | Should avoid the use of wildcard in Roles and ClusterRoles | checker/kubernetes/rules/rbac/wildcard_roles.rego |
| CB_K8S_010 | Resource | CronJob | Always specify Image Pull Policy as Always | checker/kubernetes/rules/image_pull_policy_always.rego|
| CB_K8S_010 | Resource | DaemonSet | Always specify Image Pull Policy as Always | checker/kubernetes/rules/image_pull_policy_always.rego|
| CB_K8S_010 | Resource | Deployment | Always specify Image Pull Policy as Always | checker/kubernetes/rules/image_pull_policy_always.rego|
| CB_K8S_010 | Resource | Job | Always specify Image Pull Policy as Always | checker/kubernetes/rules/image_pull_policy_always.rego|
| CB_K8S_010 | Resource | Pod | Always specify Image Pull Policy as Always | checker/kubernetes/rules/image_pull_policy_always.rego|
| CB_K8S_010 | Resource | ReplicaSet | Always specify Image Pull Policy as Always | checker/kubernetes/rules/image_pull_policy_always.rego|
| CB_K8S_010 | Resource | ReplicationController | Always specify Image Pull Policy as Always | checker/kubernetes/rules/image_pull_policy_always.rego|
| CB_K8S_010 | Resource | StatefulSet | Always specify Image Pull Policy as Always | checker/kubernetes/rules/image_pull_policy_always.rego|
| CB_K8S_011 | Resource | ClusterRole | Limit the permission of validating or mutating admission webhook configurations from ClusterRoles | checker/kubernetes/rules/webhook_configurations.rego|
| CB_K8S_012 | Resource | CronJob | Make sure the container is not privileged | checker/kubernetes/rules/container_not_privileged.rego |
| CB_K8S_012 | Resource | DaemonSet | Make sure the container is not privileged | checker/kubernetes/rules/container_not_privileged.rego |
| CB_K8S_012 | Resource | Deployment | Make sure the container is not privileged | checker/kubernetes/rules/container_not_privileged.rego |
| CB_K8S_012 | Resource | Job | Make sure the container is not privileged | checker/kubernetes/rules/container_not_privileged.rego |
| CB_K8S_012 | Resource | Pod | Make sure the container is not privileged | checker/kubernetes/rules/container_not_privileged.rego |
| CB_K8S_012 | Resource | ReplicaSet | Make sure the container is not privileged | checker/kubernetes/rules/container_not_privileged.rego |
| CB_K8S_012 | Resource | ReplicationController | Make sure the container is not privileged | checker/kubernetes/rules/container_not_privileged.rego |
| CB_K8S_012 | Resource | StatefulSet | Make sure the container is not privileged | checker/kubernetes/rules/container_not_privileged.rego |
| CB_K8S_013 | Resource | CronJob | Make sure containers do not share host process ID namespace | checker/kubernetes/rules/share_host_PID.rego |
| CB_K8S_013 | Resource | DaemonSet | Make sure containers do not share host process ID namespace | checker/kubernetes/rules/share_host_PID.rego |
| CB_K8S_013 | Resource | Deployment | Make sure containers do not share host process ID namespace | checker/kubernetes/rules/share_host_PID.rego |
| CB_K8S_013 | Resource | Job | Make sure containers do not share host process ID namespace | checker/kubernetes/rules/share_host_PID.rego |
| CB_K8S_013 | Resource | Pod | Make sure containers do not share host process ID namespace | checker/kubernetes/rules/share_host_PID.rego |
| CB_K8S_013 | Resource | ReplicaSet | Make sure containers do not share host process ID namespace | checker/kubernetes/rules/share_host_PID.rego |
| CB_K8S_013 | Resource | ReplicationController | Make sure containers do not share host process ID namespace | checker/kubernetes/rules/share_host_PID.rego |
| CB_K8S_013 | Resource | StatefulSet | Make sure containers do not share host process ID namespace | checker/kubernetes/rules/share_host_PID.rego |
| CB_K8S_014 | Resource | ClusterRole | Limit the permission of certificatesigningrequests/approval or signers from ClusterRoles | checker/kubernetes/rules/rbac/signing_certificate_request.rego |
| CB_K8S_015 | Resource | CronJob | Containers must not share a host IPC namespace | checker/kubernetes/rules/share_host_IPC.rego |
| CB_K8S_015 | Resource | DaemonSet | Containers must not share a host IPC namespace | checker/kubernetes/rules/share_host_IPC.rego |
| CB_K8S_015 | Resource | Deployment | Containers must not share a host IPC namespace | checker/kubernetes/rules/share_host_IPC.rego |
| CB_K8S_015 | Resource | Job | Containers must not share a host IPC namespace | checker/kubernetes/rules/share_host_IPC.rego |
| CB_K8S_015 | Resource | Pod | Containers must not share a host IPC namespace | checker/kubernetes/rules/share_host_IPC.rego |
| CB_K8S_015 | Resource | ReplicaSet | Containers must not share a host IPC namespace | checker/kubernetes/rules/share_host_IPC.rego |
| CB_K8S_015 | Resource | ReplicationController | Containers must not share a host IPC namespace | checker/kubernetes/rules/share_host_IPC.rego |
| CB_K8S_015 | Resource | StatefulSet | Containers must not share a host IPC namespace | checker/kubernetes/rules/share_host_IPC.rego |
| CB_K8S_016 | Resource | CronJob | Should not run containers with allowPrivilegeEscalation | checker/kubernetes/rules/allow_privilege_escalation.rego |
| CB_K8S_016 | Resource | DaemonSet | Should not run containers with allowPrivilegeEscalation | checker/kubernetes/rules/allow_privilege_escalation.rego |
| CB_K8S_016 | Resource | Deployment | Should not run containers with allowPrivilegeEscalation | checker/kubernetes/rules/allow_privilege_escalation.rego |
| CB_K8S_016 | Resource | Job | Should not run containers with allowPrivilegeEscalation | checker/kubernetes/rules/allow_privilege_escalation.rego |
| CB_K8S_016 | Resource | Pod | Should not run containers with allowPrivilegeEscalation | checker/kubernetes/rules/allow_privilege_escalation.rego |
| CB_K8S_016 | Resource | ReplicaSet | Should not run containers with allowPrivilegeEscalation | checker/kubernetes/rules/allow_privilege_escalation.rego |
| CB_K8S_016 | Resource | ReplicationController | Should not run containers with allowPrivilegeEscalation | checker/kubernetes/rules/allow_privilege_escalation.rego |
| CB_K8S_016 | Resource | StatefulSet | Should not run containers with allowPrivilegeEscalation | checker/kubernetes/rules/allow_privilege_escalation.rego |
| CB_K8S_017 | Resource | CronJob | Containers must not share the host network namespace | checker/kubernetes/rules/share_host_network.rego |
| CB_K8S_017 | Resource | DaemonSet | Containers must not share the host network namespace | checker/kubernetes/rules/share_host_network.rego |
| CB_K8S_017 | Resource | Deployment | Containers must not share the host network namespace | checker/kubernetes/rules/share_host_network.rego |
| CB_K8S_017 | Resource | Job | Containers must not share the host network namespace | checker/kubernetes/rules/share_host_network.rego |
| CB_K8S_017 | Resource | Pod | Containers must not share the host network namespace | checker/kubernetes/rules/share_host_network.rego |
| CB_K8S_017 | Resource | ReplicaSet | Containers must not share the host network namespace | checker/kubernetes/rules/share_host_network.rego |
| CB_K8S_017 | Resource | ReplicationController | Containers must not share the host network namespace | checker/kubernetes/rules/share_host_network.rego |
| CB_K8S_017 | Resource | StatefulSet | Containers must not share the host network namespace | checker/kubernetes/rules/share_host_network.rego |
| CB_K8S_018 | Resource | ClusterRole | Limit the grant permission of RoleBindings or ClusterRoleBindings from ClusterRole or Role | checker/kubernetes/rules/rbac/bind_rolebinding.rego |
| CB_K8S_018 | Resource | Role | Limit the grant permission of RoleBindings or ClusterRoleBindings from ClusterRole or Role | checker/kubernetes/rules/rbac/bind_rolebinding.rego |
| CB_K8S_019 | Resource | CronJob | The root filesystem does not read only | checker/kubernetes/rules/root_filesystem_read only.rego |
| CB_K8S_019 | Resource | DaemonSet | The root filesystem does not read only | checker/kubernetes/rules/root_filesystem_read only.rego |
| CB_K8S_019 | Resource | Deployment | The root filesystem does not read only | checker/kubernetes/rules/root_filesystem_read only.rego |
| CB_K8S_019 | Resource | Job | The root filesystem does not read only | checker/kubernetes/rules/root_filesystem_read only.rego |
| CB_K8S_019 | Resource | Pod | The root filesystem does not read only | checker/kubernetes/rules/root_filesystem_read only.rego |
| CB_K8S_019 | Resource | ReplicaSet | The root filesystem does not read only | checker/kubernetes/rules/root_filesystem_read only.rego |
| CB_K8S_019 | Resource | ReplicationController | The root filesystem does not read only | checker/kubernetes/rules/root_filesystem_read only.rego |
| CB_K8S_019 | Resource | StatefulSet | The root filesystem does not read only | checker/kubernetes/rules/root_filesystem_read only.rego |
| CB_K8S_020 | Resource | CLusterRole | Limit the grant permission of Roles or ClusterRoles | checker/kubernetes/rules/rbac/escalate_roles.rego |
| CB_K8S_020 | Resource | Role | Limit the grant permission of Roles or ClusterRoles | checker/kubernetes/rules/rbac/escalate_roles.rego |
| CB_K8S_021 | Resource | CronJob | Minimize the admission of root user | checker/kubernetes/rules/admission_of_non_root.rego |
| CB_K8S_021 | Resource | DaemonSet | Minimize the admission of root user | checker/kubernetes/rules/admission_of_non_root.rego |
| CB_K8S_021 | Resource | Deployment | Minimize the admission of root user | checker/kubernetes/rules/admission_of_non_root.rego |
| CB_K8S_021 | Resource | Job | Minimize the admission of root user | checker/kubernetes/rules/admission_of_non_root.rego |
| CB_K8S_021 | Resource | Pod | Minimize the admission of root user | checker/kubernetes/rules/admission_of_non_root.rego |
| CB_K8S_021 | Resource | ReplicaSet | Minimize the admission of root user | checker/kubernetes/rules/admission_of_non_root.rego |
| CB_K8S_021 | Resource | ReplicationController | Minimize the admission of root user | checker/kubernetes/rules/admission_of_non_root.rego |
| CB_K8S_021 | Resource | StatefulSet | Minimize the admission of root user | checker/kubernetes/rules/admission_of_non_root.rego |
| CB_K8S_022 | Resource | ClusterRole | Limit the grant permission of ClusterRoles for 'nodes/proxy' and 'pods/exec' | checker/kubernetes/rules/rbac/node_proxy_pod_exec.rego |
| CB_K8S_022 | Resource | ClusterRoleBinding | Limit the grant permission of ClusterRoles for 'nodes/proxy' and 'pods/exec' | checker/kubernetes/rules/rbac/node_proxy_pod_exec.rego |
| CB_K8S_022 | Resource | Role | Limit the grant permission of ClusterRoles for 'nodes/proxy' and 'pods/exec' | checker/kubernetes/rules/rbac/node_proxy_pod_exec.rego|
| CB_K8S_022 | Resource | RoleBinding | Limit the grant permission of ClusterRoles for 'nodes/proxy' and 'pods/exec' | checker/kubernetes/rules/rbac/node_proxy_pod_exec.rego |
| CB_K8S_023 | Resource | CronJob | Verify the admission of containers with added capability | checker/kubernetes/rules/admission_of_container_capabilities.rego |
| CB_K8S_023 | Resource | DaemonSet | Verify the admission of containers with added capability | checker/kubernetes/rules/admission_of_container_capabilities.rego |
| CB_K8S_023 | Resource | Deployment | Verify the admission of containers with added capability | checker/kubernetes/rules/admission_of_container_capabilities.rego |
| CB_K8S_023 | Resource | Job | Verify the admission of containers with added capability | checker/kubernetes/rules/admission_of_container_capabilities.rego |
| CB_K8S_023 | Resource | Pod | Verify the admission of containers with added capability | checker/kubernetes/rules/admission_of_container_capabilities.rego |
| CB_K8S_023 | Resource | ReplicaSet | Verify the admission of containers with added capability | checker/kubernetes/rules/admission_of_container_capabilities.rego |
| CB_K8S_023 | Resource | ReplicationController | Verify the admission of containers with added capability | checker/kubernetes/rules/admission_of_container_capabilities.rego |
| CB_K8S_023 | Resource | StatefulSet | Verify the admission of containers with added capability | checker/kubernetes/rules/admission_of_container_capabilities.rego |
| CB_K8S_024 | Resource | ClusterRole | ServiceAccount/Node should not have 'impersonate' permissions for user-accounts/users/groups | checker/kubernetes/rules/rbac/impersonate_permissions.rego |
| CB_K8S_024 | Resource | ClusterRoleBinding | ServiceAccount/Node should not have 'impersonate' permissions for user-accounts/users/groups | checker/kubernetes/rules/rbac/impersonate_permissions.rego |
| CB_K8S_024 | Resource | Role | ServiceAccount/Node should not have 'impersonate' permissions for user-accounts/users/groups | checker/kubernetes/rules/rbac/impersonate_permissions.rego |
| CB_K8S_024 | Resource | RoleBinding | ServiceAccount/Node should not have 'impersonate' permissions for user-accounts/users/groups | checker/kubernetes/rules/rbac/impersonate_permissions.rego |
| CB_K8S_025 | Resource | ClusterRole | RoleBinding should not allow privilege escalation to a ServiceAccount or Node on other RoleBinding | checker/kubernetes/rules/rolebinding_PE.rego |
| CB_K8S_025 | Resource | ClusterRoleBinding | RoleBinding should not allow privilege escalation to a ServiceAccount or Node on other RoleBinding | checker/kubernetes/rules/rolebinding_PE.rego |
| CB_K8S_025| Resource | RoleBinding | RoleBinding should not allow privilege escalation to a ServiceAccount or Node on other RoleBinding | checker/kubernetes/rules/rolebinding_PE.rego |
| CB_K8S_026 | Resource | ClusterRole | ServiceAccount/Node should not able to all read secrets | checker/kubernetes/rules/rbac/read_all_secrets.rego |
| CB_K8S_026 | Resource | ClusterRoleBinding | ServiceAccount/Node should not able to all read secrets | checker/kubernetes/rules/rbac/read_all_secrets.rego |
| CB_K8S_026 | Resource | Role | ServiceAccount/Node should not able to all read secrets | checker/kubernetes/rules/rbac/read_all_secrets.rego |
| CB_K8S_026| Resource | RoleBinding | ServiceAccount/Node should not able to all read secrets | checker/kubernetes/rules/rbac/read_all_secrets.rego |
| CB_K8S_027 | Resource | ClusterRole | ServiceAccount/Node should not able to modify the `status.loadBalancer.ingress.ip` field | checker/kubernetes/rules/rbac/modify_service_status.rego |
| CB_K8S_027 | Resource | ClusterRoleBinding | ServiceAccount/Node should not able to modify the `status.loadBalancer.ingress.ip` field | checker/kubernetes/rules/rbac/modify_service_status.rego |
| CB_K8S_027 | Resource | Role | ServiceAccount/Node should not able to modify the `status.loadBalancer.ingress.ip` field | checker/kubernetes/rules/rbac/modify_service_status.rego |
| CB_K8S_027| Resource | RoleBinding | ServiceAccount/Node should not able to modify the `status.loadBalancer.ingress.ip` field | checker/kubernetes/rules/rbac/modify_service_status.rego |
| CB_K8S_028 | Resource | CronJob | Verify that the --read-only-port argument is set to 0 | checker/kubernetes/rules/read_only_port.rego |
| CB_K8S_028 | Resource | DaemonSet | Verify that the --read-only-port argument is set to 0 | checker/kubernetes/rules/read_only_port.rego |
| CB_K8S_028 | Resource | Deployment | Verify that the --read-only-port argument is set to 0 | checker/kubernetes/rules/read_only_port.rego |
| CB_K8S_028 | Resource | Job | Verify that the --read-only-port argument is set to 0 | checker/kubernetes/rules/read_only_port.rego |
| CB_K8S_028 | Resource | Pod | Verify that the --read-only-port argument is set to 0 | checker/kubernetes/rules/read_only_port.rego |
| CB_K8S_028 | Resource | ReplicaSet | Verify that the --read-only-port argument is set to 0 | checker/kubernetes/rules/read_only_port.rego |
| CB_K8S_028 | Resource | ReplicationController | Verify that the --read-only-port argument is set to 0 | checker/kubernetes/rules/read_only_port.rego |
| CB_K8S_028 | Resource | StatefulSet | Verify that the --read-only-port argument is set to 0 | checker/kubernetes/rules/read_only_port.rego | 
| CB_K8S_029 | Resource | Service | Delete the Tiller (Helm v2) service | checker/kubernetes/rules/tiller_service_delete.rego | 
| CB_K8S_030 | Resource | CronJob | Do not specify hostPort except when absolutely necessary | checker/kubernetes/rules/do_not_specify_host_port.rego |
| CB_K8S_030 | Resource | DaemonSet | Do not specify hostPort except when absolutely necessary | checker/kubernetes/rules/do_not_specify_host_port.rego |
| CB_K8S_030 | Resource | Deployment | Do not specify hostPort except when absolutely necessary | checker/kubernetes/rules/do_not_specify_host_port.rego |
| CB_K8S_030 | Resource | Job | Do not specify hostPort except when absolutely necessary | checker/kubernetes/rules/do_not_specify_host_port.rego |
| CB_K8S_030 | Resource | Pod | Do not specify hostPort except when absolutely necessary | checker/kubernetes/rules/do_not_specify_host_port.rego |
| CB_K8S_030 | Resource | ReplicaSet | Do not specify hostPort except when absolutely necessary | checker/kubernetes/rules/do_not_specify_host_port.rego |
| CB_K8S_030 | Resource | ReplicationController | Do not specify hostPort except when absolutely necessary | checker/kubernetes/rules/do_not_specify_host_port.rego |
| CB_K8S_030 | Resource | StatefulSet | Do not specify hostPort except when absolutely necessary | checker/kubernetes/rules/do_not_specify_host_port.rego | 
| CB_K8S_031 | Resource | CronJob | Do not expose Docker's socket to containers | checker/kubernetes/rules/do_not_expose_docker_daemon.rego |
| CB_K8S_031 | Resource | DaemonSet | Do not expose Docker's socket to containers | checker/kubernetes/rules/do_not_expose_docker_daemon.rego |
| CB_K8S_031 | Resource | Deployment | Do not expose Docker's socket to containers | checker/kubernetes/rules/do_not_expose_docker_daemon.rego |
| CB_K8S_031 | Resource | Job | Do not expose Docker's socket to containers | checker/kubernetes/rules/do_not_expose_docker_daemon.rego |
| CB_K8S_031 | Resource | Pod | Do not expose Docker's socket to containers | checker/kubernetes/rules/do_not_expose_docker_daemon.rego |
| CB_K8S_031 | Resource | ReplicaSet | Do not expose Docker's socket to containers | checker/kubernetes/rules/do_not_expose_docker_daemon.rego |
| CB_K8S_031 | Resource | ReplicationController | Do not expose Docker's socket to containers | checker/kubernetes/rules/do_not_expose_docker_daemon.rego |
| CB_K8S_031 | Resource | StatefulSet | Do not expose Docker's socket to containers | checker/kubernetes/rules/do_not_expose_docker_daemon.rego |
| CB_K8S_032 | Resource | CronJob | Admission of containers with NET_RAW capability is not minimized | checker/kubernetes/rules/admission_of_container_with_NET_RAW.rego |
| CB_K8S_032 | Resource | DaemonSet | Admission of containers with NET_RAW capability is not minimized | checker/kubernetes/rules/admission_of_container_with_NET_RAW.rego |
| CB_K8S_032 | Resource | Deployment | Admission of containers with NET_RAW capability is not minimized | checker/kubernetes/rules/admission_of_container_with_NET_RAW.rego |
| CB_K8S_032 | Resource | Job | Admission of containers with NET_RAW capability is not minimized | checker/kubernetes/rules/admission_of_container_with_NET_RAW.rego |
| CB_K8S_032 | Resource | Pod | Admission of containers with NET_RAW capability is not minimized | checker/kubernetes/rules/admission_of_container_with_NET_RAW.rego |
| CB_K8S_032 | Resource | ReplicaSet | Admission of containers with NET_RAW capability is not minimized | checker/kubernetes/rules/admission_of_container_with_NET_RAW.rego |
| CB_K8S_032 | Resource | ReplicationController | Admission of containers with NET_RAW capability is not minimized | checker/kubernetes/rules/admission_of_container_with_NET_RAW.rego |
| CB_K8S_032 | Resource | StatefulSet | Admission of containers with NET_RAW capability is not minimized | checker/kubernetes/rules/admission_of_container_with_NET_RAW.rego | 
| CB_K8S_033 | Resource | CronJob | SecurityContext is not applied to pods and containers | checker/kubernetes/rules/admission_of_security_context.rego |
| CB_K8S_033 | Resource | DaemonSet | SecurityContext is not applied to pods and containers | checker/kubernetes/rules/admission_of_security_context.rego |
| CB_K8S_033 | Resource | Deployment | SecurityContext is not applied to pods and containers | checker/kubernetes/rules/admission_of_security_context.rego |
| CB_K8S_033 | Resource | Job | SecurityContext is not applied to pods and containers | checker/kubernetes/rules/admission_of_security_context.rego |
| CB_K8S_033 | Resource | Pod | SecurityContext is not applied to pods and containers | checker/kubernetes/rules/admission_of_security_context.rego |
| CB_K8S_033 | Resource | ReplicaSet | SecurityContext is not applied to pods and containers | checker/kubernetes/rules/admission_of_security_context.rego |
| CB_K8S_033 | Resource | ReplicationController | SecurityContext is not applied to pods and containers | checker/kubernetes/rules/admission_of_security_context.rego |
| CB_K8S_033 | Resource | StatefulSet | SecurityContext is not applied to pods and containers | checker/kubernetes/rules/admission_of_security_context.rego |
| CB_K8S_034 | Resource | CronJob | Verify that seccomp is configured as Docker/Default or Runtime/Default | checker/kubernetes/rules/verify_seccomp_is_configured.rego |
| CB_K8S_034 | Resource | DaemonSet | Verify that seccomp is configured as Docker/Default or Runtime/Default | checker/kubernetes/rules/verify_seccomp_is_configured.rego |
| CB_K8S_034 | Resource | Deployment | Verify that seccomp is configured as Docker/Default or Runtime/Default | checker/kubernetes/rules/verify_seccomp_is_configured.rego |
| CB_K8S_034 | Resource | Job | Verify that seccomp is configured as Docker/Default or Runtime/Default | checker/kubernetes/rules/verify_seccomp_is_configured.rego |
| CB_K8S_034 | Resource | Pod | Verify that seccomp is configured as Docker/Default or Runtime/Default | checker/kubernetes/rules/verify_seccomp_is_configured.rego |
| CB_K8S_034 | Resource | ReplicaSet | Verify that seccomp is configured as Docker/Default or Runtime/Default | checker/kubernetes/rules/verify_seccomp_is_configured.rego |
| CB_K8S_034 | Resource | ReplicationController | Verify that seccomp is configured as Docker/Default or Runtime/Default | checker/kubernetes/rules/verify_seccomp_is_configured.rego |
| CB_K8S_034 | Resource | StatefulSet | Verify that seccomp is configured as Docker/Default or Runtime/Default | checker/kubernetes/rules/verify_seccomp_is_configured.rego |
| CB_K8S_035 | Resource | CronJob | Verify that the Kubernetes dashboard is not deployed | checker/kubernetes/rules/verify_kubernetes_dashboard.rego |
| CB_K8S_035 | Resource | DaemonSet | Verify that the Kubernetes dashboard is not deployed | checker/kubernetes/rules/verify_kubernetes_dashboard.rego |
| CB_K8S_035 | Resource | Deployment | Verify that the Kubernetes dashboard is not deployed | checker/kubernetes/rules/verify_kubernetes_dashboard.rego |
| CB_K8S_035 | Resource | Job | Verify that the Kubernetes dashboard is not deployed | checker/kubernetes/rules/verify_kubernetes_dashboard.rego |
| CB_K8S_035 | Resource | Pod | Verify that the Kubernetes dashboard is not deployed | checker/kubernetes/rules/verify_kubernetes_dashboard.rego |
| CB_K8S_035 | Resource | ReplicaSet | Verify that the Kubernetes dashboard is not deployed | checker/kubernetes/rules/verify_kubernetes_dashboard.rego |
| CB_K8S_035 | Resource | ReplicationController | Verify that the Kubernetes dashboard is not deployed | checker/kubernetes/rules/verify_kubernetes_dashboard.rego |
| CB_K8S_035 | Resource | StatefulSet | Verify that the Kubernetes dashboard is not deployed | checker/kubernetes/rules/verify_kubernetes_dashboard.rego | 
| CB_K8S_036 | Resource | CronJob | Use secrets as files rather than secrets as environment variables | checker/kubernetes/rules/secret_as_environment_variable.rego |
| CB_K8S_036 | Resource | DaemonSet | Use secrets as files rather than secrets as environment variables | checker/kubernetes/rules/secret_as_environment_variable.rego |
| CB_K8S_036 | Resource | Deployment | Use secrets as files rather than secrets as environment variables | checker/kubernetes/rules/secret_as_environment_variable.rego |
| CB_K8S_036 | Resource | Job | Use secrets as files rather than secrets as environment variables | checker/kubernetes/rules/secret_as_environment_variable.rego |
| CB_K8S_036 | Resource | Pod | Use secrets as files rather than secrets as environment variables | checker/kubernetes/rules/secret_as_environment_variable.rego |
| CB_K8S_036 | Resource | ReplicaSet | Use secrets as files rather than secrets as environment variables | checker/kubernetes/rules/secret_as_environment_variable.rego |
| CB_K8S_036 | Resource | ReplicationController | Use secrets as files rather than secrets as environment variables | checker/kubernetes/rules/secret_as_environment_variable.rego |
| CB_K8S_036 | Resource | StatefulSet | Use secrets as files rather than secrets as environment variables | checker/kubernetes/rules/secret_as_environment_variable.rego | 
| CB_K8S_037 | Resource | Ingress | Prevent NGINX Ingress annotation snippets which contain LUA code execution. See CVE-2021-25742 | checker/kubernetes/rules/ingress_annotation_snippets.rego | 
| CB_K8S_038 | Resource | CronJob | Verify that the --streaming-connection-idle-timeout is set to 0 | checker/kubernetes/rules/streaming_connnection_idle_timeout.rego |
| CB_K8S_038 | Resource | DaemonSet | Verify that the --streaming-connection-idle-timeout is set to 0 | checker/kubernetes/rules/streaming_connnection_idle_timeout.rego |
| CB_K8S_038 | Resource | Deployment | Verify that the --streaming-connection-idle-timeout is set to 0 | checker/kubernetes/rules/streaming_connnection_idle_timeout.rego |
| CB_K8S_038 | Resource | Job | Verify that the --streaming-connection-idle-timeout is set to 0 | checker/kubernetes/rules/streaming_connnection_idle_timeout.rego |
| CB_K8S_038 | Resource | Pod | Verify that the --streaming-connection-idle-timeout is set to 0 | checker/kubernetes/rules/streaming_connnection_idle_timeout.rego |
| CB_K8S_038 | Resource | ReplicaSet | Verify that the --streaming-connection-idle-timeout is set to 0 | checker/kubernetes/rules/streaming_connnection_idle_timeout.rego |
| CB_K8S_038 | Resource | ReplicationController | Verify that the --streaming-connection-idle-timeout is set to 0 | checker/kubernetes/rules/streaming_connnection_idle_timeout.rego |
| CB_K8S_038 | Resource | StatefulSet | Verify that the --streaming-connection-idle-timeout is set to 0 | checker/kubernetes/rules/streaming_connnection_idle_timeout.rego |
| CB_K8S_039 | Resource | CronJob | Verify that the --protect-kernel-defaults argument is set to true | checker/kubernetes/rules/protect_kernel_defaults.rego |
| CB_K8S_039 | Resource | DaemonSet | Verify that the --protect-kernel-defaults argument is set to true | checker/kubernetes/rules/protect_kernel_defaults.rego |
| CB_K8S_039 | Resource | Deployment | Verify that the --protect-kernel-defaults argument is set to true | checker/kubernetes/rules/protect_kernel_defaults.rego |
| CB_K8S_039 | Resource | Job | Verify that the --protect-kernel-defaults argument is set to true | checker/kubernetes/rules/protect_kernel_defaults.rego |
| CB_K8S_039 | Resource | Pod | Verify that the --protect-kernel-defaults argument is set to true | checker/kubernetes/rules/protect_kernel_defaults.rego |
| CB_K8S_039 | Resource | ReplicaSet | Verify that the --protect-kernel-defaults argument is set to true | checker/kubernetes/rules/protect_kernel_defaults.rego |
| CB_K8S_039 | Resource | ReplicationController | Verify that the --protect-kernel-defaults argument is set to true | checker/kubernetes/rules/protect_kernel_defaults.rego |
| CB_K8S_039 | Resource | StatefulSet | Verify that the --protect-kernel-defaults argument is set to true | checker/kubernetes/rules/protect_kernel_defaults.rego | 
| CB_K8S_040 | Resource | CronJob | Verify that the --make-iptables-util-chains argument is set to true | checker/kubernetes/rules/make_iptables_util_chains.rego |
| CB_K8S_040 | Resource | DaemonSet | Verify that the --make-iptables-util-chains argument is set to true | checker/kubernetes/rules/make_iptables_util_chains.rego |
| CB_K8S_040 | Resource | Deployment | Verify that the --make-iptables-util-chains argument is set to true | checker/kubernetes/rules/make_iptables_util_chains.rego |
| CB_K8S_040 | Resource | Job | Verify that the --make-iptables-util-chains argument is set to true | checker/kubernetes/rules/make_iptables_util_chains.rego |
| CB_K8S_040 | Resource | Pod | Verify that the --make-iptables-util-chains argument is set to true | checker/kubernetes/rules/make_iptables_util_chains.rego |
| CB_K8S_040 | Resource | ReplicaSet | Verify that the --make-iptables-util-chains argument is set to true | checker/kubernetes/rules/make_iptables_util_chains.rego |
| CB_K8S_040 | Resource | ReplicationController | Verify that the --make-iptables-util-chains argument is set to true | checker/kubernetes/rules/make_iptables_util_chains.rego |
| CB_K8S_040 | Resource | StatefulSet | Verify that the --make-iptables-util-chains argument is set to true | checker/kubernetes/rules/make_iptables_util_chains.rego | 
| CB_K8S_041 | Resource | PodSecurityPolicy | Admission of containers with capability is not minimized | checker/kubernetes/rules/admission_of_container_limited_capabilities.rego |
| CB_K8S_041 | Resource | CronJob | Admission of containers with capability is not minimized | checker/kubernetes/rules/admission_of_container_limited_capabilities.rego |
| CB_K8S_041 | Resource | DaemonSet | Admission of containers with capability is not minimized | checker/kubernetes/rules/admission_of_container_limited_capabilities.rego |
| CB_K8S_041 | Resource | Deployment | Admission of containers with capability is not minimized | checker/kubernetes/rules/admission_of_container_limited_capabilities.rego |
| CB_K8S_041 | Resource | Job | Admission of containers with capability is not minimized | checker/kubernetes/rules/admission_of_container_limited_capabilities.rego |
| CB_K8S_041 | Resource | Pod | Admission of containers with capability is not minimized | checker/kubernetes/rules/admission_of_container_limited_capabilities.rego |
| CB_K8S_041 | Resource | ReplicaSet | Admission of containers with capability is not minimized | checker/kubernetes/rules/admission_of_container_limited_capabilities.rego |
| CB_K8S_041 | Resource | ReplicationController | Admission of containers with capability is not minimized | checker/kubernetes/rules/admission_of_container_limited_capabilities.rego |
| CB_K8S_041 | Resource | StatefulSet | Admission of containers with capability is not minimized | checker/kubernetes/rules/admission_of_container_limited_capabilities.rego | 
| CB_K8S_042 | Resource | CronJob | Verify account tokens not mounted where necessary | checker/kubernetes/rules/verify_account_tokens_not_mounted_where_necessary.rego |
| CB_K8S_042 | Resource | DaemonSet | Verify account tokens not mounted where necessary | checker/kubernetes/rules/verify_account_tokens_not_mounted_where_necessary.rego |
| CB_K8S_042 | Resource | Deployment | Verify account tokens not mounted where necessary | checker/kubernetes/rules/verify_account_tokens_not_mounted_where_necessary.rego |
| CB_K8S_042 | Resource | Job | Verify account tokens not mounted where necessary | checker/kubernetes/rules/verify_account_tokens_not_mounted_where_necessary.rego |
| CB_K8S_042 | Resource | Pod | Verify account tokens not mounted where necessary | checker/kubernetes/rules/verify_account_tokens_not_mounted_where_necessary.rego |
| CB_K8S_042 | Resource | ReplicaSet | Verify account tokens not mounted where necessary | checker/kubernetes/rules/verify_account_tokens_not_mounted_where_necessary.rego |
| CB_K8S_042 | Resource | ReplicationController | Verify account tokens not mounted where necessary | checker/kubernetes/rules/verify_account_tokens_not_mounted_where_necessary.rego |
| CB_K8S_042 | Resource | StatefulSet | Verify account tokens not mounted where necessary | checker/kubernetes/rules/verify_account_tokens_not_mounted_where_necessary.rego |
| CB_K8S_043 | Resource | CronJob | Verify that the --hostname-override argument is not set | checker/kubernetes/rules/hostname_override.rego |
| CB_K8S_043 | Resource | DaemonSet | Verify that the --hostname-override argument is not set | checker/kubernetes/rules/hostname_override.rego |
| CB_K8S_043 | Resource | Deployment | Verify that the --hostname-override argument is not set | checker/kubernetes/rules/hostname_override.rego |
| CB_K8S_043 | Resource | Job | Verify that the --hostname-override argument is not set | checker/kubernetes/rules/hostname_override.rego |
| CB_K8S_043 | Resource | Pod | Verify that the --hostname-override argument is not set | checker/kubernetes/rules/hostname_override.rego |
| CB_K8S_043 | Resource | ReplicaSet | Verify that the --hostname-override argument is not set | checker/kubernetes/rules/hostname_override.rego |
| CB_K8S_043 | Resource | ReplicationController | Verify that the --hostname-override argument is not set | checker/kubernetes/rules/hostname_override.rego |
| CB_K8S_043 | Resource | StatefulSet | Verify that the --hostname-override argument is not set | checker/kubernetes/rules/hostname_override.rego | 
| CB_K8S_044 | Resource | CronJob | Verify Tiller (Helm V2) is not deployed | checker/kubernetes/rules/verify_tiller_helmv2_not_deployed.rego |
| CB_K8S_044 | Resource | DaemonSet | Verify Tiller (Helm V2) is not deployed | checker/kubernetes/rules/verify_tiller_helmv2_not_deployed.rego |
| CB_K8S_044 | Resource | Deployment | Verify Tiller (Helm V2) is not deployed | checker/kubernetes/rules/verify_tiller_helmv2_not_deployed.rego |
| CB_K8S_044 | Resource | Job | Verify Tiller (Helm V2) is not deployed | checker/kubernetes/rules/verify_tiller_helmv2_not_deployed.rego |
| CB_K8S_044 | Resource | Pod | Verify Tiller (Helm V2) is not deployed | checker/kubernetes/rules/verify_tiller_helmv2_not_deployed.rego |
| CB_K8S_044 | Resource | ReplicaSet | Verify Tiller (Helm V2) is not deployed | checker/kubernetes/rules/verify_tiller_helmv2_not_deployed.rego |
| CB_K8S_044 | Resource | ReplicationController | Verify Tiller (Helm V2) is not deployed | checker/kubernetes/rules/verify_tiller_helmv2_not_deployed.rego |
| CB_K8S_044 | Resource | StatefulSet | Verify Tiller (Helm V2) is not deployed | checker/kubernetes/rules/verify_tiller_helmv2_not_deployed.rego | 
| CB_K8S_045 | Resource | CronJob | Verify CAP_SYS_ADMIN capability is not use | checker/kubernetes/rules/verify_CAP_SYS_ADMIN_capability_not_use.rego |
| CB_K8S_045 | Resource | DaemonSet | Verify CAP_SYS_ADMIN capability is not use | checker/kubernetes/rules/verify_CAP_SYS_ADMIN_capability_not_use.rego |
| CB_K8S_045 | Resource | Deployment | Verify CAP_SYS_ADMIN capability is not use | checker/kubernetes/rules/verify_CAP_SYS_ADMIN_capability_not_use.rego |
| CB_K8S_045 | Resource | Job | Verify CAP_SYS_ADMIN capability is not use | checker/kubernetes/rules/verify_CAP_SYS_ADMIN_capability_not_use.rego |
| CB_K8S_045 | Resource | Pod | Verify CAP_SYS_ADMIN capability is not use | checker/kubernetes/rules/verify_CAP_SYS_ADMIN_capability_not_use.rego |
| CB_K8S_045 | Resource | ReplicaSet | Verify CAP_SYS_ADMIN capability is not use | checker/kubernetes/rules/verify_CAP_SYS_ADMIN_capability_not_use.rego |
| CB_K8S_045 | Resource | ReplicationController | Verify CAP_SYS_ADMIN capability is not use | checker/kubernetes/rules/verify_CAP_SYS_ADMIN_capability_not_use.rego |
| CB_K8S_045 | Resource | StatefulSet | Verify CAP_SYS_ADMIN capability is not use | checker/kubernetes/rules/verify_CAP_SYS_ADMIN_capability_not_use.rego | 
| CB_K8S_046 | Resource | CronJob | Verify containers run with a high UID | checker/kubernetes/rules/verify_containers_high_UID.rego |
| CB_K8S_046 | Resource | DaemonSet | Verify containers run with a high UID | checker/kubernetes/rules/verify_containers_high_UID.rego |
| CB_K8S_046 | Resource | Deployment | Verify containers run with a high UID | checker/kubernetes/rules/verify_containers_high_UID.rego |
| CB_K8S_046 | Resource | Job | Verify containers run with a high UID | checker/kubernetes/rules/verify_containers_high_UID.rego |
| CB_K8S_046 | Resource | Pod | Verify containers run with a high UID | checker/kubernetes/rules/verify_containers_high_UID.rego |
| CB_K8S_046 | Resource | ReplicaSet | Verify containers run with a high UID | checker/kubernetes/rules/verify_containers_high_UID.rego |
| CB_K8S_046 | Resource | ReplicationController | Verify containers run with a high UID | checker/kubernetes/rules/verify_containers_high_UID.rego |
| CB_K8S_046 | Resource | StatefulSet | Verify containers run with a high UID | checker/kubernetes/rules/verify_containers_high_UID.rego |
| CB_K8S_047 | Resource | Ingress | Prevent All NGINX Ingress annotation snippets. See CVE-2021-25742 | checker/kubernetes/rules/ingress_annotation_remove.rego |
| CB_K8S_048 | Resource | CronJob | Verify that the --event-qps argument is set to 0 or a level that ensures appropriate event capture | checker/kubernetes/rules/event_capture.rego |
| CB_K8S_048 | Resource | DaemonSet | Verify that the --event-qps argument is set to 0 or a level that ensures appropriate event capture | checker/kubernetes/rules/event_capture.rego |
| CB_K8S_048 | Resource | Deployment | Verify that the --event-qps argument is set to 0 or a level that ensures appropriate event capture | checker/kubernetes/rules/event_capture.rego |
| CB_K8S_048 | Resource | Job | Verify that the --event-qps argument is set to 0 or a level that ensures appropriate event capture | checker/kubernetes/rules/event_capture.rego |
| CB_K8S_048 | Resource | Pod | Verify that the --event-qps argument is set to 0 or a level that ensures appropriate event capture | checker/kubernetes/rules/event_capture.rego |
| CB_K8S_048 | Resource | ReplicaSet | Verify that the --event-qps argument is set to 0 or a level that ensures appropriate event capture | checker/kubernetes/rules/event_capture.rego |
| CB_K8S_048 | Resource | ReplicationController | Verify that the --event-qps argument is set to 0 or a level that ensures appropriate event capture | checker/kubernetes/rules/event_capture.rego |
| CB_K8S_048 | Resource | StatefulSet | Verify that the --event-qps argument is set to 0 or a level that ensures appropriate event capture | checker/kubernetes/rules/event_capture.rego | 
| CB_K8S_049 | Resource | CronJob | Verify that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate | checker/kubernetes/rules/cert_and_private_file.rego |
| CB_K8S_049 | Resource | DaemonSet | Verify that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate | checker/kubernetes/rules/cert_and_private_file.rego |
| CB_K8S_049 | Resource | Deployment | Verify that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate | checker/kubernetes/rules/cert_and_private_file.rego |
| CB_K8S_049 | Resource | Job | Verify that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate | checker/kubernetes/rules/cert_and_private_file.rego |
| CB_K8S_049 | Resource | Pod | Verify that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate | checker/kubernetes/rules/cert_and_private_file.rego |
| CB_K8S_049 | Resource | ReplicaSet | Verify that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate | checker/kubernetes/rules/cert_and_private_file.rego |
| CB_K8S_049 | Resource | ReplicationController | Verify that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate | checker/kubernetes/rules/cert_and_private_file.rego |
| CB_K8S_049 | Resource | StatefulSet | Verify that the --tls-cert-file and --tls-private-key-file arguments are set as appropriate | checker/kubernetes/rules/cert_and_private_file.rego | 
| CB_K8S_050 | Resource | CronJob | Verify Tiller (Helm V2) deployment is not accessible from within the cluster | checker/kubernetes/rules/verify_tiller_helmv2_not_accessible.rego |
| CB_K8S_050 | Resource | DaemonSet | Verify Tiller (Helm V2) deployment is not accessible from within the cluster | checker/kubernetes/rules/verify_tiller_helmv2_not_accessible.rego |
| CB_K8S_050 | Resource | Deployment | Verify Tiller (Helm V2) deployment is not accessible from within the cluster | checker/kubernetes/rules/verify_tiller_helmv2_not_accessible.rego |
| CB_K8S_050 | Resource | Job | Verify Tiller (Helm V2) deployment is not accessible from within the cluster | checker/kubernetes/rules/verify_tiller_helmv2_not_accessible.rego |
| CB_K8S_050 | Resource | Pod | Verify Tiller (Helm V2) deployment is not accessible from within the cluster | checker/kubernetes/rules/verify_tiller_helmv2_not_accessible.rego |
| CB_K8S_050 | Resource | ReplicaSet | Verify Tiller (Helm V2) deployment is not accessible from within the cluster | checker/kubernetes/rules/verify_tiller_helmv2_not_accessible.rego |
| CB_K8S_050 | Resource | ReplicationController | Verify Tiller (Helm V2) deployment is not accessible from within the cluster | checker/kubernetes/rules/verify_tiller_helmv2_not_accessible.rego |
| CB_K8S_050 | Resource | StatefulSet | Verify Tiller (Helm V2) deployment is not accessible from within the cluster | checker/kubernetes/rules/verify_tiller_helmv2_not_accessible.rego | 
| CB_K8S_051 | Resource | Ingress | Prevent NGINX Ingress annotation snippets which contain alias statements See CVE-2021-25742 | checker/kubernetes/rules/ingress_annotation_alias.rego | 
| CB_K8S_052 | Resource | CronJob | Verify that the --rotate-certificates argument not set to false | checker/kubernetes/rules/rotate_certificates.rego |
| CB_K8S_052 | Resource | DaemonSet | Verify that the --rotate-certificates argument not set to false | checker/kubernetes/rules/rotate_certificates.rego |
| CB_K8S_052 | Resource | Deployment | Verify that the --rotate-certificates argument not set to false | checker/kubernetes/rules/rotate_certificates.rego |
| CB_K8S_052 | Resource | Job | Verify that the --rotate-certificates argument not set to false | checker/kubernetes/rules/rotate_certificates.rego |
| CB_K8S_052 | Resource | Pod | Verify that the --rotate-certificates argument not set to false | checker/kubernetes/rules/rotate_certificates.rego |
| CB_K8S_052 | Resource | ReplicaSet | Verify that the --rotate-certificates argument not set to false | checker/kubernetes/rules/rotate_certificates.rego |
| CB_K8S_052 | Resource | ReplicationController | Verify that the --rotate-certificates argument not set to false | checker/kubernetes/rules/rotate_certificates.rego |
| CB_K8S_052 | Resource | StatefulSet | Verify that the --rotate-certificates argument not set to false | checker/kubernetes/rules/rotate_certificates.rego | 
| CB_K8S_053 | Resource | CronJob | Verify that the kubelet only use Strong Cryptographic Ciphers | checker/kubernetes/rules/cryptographic_ciphers.rego |
| CB_K8S_053 | Resource | DaemonSet | Verify that the kubelet only use Strong Cryptographic Ciphers | checker/kubernetes/rules/cryptographic_ciphers.rego |
| CB_K8S_053 | Resource | Deployment | Verify that the kubelet only use Strong Cryptographic Ciphers | checker/kubernetes/rules/cryptographic_ciphers.rego |
| CB_K8S_053 | Resource | Job | Verify that the kubelet only use Strong Cryptographic Ciphers | checker/kubernetes/rules/cryptographic_ciphers.rego |
| CB_K8S_053 | Resource | Pod | Verify that the kubelet only use Strong Cryptographic Ciphers | checker/kubernetes/rules/cryptographic_ciphers.rego |
| CB_K8S_053 | Resource | ReplicaSet | Verify that the kubelet only use Strong Cryptographic Ciphers | checker/kubernetes/rules/cryptographic_ciphers.rego |
| CB_K8S_053 | Resource | ReplicationController | Verify that the kubelet only use Strong Cryptographic Ciphers | checker/kubernetes/rules/cryptographic_ciphers.rego |
| CB_K8S_053 | Resource | StatefulSet | Verify that the kubelet only use Strong Cryptographic Ciphers | checker/kubernetes/rules/cryptographic_ciphers.rego | 
| CB_K8S_054 | Resource | CronJob | Verify the --anonymous-auth argument is set to False | checker/kubernetes/rules/verify_anonymous_auth.rego |
| CB_K8S_054 | Resource | DaemonSet | Verify the --anonymous-auth argument is set to False | checker/kubernetes/rules/verify_anonymous_auth.rego |
| CB_K8S_054 | Resource | Deployment | Verify the --anonymous-auth argument is set to False | checker/kubernetes/rules/verify_anonymous_auth.rego |
| CB_K8S_054 | Resource | Job | Verify the --anonymous-auth argument is set to False | checker/kubernetes/rules/verify_anonymous_auth.rego |
| CB_K8S_054 | Resource | Pod | Verify the --anonymous-auth argument is set to False | checker/kubernetes/rules/verify_anonymous_auth.rego |
| CB_K8S_054 | Resource | ReplicaSet | Verify the --anonymous-auth argument is set to False | checker/kubernetes/rules/verify_anonymous_auth.rego |
| CB_K8S_054 | Resource | ReplicationController | Verify the --anonymous-auth argument is set to False | checker/kubernetes/rules/verify_anonymous_auth.rego |
| CB_K8S_054 | Resource | StatefulSet | Verify the --anonymous-auth argument is set to False | checker/kubernetes/rules/verify_anonymous_auth.rego | 
| CB_K8S_055 | Resource | CronJob | Verify that the --basic-auth-file argument is not set | checker/kubernetes/rules/verify_basic_auth_file.rego |
| CB_K8S_055 | Resource | DaemonSet | Verify that the --basic-auth-file argument is not set | checker/kubernetes/rules/verify_basic_auth_file.rego |
| CB_K8S_055 | Resource | Deployment | Verify that the --basic-auth-file argument is not set | checker/kubernetes/rules/verify_basic_auth_file.rego |
| CB_K8S_055 | Resource | Job | Verify that the --basic-auth-file argument is not set | checker/kubernetes/rules/verify_basic_auth_file.rego |
| CB_K8S_055 | Resource | Pod | Verify that the --basic-auth-file argument is not set | checker/kubernetes/rules/verify_basic_auth_file.rego |
| CB_K8S_055 | Resource | ReplicaSet | Verify that the --basic-auth-file argument is not set | checker/kubernetes/rules/verify_basic_auth_file.rego |
| CB_K8S_055 | Resource | ReplicationController | Verify that the --basic-auth-file argument is not set | checker/kubernetes/rules/verify_basic_auth_file.rego |
| CB_K8S_055 | Resource | StatefulSet | Verify that the --basic-auth-file argument is not set | checker/kubernetes/rules/verify_basic_auth_file.rego | 
| CB_K8S_056 | Resource | CronJob | Verify that the --token-auth-file argument is not set | checker/kubernetes/rules/verify_token_auth_file_not_set.rego |
| CB_K8S_056 | Resource | DaemonSet | Verify that the --token-auth-file argument is not set | checker/kubernetes/rules/verify_token_auth_file_not_set.rego |
| CB_K8S_056 | Resource | Deployment | Verify that the --token-auth-file argument is not set | checker/kubernetes/rules/verify_token_auth_file_not_set.rego |
| CB_K8S_056 | Resource | Job | Verify that the --token-auth-file argument is not set | checker/kubernetes/rules/verify_token_auth_file_not_set.rego |
| CB_K8S_056 | Resource | Pod | Verify that the --token-auth-file argument is not set | checker/kubernetes/rules/verify_token_auth_file_not_set.rego |
| CB_K8S_056 | Resource | ReplicaSet | Verify that the --token-auth-file argument is not set | checker/kubernetes/rules/verify_token_auth_file_not_set.rego |
| CB_K8S_056 | Resource | ReplicationController | Verify that the --token-auth-file argument is not set | checker/kubernetes/rules/verify_token_auth_file_not_set.rego |
| CB_K8S_056 | Resource | StatefulSet | Verify that the --token-auth-file argument is not set | checker/kubernetes/rules/verify_token_auth_file_not_set.rego | 
| CB_K8S_057 | Resource | CronJob | Verify that --kubelet-https argument is set to True | checker/kubernetes/rules/verify_kubelet_https_not_true.rego |
| CB_K8S_057 | Resource | DaemonSet | Verify that --kubelet-https argument is set to True | checker/kubernetes/rules/verify_kubelet_https_not_true.rego |
| CB_K8S_057 | Resource | Deployment | Verify that --kubelet-https argument is set to True | checker/kubernetes/rules/verify_kubelet_https_not_true.rego |
| CB_K8S_057 | Resource | Job | Verify that --kubelet-https argument is set to True | checker/kubernetes/rules/verify_kubelet_https_not_true.rego |
| CB_K8S_057 | Resource | Pod | Verify that --kubelet-https argument is set to True | checker/kubernetes/rules/verify_kubelet_https_not_true.rego |
| CB_K8S_057 | Resource | ReplicaSet | Verify that --kubelet-https argument is set to True | checker/kubernetes/rules/verify_kubelet_https_not_true.rego |
| CB_K8S_057 | Resource | ReplicationController | Verify that --kubelet-https argument is set to True | checker/kubernetes/rules/verify_kubelet_https_not_true.rego |
| CB_K8S_057 | Resource | StatefulSet | Verify that --kubelet-https argument is set to True | checker/kubernetes/rules/verify_kubelet_https_not_true.rego | 
| CB_K8S_058 | Resource | CronJob | Verify that the --use-service-account-credentials argument is set to true | checker/kubernetes/rules/controller_manager_service_account_credential.rego |
| CB_K8S_058 | Resource | DaemonSet | Verify that the --use-service-account-credentials argument is set to true | checker/kubernetes/rules/controller_manager_service_account_credential.rego |
| CB_K8S_058 | Resource | Deployment | Verify that the --use-service-account-credentials argument is set to true | checker/kubernetes/rules/controller_manager_service_account_credential.rego |
| CB_K8S_058 | Resource | Job | Verify that the --use-service-account-credentials argument is set to true | checker/kubernetes/rules/controller_manager_service_account_credential.rego |
| CB_K8S_058 | Resource | Pod | Verify that the --use-service-account-credentials argument is set to true | checker/kubernetes/rules/controller_manager_service_account_credential.rego |
| CB_K8S_058 | Resource | ReplicaSet | Verify that the --use-service-account-credentials argument is set to true | checker/kubernetes/rules/controller_manager_service_account_credential.rego |
| CB_K8S_058 | Resource | ReplicationController | Verify that the --use-service-account-credentials argument is set to true | checker/kubernetes/rules/controller_manager_service_account_credential.rego |
| CB_K8S_058 | Resource | StatefulSet | Verify that the --use-service-account-credentials argument is set to true | checker/kubernetes/rules/controller_manager_service_account_credential.rego | 
| CB_K8S_059 | Resource | CronJob | Verify that --kubelet-client-certificate and --kubelet-client-key arguments are set appropriately | cchecker/kubernetes/rules/verify_kubelet_client_cert_and_key.rego |
| CB_K8S_059 | Resource | DaemonSet | Verify that --kubelet-client-certificate and --kubelet-client-key arguments are set appropriately | cchecker/kubernetes/rules/verify_kubelet_client_cert_and_key.rego |
| CB_K8S_059 | Resource | Deployment | Verify that --kubelet-client-certificate and --kubelet-client-key arguments are set appropriately | cchecker/kubernetes/rules/verify_kubelet_client_cert_and_key.rego |
| CB_K8S_059 | Resource | Job | Verify that --kubelet-client-certificate and --kubelet-client-key arguments are set appropriately | cchecker/kubernetes/rules/verify_kubelet_client_cert_and_key.rego |
| CB_K8S_059 | Resource | Pod | Verify that --kubelet-client-certificate and --kubelet-client-key arguments are set appropriately | cchecker/kubernetes/rules/verify_kubelet_client_cert_and_key.rego |
| CB_K8S_059 | Resource | ReplicaSet | Verify that --kubelet-client-certificate and --kubelet-client-key arguments are set appropriately | cchecker/kubernetes/rules/verify_kubelet_client_cert_and_key.rego |
| CB_K8S_059 | Resource | ReplicationController | Verify that --kubelet-client-certificate and --kubelet-client-key arguments are set appropriately | cchecker/kubernetes/rules/verify_kubelet_client_cert_and_key.rego |
| CB_K8S_059 | Resource | StatefulSet | Verify that --kubelet-client-certificate and --kubelet-client-key arguments are set appropriately | cchecker/kubernetes/rules/verify_kubelet_client_cert_and_key.rego | 
| CB_K8S_060 | Resource | CronJob | Verify that the --kubelet-certificate-authority argument is set as it should be | checker/kubernetes/rules/verify_the_kubelet_certificate_authority_is_set.rego |
| CB_K8S_060 | Resource | DaemonSet | Verify that the --kubelet-certificate-authority argument is set as it should be | checker/kubernetes/rules/verify_the_kubelet_certificate_authority_is_set.rego |
| CB_K8S_060 | Resource | Deployment | Verify that the --kubelet-certificate-authority argument is set as it should be | checker/kubernetes/rules/verify_the_kubelet_certificate_authority_is_set.rego |
| CB_K8S_060 | Resource | Job | Verify that the --kubelet-certificate-authority argument is set as it should be | checker/kubernetes/rules/verify_the_kubelet_certificate_authority_is_set.rego |
| CB_K8S_060 | Resource | Pod | Verify that the --kubelet-certificate-authority argument is set as it should be | checker/kubernetes/rules/verify_the_kubelet_certificate_authority_is_set.rego |
| CB_K8S_060 | Resource | ReplicaSet | Verify that the --kubelet-certificate-authority argument is set as it should be | checker/kubernetes/rules/verify_the_kubelet_certificate_authority_is_set.rego |
| CB_K8S_060 | Resource | ReplicationController | Verify that the --kubelet-certificate-authority argument is set as it should be | checker/kubernetes/rules/verify_the_kubelet_certificate_authority_is_set.rego |
| CB_K8S_060 | Resource | StatefulSet | Verify that the --kubelet-certificate-authority argument is set as it should be | checker/kubernetes/rules/verify_the_kubelet_certificate_authority_is_set.rego | 
| CB_K8S_061 | Resource | CronJob | Verify that the --authorization-mode argument is not set to AlwaysAllow | checker/kubernetes/rules/verify_authorization_mode_is_not_always_allow.rego |
| CB_K8S_061 | Resource | DaemonSet | Verify that the --authorization-mode argument is not set to AlwaysAllow | checker/kubernetes/rules/verify_authorization_mode_is_not_always_allow.rego |
| CB_K8S_061 | Resource | Deployment | Verify that the --authorization-mode argument is not set to AlwaysAllow | checker/kubernetes/rules/verify_authorization_mode_is_not_always_allow.rego |
| CB_K8S_061 | Resource | Job | Verify that the --authorization-mode argument is not set to AlwaysAllow | checker/kubernetes/rules/verify_authorization_mode_is_not_always_allow.rego |
| CB_K8S_061 | Resource | Pod | Verify that the --authorization-mode argument is not set to AlwaysAllow | checker/kubernetes/rules/verify_authorization_mode_is_not_always_allow.rego |
| CB_K8S_061 | Resource | ReplicaSet | Verify that the --authorization-mode argument is not set to AlwaysAllow | checker/kubernetes/rules/verify_authorization_mode_is_not_always_allow.rego |
| CB_K8S_061 | Resource | ReplicationController | Verify that the --authorization-mode argument is not set to AlwaysAllow | checker/kubernetes/rules/verify_authorization_mode_is_not_always_allow.rego |
| CB_K8S_061 | Resource | StatefulSet | Verify that the --authorization-mode argument is not set to AlwaysAllow | checker/kubernetes/rules/verify_authorization_mode_is_not_always_allow.rego | 
| CB_K8S_062 | Resource | CronJob | Verify that the --authorization-mode argument contains Node | checker/kubernetes/rules/verify_authorization_mode_contain_node.rego |
| CB_K8S_062 | Resource | DaemonSet | Verify that the --authorization-mode argument contains Node | checker/kubernetes/rules/verify_authorization_mode_contain_node.rego |
| CB_K8S_062 | Resource | Deployment | Verify that the --authorization-mode argument contains Node | checker/kubernetes/rules/verify_authorization_mode_contain_node.rego |
| CB_K8S_062 | Resource | Job | Verify that the --authorization-mode argument contains Node | checker/kubernetes/rules/verify_authorization_mode_contain_node.rego |
| CB_K8S_062 | Resource | Pod | Verify that the --authorization-mode argument contains Node | checker/kubernetes/rules/verify_authorization_mode_contain_node.rego |
| CB_K8S_062 | Resource | ReplicaSet | Verify that the --authorization-mode argument contains Node | checker/kubernetes/rules/verify_authorization_mode_contain_node.rego |
| CB_K8S_062 | Resource | ReplicationController | Verify that the --authorization-mode argument contains Node | checker/kubernetes/rules/verify_authorization_mode_contain_node.rego |
| CB_K8S_062 | Resource | StatefulSet | Verify that the --authorization-mode argument contains Node | checker/kubernetes/rules/verify_authorization_mode_contain_node.rego | 
| CB_K8S_063 | Resource | CronJob | Verify that the --authorization-mode argument contains RBAC | checker/kubernetes/rules/verify_authorization_mode_contain_rbac.rego |
| CB_K8S_063 | Resource | DaemonSet | Verify that the --authorization-mode argument contains RBAC | checker/kubernetes/rules/verify_authorization_mode_contain_rbac.rego |
| CB_K8S_063 | Resource | Deployment | Verify that the --authorization-mode argument contains RBAC | checker/kubernetes/rules/verify_authorization_mode_contain_rbac.rego |
| CB_K8S_063 | Resource | Job | Verify that the --authorization-mode argument contains RBAC | checker/kubernetes/rules/verify_authorization_mode_contain_rbac.rego |
| CB_K8S_063 | Resource | Pod | Verify that the --authorization-mode argument contains RBAC | checker/kubernetes/rules/verify_authorization_mode_contain_rbac.rego |
| CB_K8S_063 | Resource | ReplicaSet | Verify that the --authorization-mode argument contains RBAC | checker/kubernetes/rules/verify_authorization_mode_contain_rbac.rego |
| CB_K8S_063 | Resource | ReplicationController | Verify that the --authorization-mode argument contains RBAC | checker/kubernetes/rules/verify_authorization_mode_contain_rbac.rego |
| CB_K8S_063 | Resource | StatefulSet | Verify that the --authorization-mode argument contains RBAC | checker/kubernetes/rules/verify_authorization_mode_contain_rbac.rego | 
| CB_K8S_064 | Resource | CronJob | Verify that the admission control plugin AlwaysAdmit is not set | checker/kubernetes/rules/verify_admission_control_plugin_not_always_admit.rego |
| CB_K8S_064 | Resource | DaemonSet | Verify that the admission control plugin AlwaysAdmit is not set | checker/kubernetes/rules/verify_admission_control_plugin_not_always_admit.rego |
| CB_K8S_064 | Resource | Deployment | Verify that the admission control plugin AlwaysAdmit is not set | checker/kubernetes/rules/verify_admission_control_plugin_not_always_admit.rego |
| CB_K8S_064 | Resource | Job | Verify that the admission control plugin AlwaysAdmit is not set | checker/kubernetes/rules/verify_admission_control_plugin_not_always_admit.rego |
| CB_K8S_064 | Resource | Pod | Verify that the admission control plugin AlwaysAdmit is not set | checker/kubernetes/rules/verify_admission_control_plugin_not_always_admit.rego |
| CB_K8S_064 | Resource | ReplicaSet | Verify that the admission control plugin AlwaysAdmit is not set | checker/kubernetes/rules/verify_admission_control_plugin_not_always_admit.rego |
| CB_K8S_064 | Resource | ReplicationController | Verify that the admission control plugin AlwaysAdmit is not set | checker/kubernetes/rules/verify_admission_control_plugin_not_always_admit.rego |
| CB_K8S_064 | Resource | StatefulSet | Verify that the admission control plugin AlwaysAdmit is not set | checker/kubernetes/rules/verify_admission_control_plugin_not_always_admit.rego | 
| CB_K8S_065 | Resource | CronJob | Verify that the admission control plugin AlwaysPullImages is set | checker/kubernetes/rules/verify_admission_control_plugin_always_pull_images.rego |
| CB_K8S_065 | Resource | DaemonSet | Verify that the admission control plugin AlwaysPullImages is set | checker/kubernetes/rules/verify_admission_control_plugin_always_pull_images.rego |
| CB_K8S_065 | Resource | Deployment | Verify that the admission control plugin AlwaysPullImages is set | checker/kubernetes/rules/verify_admission_control_plugin_always_pull_images.rego |
| CB_K8S_065 | Resource | Job | Verify that the admission control plugin AlwaysPullImages is set | checker/kubernetes/rules/verify_admission_control_plugin_always_pull_images.rego |
| CB_K8S_065 | Resource | Pod | Verify that the admission control plugin AlwaysPullImages is set | checker/kubernetes/rules/verify_admission_control_plugin_always_pull_images.rego |
| CB_K8S_065 | Resource | ReplicaSet | Verify that the admission control plugin AlwaysPullImages is set | checker/kubernetes/rules/verify_admission_control_plugin_always_pull_images.rego |
| CB_K8S_065 | Resource | ReplicationController | Verify that the admission control plugin AlwaysPullImages is set | checker/kubernetes/rules/verify_admission_control_plugin_always_pull_images.rego |
| CB_K8S_065 | Resource | StatefulSet | Verify that the admission control plugin AlwaysPullImages is set | checker/kubernetes/rules/verify_admission_control_plugin_always_pull_images.rego | 
| CB_K8S_066 | Resource | CronJob | Verify that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used | checker/kubernetes/rules/verify_admission_control_plugin_security_context_deny_is_set.rego |
| CB_K8S_066 | Resource | DaemonSet | Verify that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used | checker/kubernetes/rules/verify_admission_control_plugin_security_context_deny_is_set.rego |
| CB_K8S_066 | Resource | Deployment | Verify that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used | checker/kubernetes/rules/verify_admission_control_plugin_security_context_deny_is_set.rego |
| CB_K8S_066 | Resource | Job | Verify that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used | checker/kubernetes/rules/verify_admission_control_plugin_security_context_deny_is_set.rego |
| CB_K8S_066 | Resource | Pod | Verify that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used | checker/kubernetes/rules/verify_admission_control_plugin_security_context_deny_is_set.rego |
| CB_K8S_066 | Resource | ReplicaSet | Verify that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used | checker/kubernetes/rules/verify_admission_control_plugin_security_context_deny_is_set.rego |
| CB_K8S_066 | Resource | ReplicationController | Verify that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used | checker/kubernetes/rules/verify_admission_control_plugin_security_context_deny_is_set.rego |
| CB_K8S_066 | Resource | StatefulSet | Verify that the admission control plugin SecurityContextDeny is set if PodSecurityPolicy is not used | checker/kubernetes/rules/verify_admission_control_plugin_security_context_deny_is_set.rego | 
| CB_K8S_067 | Resource | CronJob | Verify that the admission control plugin ServiceAccount is set | checker/kubernetes/rules/verify_admission_control_plugin_service_account.rego|
| CB_K8S_067 | Resource | DaemonSet | Verify that the admission control plugin ServiceAccount is set | checker/kubernetes/rules/verify_admission_control_plugin_service_account.rego|
| CB_K8S_067 | Resource | Deployment | Verify that the admission control plugin ServiceAccount is set | checker/kubernetes/rules/verify_admission_control_plugin_service_account.rego|
| CB_K8S_067 | Resource | Job | Verify that the admission control plugin ServiceAccount is set | checker/kubernetes/rules/verify_admission_control_plugin_service_account.rego|
| CB_K8S_067 | Resource | Pod | Verify that the admission control plugin ServiceAccount is set | checker/kubernetes/rules/verify_admission_control_plugin_service_account.rego|
| CB_K8S_067 | Resource | ReplicaSet | Verify that the admission control plugin ServiceAccount is set | checker/kubernetes/rules/verify_admission_control_plugin_service_account.rego|
| CB_K8S_067 | Resource | ReplicationController | Verify that the admission control plugin ServiceAccount is set | checker/kubernetes/rules/verify_admission_control_plugin_service_account.rego|
| CB_K8S_067 | Resource | StatefulSet | Verify that the admission control plugin ServiceAccount is set | checker/kubernetes/rules/verify_admission_control_plugin_service_account.rego| 
| CB_K8S_068 | Resource | PodSecurityPolicy | No root containers are allowed | checker/kubernetes/rules/run_as_root_container.rego| 
| CB_K8S_069 | Resource | CronJob | Verify that the --service-account-private-key-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_private_key.rego |
| CB_K8S_069 | Resource | DaemonSet | Verify that the --service-account-private-key-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_private_key.rego |
| CB_K8S_069 | Resource | Deployment | Verify that the --service-account-private-key-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_private_key.rego |
| CB_K8S_069 | Resource | Job | Verify that the --service-account-private-key-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_private_key.rego |
| CB_K8S_069 | Resource | Pod | Verify that the --service-account-private-key-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_private_key.rego |
| CB_K8S_069 | Resource | ReplicaSet | Verify that the --service-account-private-key-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_private_key.rego |
| CB_K8S_069 | Resource | ReplicationController | Verify that the --service-account-private-key-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_private_key.rego |
| CB_K8S_069 | Resource | StatefulSet | Verify that the --service-account-private-key-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_private_key.rego | 
| CB_K8S_070 | Resource | CronJob | Verify that the --root-ca-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_root_ca.rego |
| CB_K8S_070 | Resource | DaemonSet | Verify that the --root-ca-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_root_ca.rego |
| CB_K8S_070 | Resource | Deployment | Verify that the --root-ca-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_root_ca.rego |
| CB_K8S_070 | Resource | Job | Verify that the --root-ca-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_root_ca.rego |
| CB_K8S_070 | Resource | Pod | Verify that the --root-ca-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_root_ca.rego |
| CB_K8S_070 | Resource | ReplicaSet | Verify that the --root-ca-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_root_ca.rego |
| CB_K8S_070 | Resource | ReplicationController | Verify that the --root-ca-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_root_ca.rego |
| CB_K8S_070 | Resource | StatefulSet | Verify that the --root-ca-file argument is set appropriately | checker/kubernetes/rules/controller_manager_service_account_root_ca.rego | 
| CB_K8S_071 | Resource | CronJob | Verify that the RotateKubeletServerCertificate is set to true | checker/kubernetes/rules/rotate_kubelet_server_cert.rego |
| CB_K8S_071 | Resource | DaemonSet | Verify that the RotateKubeletServerCertificate is set to true | checker/kubernetes/rules/rotate_kubelet_server_cert.rego |
| CB_K8S_071 | Resource | Deployment | Verify that the RotateKubeletServerCertificate is set to true | checker/kubernetes/rules/rotate_kubelet_server_cert.rego |
| CB_K8S_071 | Resource | Job | Verify that the RotateKubeletServerCertificate is set to true | checker/kubernetes/rules/rotate_kubelet_server_cert.rego |
| CB_K8S_071 | Resource | Pod | Verify that the RotateKubeletServerCertificate is set to true | checker/kubernetes/rules/rotate_kubelet_server_cert.rego |
| CB_K8S_071 | Resource | ReplicaSet | Verify that the RotateKubeletServerCertificate is set to true | checker/kubernetes/rules/rotate_kubelet_server_cert.rego |
| CB_K8S_071 | Resource | ReplicationController | Verify that the RotateKubeletServerCertificate is set to true | checker/kubernetes/rules/rotate_kubelet_server_cert.rego |
| CB_K8S_071 | Resource | StatefulSet | Verify that the RotateKubeletServerCertificate is set to true | checker/kubernetes/rules/rotate_kubelet_server_cert.rego | 
| CB_K8S_072 | Resource | CronJob | Verify that the admission control plugin NamespaceLifecycle is set | checker/kubernetes/rules/verify_admission_control_plugin_namespace_lifecycle.rego |
| CB_K8S_072 | Resource | DaemonSet | Verify that the admission control plugin NamespaceLifecycle is set | checker/kubernetes/rules/verify_admission_control_plugin_namespace_lifecycle.rego |
| CB_K8S_072 | Resource | Deployment | Verify that the admission control plugin NamespaceLifecycle is set | checker/kubernetes/rules/verify_admission_control_plugin_namespace_lifecycle.rego |
| CB_K8S_072 | Resource | Job | Verify that the admission control plugin NamespaceLifecycle is set | checker/kubernetes/rules/verify_admission_control_plugin_namespace_lifecycle.rego |
| CB_K8S_072 | Resource | Pod | Verify that the admission control plugin NamespaceLifecycle is set | checker/kubernetes/rules/verify_admission_control_plugin_namespace_lifecycle.rego |
| CB_K8S_072 | Resource | ReplicaSet | Verify that the admission control plugin NamespaceLifecycle is set | checker/kubernetes/rules/verify_admission_control_plugin_namespace_lifecycle.rego |
| CB_K8S_072 | Resource | ReplicationController | Verify that the admission control plugin NamespaceLifecycle is set | checker/kubernetes/rules/verify_admission_control_plugin_namespace_lifecycle.rego |
| CB_K8S_072 | Resource | StatefulSet | Verify that the admission control plugin NamespaceLifecycle is set | checker/kubernetes/rules/verify_admission_control_plugin_namespace_lifecycle.rego | 
| CB_K8S_073 | Resource | CronJob | Verify that the admission control plugin PodSecurityPolicy is set | checker/kubernetes/rules/verify_admission_control_plugin_pod_security_policy.rego |
| CB_K8S_073 | Resource | DaemonSet | Verify that the admission control plugin PodSecurityPolicy is set | checker/kubernetes/rules/verify_admission_control_plugin_pod_security_policy.rego |
| CB_K8S_073 | Resource | Deployment | Verify that the admission control plugin PodSecurityPolicy is set | checker/kubernetes/rules/verify_admission_control_plugin_pod_security_policy.rego |
| CB_K8S_073 | Resource | Job | Verify that the admission control plugin PodSecurityPolicy is set | checker/kubernetes/rules/verify_admission_control_plugin_pod_security_policy.rego |
| CB_K8S_073 | Resource | Pod | Verify that the admission control plugin PodSecurityPolicy is set | checker/kubernetes/rules/verify_admission_control_plugin_pod_security_policy.rego |
| CB_K8S_073 | Resource | ReplicaSet | Verify that the admission control plugin PodSecurityPolicy is set | checker/kubernetes/rules/verify_admission_control_plugin_pod_security_policy.rego |
| CB_K8S_073 | Resource | ReplicationController | Verify that the admission control plugin PodSecurityPolicy is set | checker/kubernetes/rules/verify_admission_control_plugin_pod_security_policy.rego |
| CB_K8S_073 | Resource | StatefulSet | Verify that the admission control plugin PodSecurityPolicy is set | checker/kubernetes/rules/verify_admission_control_plugin_pod_security_policy.rego | 
| CB_K8S_074 | Resource | CronJob | Verify that the admission control plugin NodeRestriction is set | checker/kubernetes/rules/verify_admission_control_plugin_node_restriction.rego |
| CB_K8S_074 | Resource | DaemonSet | Verify that the admission control plugin NodeRestriction is set | checker/kubernetes/rules/verify_admission_control_plugin_node_restriction.rego |
| CB_K8S_074 | Resource | Deployment | Verify that the admission control plugin NodeRestriction is set | checker/kubernetes/rules/verify_admission_control_plugin_node_restriction.rego |
| CB_K8S_074 | Resource | Job | Verify that the admission control plugin NodeRestriction is set | checker/kubernetes/rules/verify_admission_control_plugin_node_restriction.rego |
| CB_K8S_074 | Resource | Pod | Verify that the admission control plugin NodeRestriction is set | checker/kubernetes/rules/verify_admission_control_plugin_node_restriction.rego |
| CB_K8S_074 | Resource | ReplicaSet | Verify that the admission control plugin NodeRestriction is set | checker/kubernetes/rules/verify_admission_control_plugin_node_restriction.rego |
| CB_K8S_074 | Resource | ReplicationController | Verify that the admission control plugin NodeRestriction is set | checker/kubernetes/rules/verify_admission_control_plugin_node_restriction.rego |
| CB_K8S_074 | Resource | StatefulSet | Verify that the admission control plugin NodeRestriction is set | checker/kubernetes/rules/verify_admission_control_plugin_node_restriction.rego | 
| CB_K8S_075 | Resource | CronJob | Verify that the --insecure-bind-address argument is not set | checker/kubernetes/rules/verify_insecure_bind_address_not_set.rego |
| CB_K8S_075 | Resource | DaemonSet | Verify that the --insecure-bind-address argument is not set | checker/kubernetes/rules/verify_insecure_bind_address_not_set.rego |
| CB_K8S_075 | Resource | Deployment | Verify that the --insecure-bind-address argument is not set | checker/kubernetes/rules/verify_insecure_bind_address_not_set.rego |
| CB_K8S_075 | Resource | Job | Verify that the --insecure-bind-address argument is not set | checker/kubernetes/rules/verify_insecure_bind_address_not_set.rego |
| CB_K8S_075 | Resource | Pod | Verify that the --insecure-bind-address argument is not set | checker/kubernetes/rules/verify_insecure_bind_address_not_set.rego |
| CB_K8S_075 | Resource | ReplicaSet | Verify that the --insecure-bind-address argument is not set | checker/kubernetes/rules/verify_insecure_bind_address_not_set.rego |
| CB_K8S_075 | Resource | ReplicationController | Verify that the --insecure-bind-address argument is not set | checker/kubernetes/rules/verify_insecure_bind_address_not_set.rego |
| CB_K8S_075 | Resource | StatefulSet | Verify that the --insecure-bind-address argument is not set | checker/kubernetes/rules/verify_insecure_bind_address_not_set.rego | 
| CB_K8S_076 | Resource | CronJob | Verify that the --insecure-port argument is set to 0 | checker/kubernetes/rules/verify_insecure_is_set_to_zero.rego |
| CB_K8S_076 | Resource | DaemonSet | Verify that the --insecure-port argument is set to 0 | checker/kubernetes/rules/verify_insecure_is_set_to_zero.rego |
| CB_K8S_076 | Resource | Deployment | Verify that the --insecure-port argument is set to 0 | checker/kubernetes/rules/verify_insecure_is_set_to_zero.rego |
| CB_K8S_076 | Resource | Job | Verify that the --insecure-port argument is set to 0 | checker/kubernetes/rules/verify_insecure_is_set_to_zero.rego |
| CB_K8S_076 | Resource | Pod | Verify that the --insecure-port argument is set to 0 | checker/kubernetes/rules/verify_insecure_is_set_to_zero.rego |
| CB_K8S_076 | Resource | ReplicaSet | Verify that the --insecure-port argument is set to 0 | checker/kubernetes/rules/verify_insecure_is_set_to_zero.rego |
| CB_K8S_076 | Resource | ReplicationController | Verify that the --insecure-port argument is set to 0 | checker/kubernetes/rules/verify_insecure_is_set_to_zero.rego |
| CB_K8S_076 | Resource | StatefulSet | Verify that the --insecure-port argument is set to 0 | checker/kubernetes/rules/verify_insecure_is_set_to_zero.rego | 
| CB_K8S_077 | Resource | CronJob | Verify that the --secure-port argument is not set to 0 | checker/kubernetes/rules/verify_secure_port_not_set_to_zero.rego |
| CB_K8S_077 | Resource | DaemonSet | Verify that the --secure-port argument is not set to 0 | checker/kubernetes/rules/verify_secure_port_not_set_to_zero.rego |
| CB_K8S_077 | Resource | Deployment | Verify that the --secure-port argument is not set to 0 | checker/kubernetes/rules/verify_secure_port_not_set_to_zero.rego |
| CB_K8S_077 | Resource | Job | Verify that the --secure-port argument is not set to 0 | checker/kubernetes/rules/verify_secure_port_not_set_to_zero.rego |
| CB_K8S_077 | Resource | Pod | Verify that the --secure-port argument is not set to 0 | checker/kubernetes/rules/verify_secure_port_not_set_to_zero.rego |
| CB_K8S_077 | Resource | ReplicaSet | Verify that the --secure-port argument is not set to 0 | checker/kubernetes/rules/verify_secure_port_not_set_to_zero.rego |
| CB_K8S_077 | Resource | ReplicationController | Verify that the --secure-port argument is not set to 0 | checker/kubernetes/rules/verify_secure_port_not_set_to_zero.rego |
| CB_K8S_077 | Resource | StatefulSet | Verify that the --secure-port argument is not set to 0 | checker/kubernetes/rules/verify_secure_port_not_set_to_zero.rego | 
| CB_K8S_078 | Resource | CronJob | Verify that the --profiling argument is set to false | checker/kubernetes/rules/verify_profiling_set_to_false.rego |
| CB_K8S_078 | Resource | DaemonSet | Verify that the --profiling argument is set to false | checker/kubernetes/rules/verify_profiling_set_to_false.rego |
| CB_K8S_078 | Resource | Deployment | Verify that the --profiling argument is set to false | checker/kubernetes/rules/verify_profiling_set_to_false.rego |
| CB_K8S_078 | Resource | Job | Verify that the --profiling argument is set to false | checker/kubernetes/rules/verify_profiling_set_to_false.rego |
| CB_K8S_078 | Resource | Pod | Verify that the --profiling argument is set to false | checker/kubernetes/rules/verify_profiling_set_to_false.rego |
| CB_K8S_078 | Resource | ReplicaSet | Verify that the --profiling argument is set to false | checker/kubernetes/rules/verify_profiling_set_to_false.rego |
| CB_K8S_078 | Resource | ReplicationController | Verify that the --profiling argument is set to false | checker/kubernetes/rules/verify_profiling_set_to_false.rego |
| CB_K8S_078 | Resource | StatefulSet | Verify that the --profiling argument is set to false | checker/kubernetes/rules/verify_profiling_set_to_false.rego | 
| CB_K8S_079 | Resource | CronJob | There is no —audit-log-path parameter specified | checker/kubernetes/rules/audit_log_path_set.rego |
| CB_K8S_079 | Resource | DaemonSet | There is no —audit-log-path parameter specified | checker/kubernetes/rules/audit_log_path_set.rego |
| CB_K8S_079 | Resource | Deployment | There is no —audit-log-path parameter specified | checker/kubernetes/rules/audit_log_path_set.rego |
| CB_K8S_079 | Resource | Job | There is no —audit-log-path parameter specified | checker/kubernetes/rules/audit_log_path_set.rego |
| CB_K8S_079 | Resource | Pod | There is no —audit-log-path parameter specified | checker/kubernetes/rules/audit_log_path_set.rego |
| CB_K8S_079 | Resource | ReplicaSet | There is no —audit-log-path parameter specified | checker/kubernetes/rules/audit_log_path_set.rego |
| CB_K8S_079 | Resource | ReplicationController | There is no —audit-log-path parameter specified | checker/kubernetes/rules/audit_log_path_set.rego |
| CB_K8S_079 | Resource | StatefulSet | There is no —audit-log-path parameter specified | checker/kubernetes/rules/audit_log_path_set.rego | 
| CB_K8S_080 | Resource | CronJob | Ensure that the --service-account-lookup argument is set to true | checker/kubernetes/rules/verify_service_account_lookup_is_true.rego |
| CB_K8S_080 | Resource | DaemonSet | Ensure that the --service-account-lookup argument is set to true | checker/kubernetes/rules/verify_service_account_lookup_is_true.rego |
| CB_K8S_080 | Resource | Deployment | Ensure that the --service-account-lookup argument is set to true | checker/kubernetes/rules/verify_service_account_lookup_is_true.rego |
| CB_K8S_080 | Resource | Job | Ensure that the --service-account-lookup argument is set to true | checker/kubernetes/rules/verify_service_account_lookup_is_true.rego |
| CB_K8S_080 | Resource | Pod | Ensure that the --service-account-lookup argument is set to true | checker/kubernetes/rules/verify_service_account_lookup_is_true.rego |
| CB_K8S_080 | Resource | ReplicaSet | Ensure that the --service-account-lookup argument is set to true | checker/kubernetes/rules/verify_service_account_lookup_is_true.rego |
| CB_K8S_080 | Resource | ReplicationController | Ensure that the --service-account-lookup argument is set to true | checker/kubernetes/rules/verify_service_account_lookup_is_true.rego |
| CB_K8S_080 | Resource | StatefulSet | Ensure that the --service-account-lookup argument is set to true | checker/kubernetes/rules/verify_service_account_lookup_is_true.rego | 
| CB_K8S_081 | Resource | CronJob | Verify that the --bind-address is set to 127.0.0.1 | checker/kubernetes/rules/controller_manager_bind_adress.rego |
| CB_K8S_081 | Resource | DaemonSet | Verify that the --bind-address is set to 127.0.0.1 | checker/kubernetes/rules/controller_manager_bind_adress.rego |
| CB_K8S_081 | Resource | Deployment | Verify that the --bind-address is set to 127.0.0.1 | checker/kubernetes/rules/controller_manager_bind_adress.rego |
| CB_K8S_081 | Resource | Job | Verify that the --bind-address is set to 127.0.0.1 | checker/kubernetes/rules/controller_manager_bind_adress.rego |
| CB_K8S_081 | Resource | Pod | Verify that the --bind-address is set to 127.0.0.1 | checker/kubernetes/rules/controller_manager_bind_adress.rego |
| CB_K8S_081 | Resource | ReplicaSet | Verify that the --bind-address is set to 127.0.0.1 | checker/kubernetes/rules/controller_manager_bind_adress.rego |
| CB_K8S_081 | Resource | ReplicationController | Verify that the --bind-address is set to 127.0.0.1 | checker/kubernetes/rules/controller_manager_bind_adress.rego |
| CB_K8S_081 | Resource | StatefulSet | Verify that the --bind-address is set to 127.0.0.1 | checker/kubernetes/rules/controller_manager_bind_adress.rego | 
| CB_K8S_082 | Resource | CronJob |Verify that the --cert-file and --key-file arguments are set properly | checker/kubernetes/rules/cert_and_key_file.rego |
| CB_K8S_082 | Resource | DaemonSet |Verify that the --cert-file and --key-file arguments are set properly | checker/kubernetes/rules/cert_and_key_file.rego |
| CB_K8S_082 | Resource | Deployment |Verify that the --cert-file and --key-file arguments are set properly | checker/kubernetes/rules/cert_and_key_file.rego |
| CB_K8S_082 | Resource | Job |Verify that the --cert-file and --key-file arguments are set properly | checker/kubernetes/rules/cert_and_key_file.rego |
| CB_K8S_082 | Resource | Pod |Verify that the --cert-file and --key-file arguments are set properly | checker/kubernetes/rules/cert_and_key_file.rego |
| CB_K8S_082 | Resource | ReplicaSet |Verify that the --cert-file and --key-file arguments are set properly | checker/kubernetes/rules/cert_and_key_file.rego |
| CB_K8S_082 | Resource | ReplicationController |Verify that the --cert-file and --key-file arguments are set properly | checker/kubernetes/rules/cert_and_key_file.rego |
| CB_K8S_082 | Resource | StatefulSet |Verify that the --cert-file and --key-file arguments are set properly | checker/kubernetes/rules/cert_and_key_file.rego | 
| CB_K8S_083 | Resource | CronJob | Verify that the --client-cert-auth arguments is set properly | checker/kubernetes/rules/client_cert_auth.rego |
| CB_K8S_083 | Resource | DaemonSet | Verify that the --client-cert-auth arguments is set properly | checker/kubernetes/rules/client_cert_auth.rego |
| CB_K8S_083 | Resource | Deployment | Verify that the --client-cert-auth arguments is set properly | checker/kubernetes/rules/client_cert_auth.rego |
| CB_K8S_083 | Resource | Job | Verify that the --client-cert-auth arguments is set properly | checker/kubernetes/rules/client_cert_auth.rego |
| CB_K8S_083 | Resource | Pod | Verify that the --client-cert-auth arguments is set properly | checker/kubernetes/rules/client_cert_auth.rego |
| CB_K8S_083 | Resource | ReplicaSet | Verify that the --client-cert-auth arguments is set properly | checker/kubernetes/rules/client_cert_auth.rego |
| CB_K8S_083 | Resource | ReplicationController | Verify that the --client-cert-auth arguments is set properly | checker/kubernetes/rules/client_cert_auth.rego |
| CB_K8S_083 | Resource | StatefulSet | Verify that the --client-cert-auth arguments is set properly | checker/kubernetes/rules/client_cert_auth.rego | 
| CB_K8S_084 | Resource | CronJob | Verify that the --service-account-key-file argument is set | checker/kubernetes/rules/verify_service_account_key_file.rego |
| CB_K8S_084 | Resource | DaemonSet | Verify that the --service-account-key-file argument is set | checker/kubernetes/rules/verify_service_account_key_file.rego |
| CB_K8S_084 | Resource | Deployment | Verify that the --service-account-key-file argument is set | checker/kubernetes/rules/verify_service_account_key_file.rego |
| CB_K8S_084 | Resource | Job | Verify that the --service-account-key-file argument is set | checker/kubernetes/rules/verify_service_account_key_file.rego |
| CB_K8S_084 | Resource | Pod | Verify that the --service-account-key-file argument is set | checker/kubernetes/rules/verify_service_account_key_file.rego |
| CB_K8S_084 | Resource | ReplicaSet | Verify that the --service-account-key-file argument is set | checker/kubernetes/rules/verify_service_account_key_file.rego |
| CB_K8S_084 | Resource | ReplicationController | Verify that the --service-account-key-file argument is set | checker/kubernetes/rules/verify_service_account_key_file.rego |
| CB_K8S_084 | Resource | StatefulSet | Verify that the --service-account-key-file argument is set | checker/kubernetes/rules/verify_service_account_key_file.rego | 
| CB_K8S_085 | Resource | CronJob | Verify that the --auto-tls arguments is set properly| checker/kubernetes/rules/auto_tls.rego |
| CB_K8S_085 | Resource | DaemonSet | Verify that the --auto-tls arguments is set properly| checker/kubernetes/rules/auto_tls.rego |
| CB_K8S_085 | Resource | Deployment | Verify that the --auto-tls arguments is set properly| checker/kubernetes/rules/auto_tls.rego |
| CB_K8S_085 | Resource | Job | Verify that the --auto-tls arguments is set properly| checker/kubernetes/rules/auto_tls.rego |
| CB_K8S_085 | Resource | Pod | Verify that the --auto-tls arguments is set properly| checker/kubernetes/rules/auto_tls.rego |
| CB_K8S_085 | Resource | ReplicaSet | Verify that the --auto-tls arguments is set properly| checker/kubernetes/rules/auto_tls.rego |
| CB_K8S_085 | Resource | ReplicationController | Verify that the --auto-tls arguments is set properly| checker/kubernetes/rules/auto_tls.rego |
| CB_K8S_085 | Resource | StatefulSet | Verify that the --auto-tls arguments is set properly| checker/kubernetes/rules/auto_tls.rego | 
| CB_K8S_086 | Resource | CronJob | Verify that the --peer-cert-file and --key-file arguments are set properly | checker/kubernetes/rules/peer_cert_and_key_file.rego |
| CB_K8S_086 | Resource | DaemonSet | Verify that the --peer-cert-file and --key-file arguments are set properly | checker/kubernetes/rules/peer_cert_and_key_file.rego |
| CB_K8S_086 | Resource | Deployment | Verify that the --peer-cert-file and --key-file arguments are set properly | checker/kubernetes/rules/peer_cert_and_key_file.rego |
| CB_K8S_086 | Resource | Job | Verify that the --peer-cert-file and --key-file arguments are set properly | checker/kubernetes/rules/peer_cert_and_key_file.rego |
| CB_K8S_086 | Resource | Pod | Verify that the --peer-cert-file and --key-file arguments are set properly | checker/kubernetes/rules/peer_cert_and_key_file.rego |
| CB_K8S_086 | Resource | ReplicaSet | Verify that the --peer-cert-file and --key-file arguments are set properly | checker/kubernetes/rules/peer_cert_and_key_file.rego |
| CB_K8S_086 | Resource | ReplicationController | Verify that the --peer-cert-file and --key-file arguments are set properly | checker/kubernetes/rules/peer_cert_and_key_file.rego |
| CB_K8S_086 | Resource | StatefulSet | Verify that the --peer-cert-file and --key-file arguments are set properly | checker/kubernetes/rules/peer_cert_and_key_file.rego | 
| CB_K8S_087 | Resource | CronJob | Verify that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate | checker/kubernetes/rules/verify_etcd_certfile_and_etcd_keyfile_are_set.rego|
| CB_K8S_087 | Resource | DaemonSet | Verify that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate | checker/kubernetes/rules/verify_etcd_certfile_and_etcd_keyfile_are_set.rego|
| CB_K8S_087 | Resource | Deployment | Verify that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate | checker/kubernetes/rules/verify_etcd_certfile_and_etcd_keyfile_are_set.rego|
| CB_K8S_087 | Resource | Job | Verify that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate | checker/kubernetes/rules/verify_etcd_certfile_and_etcd_keyfile_are_set.rego|
| CB_K8S_087 | Resource | Pod | Verify that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate | checker/kubernetes/rules/verify_etcd_certfile_and_etcd_keyfile_are_set.rego|
| CB_K8S_087 | Resource | ReplicaSet | Verify that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate | checker/kubernetes/rules/verify_etcd_certfile_and_etcd_keyfile_are_set.rego|
| CB_K8S_087 | Resource | ReplicationController | Verify that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate | checker/kubernetes/rules/verify_etcd_certfile_and_etcd_keyfile_are_set.rego|
| CB_K8S_087 | Resource | StatefulSet | Verify that the --etcd-certfile and --etcd-keyfile arguments are set as appropriate | checker/kubernetes/rules/verify_etcd_certfile_and_etcd_keyfile_are_set.rego| 
| CB_K8S_088 | Resource | CronJob | Ensure that the --audit-log-maxage argument is set to 30 or as appropriate| checker/kubernetes/rules/audit_log_set_maxage.rego |
| CB_K8S_088 | Resource | DaemonSet | Ensure that the --audit-log-maxage argument is set to 30 or as appropriate| checker/kubernetes/rules/audit_log_set_maxage.rego |
| CB_K8S_088 | Resource | Deployment | Ensure that the --audit-log-maxage argument is set to 30 or as appropriate| checker/kubernetes/rules/audit_log_set_maxage.rego |
| CB_K8S_088 | Resource | Job | Ensure that the --audit-log-maxage argument is set to 30 or as appropriate| checker/kubernetes/rules/audit_log_set_maxage.rego |
| CB_K8S_088 | Resource | Pod | Ensure that the --audit-log-maxage argument is set to 30 or as appropriate| checker/kubernetes/rules/audit_log_set_maxage.rego |
| CB_K8S_088 | Resource | ReplicaSet | Ensure that the --audit-log-maxage argument is set to 30 or as appropriate| checker/kubernetes/rules/audit_log_set_maxage.rego |
| CB_K8S_088 | Resource | ReplicationController | Ensure that the --audit-log-maxage argument is set to 30 or as appropriate| checker/kubernetes/rules/audit_log_set_maxage.rego |
| CB_K8S_088 | Resource | StatefulSet | Ensure that the --audit-log-maxage argument is set to 30 or as appropriate| checker/kubernetes/rules/audit_log_set_maxage.rego | 
| CB_K8S_089 | Resource | CronJob | The --audit-log-maxbackup parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxbackup.rego |
| CB_K8S_089 | Resource | DaemonSet | The --audit-log-maxbackup parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxbackup.rego |
| CB_K8S_089 | Resource | Deployment | The --audit-log-maxbackup parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxbackup.rego |
| CB_K8S_089 | Resource | Job | The --audit-log-maxbackup parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxbackup.rego |
| CB_K8S_089 | Resource | Pod | The --audit-log-maxbackup parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxbackup.rego |
| CB_K8S_089 | Resource | ReplicaSet | The --audit-log-maxbackup parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxbackup.rego |
| CB_K8S_089 | Resource | ReplicationController | The --audit-log-maxbackup parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxbackup.rego |
| CB_K8S_089 | Resource | StatefulSet | The --audit-log-maxbackup parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxbackup.rego | 
| CB_K8S_090 | Resource | CronJob | The -—audit-log-maxsize parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxsize.rego |
| CB_K8S_090 | Resource | DaemonSet | The -—audit-log-maxsize parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxsize.rego |
| CB_K8S_090 | Resource | Deployment | The -—audit-log-maxsize parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxsize.rego |
| CB_K8S_090 | Resource | Job | The -—audit-log-maxsize parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxsize.rego |
| CB_K8S_090 | Resource | Pod | The -—audit-log-maxsize parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxsize.rego |
| CB_K8S_090 | Resource | ReplicaSet | The -—audit-log-maxsize parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxsize.rego |
| CB_K8S_090 | Resource | ReplicationController | The -—audit-log-maxsize parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxsize.rego |
| CB_K8S_090 | Resource | StatefulSet | The -—audit-log-maxsize parameter is not configured correctly | checker/kubernetes/rules/audit_log_set_maxsize.rego | 
| CB_K8S_091 | Resource | Pod | Verify that the --peer-client-cert-auth arguments is set properly | checker/kubernetes/rules/peer_client_cert_auth.rego | 
| CB_K8S_092 | Resource | CronJob | Verify that the --client-ca-file arguments is set properly | checker/kubernetes/rules/client_ca_file.rego |
| CB_K8S_092 | Resource | DaemonSet | Verify that the --client-ca-file arguments is set properly | checker/kubernetes/rules/client_ca_file.rego |
| CB_K8S_092 | Resource | Deployment | Verify that the --client-ca-file arguments is set properly | checker/kubernetes/rules/client_ca_file.rego |
| CB_K8S_092 | Resource | Job | Verify that the --client-ca-file arguments is set properly | checker/kubernetes/rules/client_ca_file.rego |
| CB_K8S_092 | Resource | Pod | Verify that the --client-ca-file arguments is set properly | checker/kubernetes/rules/client_ca_file.rego |
| CB_K8S_092 | Resource | ReplicaSet | Verify that the --client-ca-file arguments is set properly | checker/kubernetes/rules/client_ca_file.rego |
| CB_K8S_092 | Resource | ReplicationController | Verify that the --client-ca-file arguments is set properly | checker/kubernetes/rules/client_ca_file.rego |
| CB_K8S_092 | Resource | StatefulSet | Verify that the --client-ca-file arguments is set properly | checker/kubernetes/rules/client_ca_file.rego | 
| CB_K8S_093 | Resource | CronJob | Verify that the --etcd-cafile arguments is set properly |checker/kubernetes/rules/etcd_ca_file.rego |
| CB_K8S_093 | Resource | DaemonSet | Verify that the --etcd-cafile arguments is set properly |checker/kubernetes/rules/etcd_ca_file.rego |
| CB_K8S_093 | Resource | Deployment | Verify that the --etcd-cafile arguments is set properly |checker/kubernetes/rules/etcd_ca_file.rego |
| CB_K8S_093 | Resource | Job | Verify that the --etcd-cafile arguments is set properly |checker/kubernetes/rules/etcd_ca_file.rego |
| CB_K8S_093 | Resource | Pod | Verify that the --etcd-cafile arguments is set properly |checker/kubernetes/rules/etcd_ca_file.rego |
| CB_K8S_093 | Resource | ReplicaSet | Verify that the --etcd-cafile arguments is set properly |checker/kubernetes/rules/etcd_ca_file.rego |
| CB_K8S_093 | Resource | ReplicationController | Verify that the --etcd-cafile arguments is set properly |checker/kubernetes/rules/etcd_ca_file.rego |
| CB_K8S_093 | Resource | StatefulSet | Verify that the --etcd-cafile arguments is set properly |checker/kubernetes/rules/etcd_ca_file.rego | 
| CB_K8S_094 | Resource | CronJob | Verify that the --encryption-provider-config arguments is set properly | checker/kubernetes/rules/encryption_provider_config.rego |
| CB_K8S_094 | Resource | DaemonSet | Verify that the --encryption-provider-config arguments is set properly | checker/kubernetes/rules/encryption_provider_config.rego |
| CB_K8S_094 | Resource | Deployment | Verify that the --encryption-provider-config arguments is set properly | checker/kubernetes/rules/encryption_provider_config.rego |
| CB_K8S_094 | Resource | Job | Verify that the --encryption-provider-config arguments is set properly | checker/kubernetes/rules/encryption_provider_config.rego |
| CB_K8S_094 | Resource | Pod | Verify that the --encryption-provider-config arguments is set properly | checker/kubernetes/rules/encryption_provider_config.rego |
| CB_K8S_094 | Resource | ReplicaSet | Verify that the --encryption-provider-config arguments is set properly | checker/kubernetes/rules/encryption_provider_config.rego |
| CB_K8S_094 | Resource | ReplicationController | Verify that the --encryption-provider-config arguments is set properly | checker/kubernetes/rules/encryption_provider_config.rego |
| CB_K8S_094 | Resource | StatefulSet | Verify that the --encryption-provider-config arguments is set properly | checker/kubernetes/rules/encryption_provider_config.rego | 
| CB_K8S_095 | Resource | CronJob | Verify that the API Server only use Strong Cryptographic Ciphers | checker/kubernetes/rules/apiserver_cryptographic_ciphers.rego |
| CB_K8S_095 | Resource | DaemonSet | Verify that the API Server only use Strong Cryptographic Ciphers | checker/kubernetes/rules/apiserver_cryptographic_ciphers.rego |
| CB_K8S_095 | Resource | Deployment | Verify that the API Server only use Strong Cryptographic Ciphers | checker/kubernetes/rules/apiserver_cryptographic_ciphers.rego |
| CB_K8S_095 | Resource | Job | Verify that the API Server only use Strong Cryptographic Ciphers | checker/kubernetes/rules/apiserver_cryptographic_ciphers.rego |
| CB_K8S_095 | Resource | Pod | Verify that the API Server only use Strong Cryptographic Ciphers | checker/kubernetes/rules/apiserver_cryptographic_ciphers.rego |
| CB_K8S_095 | Resource | ReplicaSet | Verify that the API Server only use Strong Cryptographic Ciphers | checker/kubernetes/rules/apiserver_cryptographic_ciphers.rego |
| CB_K8S_095 | Resource | ReplicationController | Verify that the API Server only use Strong Cryptographic Ciphers | checker/kubernetes/rules/apiserver_cryptographic_ciphers.rego |
| CB_K8S_095 | Resource | StatefulSet | Verify that the API Server only use Strong Cryptographic Ciphers | checker/kubernetes/rules/apiserver_cryptographic_ciphers.rego |
| CB_K8S_096 | Resource | CronJob | Verify that the --terminated-pod-gc-threshold is set appropriately | checker/kubernetes/rules/terminated_pod_gc_threshold.rego |
| CB_K8S_096 | Resource | DaemonSet | Verify that the --terminated-pod-gc-threshold is set appropriately | checker/kubernetes/rules/terminated_pod_gc_threshold.rego |
| CB_K8S_096 | Resource | Deployment | Verify that the --terminated-pod-gc-threshold is set appropriately | checker/kubernetes/rules/terminated_pod_gc_threshold.rego |
| CB_K8S_096 | Resource | Job | Verify that the --terminated-pod-gc-threshold is set appropriately | checker/kubernetes/rules/terminated_pod_gc_threshold.rego |
| CB_K8S_096 | Resource | Pod | Verify that the --terminated-pod-gc-threshold is set appropriately | checker/kubernetes/rules/terminated_pod_gc_threshold.rego |
| CB_K8S_096 | Resource | ReplicaSet | Verify that the --terminated-pod-gc-threshold is set appropriately | checker/kubernetes/rules/terminated_pod_gc_threshold.rego |
| CB_K8S_096 | Resource | ReplicationController | Verify that the --terminated-pod-gc-threshold is set appropriately | checker/kubernetes/rules/terminated_pod_gc_threshold.rego |
| CB_K8S_096 | Resource | StatefulSet | Verify that the --terminated-pod-gc-threshold is set appropriately | checker/kubernetes/rules/terminated_pod_gc_threshold.rego | 
| CB_K8S_097 | Resource | DaemonSet | Liveness Probe Should be set up | cchecker/kubernetes/rules/liveness_probe_should_be_set.rego |
| CB_K8S_097 | Resource | Deployment | Liveness Probe Should be set up | cchecker/kubernetes/rules/liveness_probe_should_be_set.rego |
| CB_K8S_097 | Resource | Pod | Liveness Probe Should be set up | cchecker/kubernetes/rules/liveness_probe_should_be_set.rego |
| CB_K8S_097 | Resource | ReplicaSet | Liveness Probe Should be set up | cchecker/kubernetes/rules/liveness_probe_should_be_set.rego |
| CB_K8S_097 | Resource | ReplicationController | Liveness Probe Should be set up | cchecker/kubernetes/rules/liveness_probe_should_be_set.rego |
| CB_K8S_097 | Resource | StatefulSet | Liveness Probe Should be set up | cchecker/kubernetes/rules/liveness_probe_should_be_set.rego |
| CB_K8S_098 | Resource | CronJob | Make sure the —request-timeout option is configured correctly | cchecker/kubernetes/rules/audit_log_request_timeout.rego |
| CB_K8S_098 | Resource | DaemonSet | Make sure the —request-timeout option is configured correctly | cchecker/kubernetes/rules/audit_log_request_timeout.rego |
| CB_K8S_098 | Resource | Deployment | Make sure the —request-timeout option is configured correctly | cchecker/kubernetes/rules/audit_log_request_timeout.rego |
| CB_K8S_098 | Resource | Job | Make sure the —request-timeout option is configured correctly | cchecker/kubernetes/rules/audit_log_request_timeout.rego |
| CB_K8S_098 | Resource | Pod | Make sure the —request-timeout option is configured correctly | cchecker/kubernetes/rules/audit_log_request_timeout.rego |
| CB_K8S_098 | Resource | ReplicaSet | Make sure the —request-timeout option is configured correctly | cchecker/kubernetes/rules/audit_log_request_timeout.rego |
| CB_K8S_098 | Resource | ReplicationController | Make sure the —request-timeout option is configured correctly | cchecker/kubernetes/rules/audit_log_request_timeout.rego |
| CB_K8S_098 | Resource | StatefulSet | Make sure the —request-timeout option is configured correctly | cchecker/kubernetes/rules/audit_log_request_timeout.rego | 
| CB_K8S_099 | Resource | DaemonSet | Readiness Probe Should be set up | checker/kubernetes/rules/readiness_probe_should_be_set.rego |
| CB_K8S_099 | Resource | Deployment | Readiness Probe Should be set up | checker/kubernetes/rules/readiness_probe_should_be_set.rego |
| CB_K8S_099 | Resource | Pod | Readiness Probe Should be set up | checker/kubernetes/rules/readiness_probe_should_be_set.rego |
| CB_K8S_099 | Resource | ReplicaSet | Readiness Probe Should be set up | checker/kubernetes/rules/readiness_probe_should_be_set.rego |
| CB_K8S_099 | Resource | ReplicationController | Readiness Probe Should be set up | checker/kubernetes/rules/readiness_probe_should_be_set.rego |
| CB_K8S_099 | Resource | StatefulSet | Readiness Probe Should be set up | checker/kubernetes/rules/readiness_probe_should_be_set.rego |
| CB_K8S_100 | Resource | PodSecurityPolicy | Do not allow containers that want to distribute the host process ID namespace to be accepted | checker/kubernetes/rules/deny_admission_PID.rego |
| CB_K8S_101 | Resource | PodSecurityPolicy | Privileged containers must not be allowed | checker/kubernetes/rules/deny_privileged_containers.rego |
| CB_K8S_102 | Resource | PodSecurityPolicy | Avoid allowing containers that want to distribute the host's IPC namespace | checker/kubernetes/rules/deny_admission_hostIPC.rego |
| CB_K8S_103 | Resource | PodSecurityPolicy | Avoid allowing containers to distribute the host network namespace | checker/kubernetes/rules/deny_host_network_namespace.rego |
| CB_K8S_104 | Resource | PodSecurityPolicy | Make certain that containers are not running with AllowPrivilegeEscalation | checker/kubernetes/rules/deny_allow_privilege_escalation.rego |
| CB_K8S_105 | Resource | PodSecurityPolicy | Refuse to accept containers with the NET RAW capability | checker/kubernetes/rules/deny_NET_RAW.rego |
| CB_K8S_106 | Resource | PodSecurityPolicy | Make sure that no containers with extra functionality are permitted | checker/kubernetes/rules/deny_added_capability.rego |
| CB_K8S_107 | Resource | PodSecurityPolicy | Make sure that runtime/Default or docker/default is selected in seccomp profile | checker/kubernetes/rules/ensure_seccomp_profile_set.rego |
| CB_K8S_108 | Resource | PodSecurityPolicy | Aim to restrict the number of containers admitted with assigned capabilities | checker/kubernetes/rules/minimize_admission_containers.rego | 
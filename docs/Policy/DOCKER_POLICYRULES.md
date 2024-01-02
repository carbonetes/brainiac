# Docker Policy Index

This document provides a comprehensive index of Docker policies available in BrainIAC.

| ID            | Type     | Entity                     | Policy                                                                               | Resource                                                                                  |
| ---           | ---      | ---                        | ---                                                                                  | ---                                                                                       |
| CB_DKR_001  | docker_instruction | EXPOSE      | Verify port 22 is not exposed                                    | checker/docker/rules/health_check_instruction_added.rego                  |
| CB_DKR_002  | docker_instruction | HEALTHCHECK            | Verify that HEALTHCHECK instructions have been added to container images                             | checker/terraform/rules/oci/verify_oci_block_storage_block_volume_backup.rego          |
| CB_DKR_003  | docker_instruction | USER | Verify that a user for the container has been created                | checker/docker/rules/copy_is_used_instead_of_add.rego                          |
| CB_DKR_004  | docker_instruction | ADD            | Verify that COPY is used instead of ADD in Dockerfiles | checker/docker/rules/copy_is_used_instead_of_add.rego     |
| CB_DKR_005  | docker_instruction | RUN            | Verify update instructions are not use alone in the Dockerfile      | checker/docker/rules/verify_update_instruction_not_use_alone.rego |
| CB_DKR_006  | docker_instruction | MAINTAINER            | Verify that LABEL maintainer is used instead of MAINTAINER             | checker/docker/rules/label_is_used_instead_of_maintainer.rego |
| CB_DKR_007  | docker_instruction | FROM            | Verify the base image uses a non latest version tag                                   | internal/checker/docker/rules/verify_the_base_image_uses_non_latest.rego        |
| CB_DKR_008  | docker_instruction | USER   | Verify the last USER is not root                              | checker/docker/rules/verify_last_user_not_root.rego                   |
| CB_DKR_009  | docker_instruction | RUN   | Verify that APT isn't used                                     | checker/docker/rules/verify_apt_is_not_used.rego                  |
| CB_DKR_010  | docker_instruction | WORKDIR   | Verify that WORKDIR values are absolute paths                   | checker/docker/rules/workdir_values_are_absolute_paths.rego                   |
| CB_DKR_011  | docker_instruction | FROM   | Verify From Alias are unique for multistage builds                                              | checker/docker/rules/alias_are_unique.rego                           |
| CB_DKR_012  | docker_instruction | RUN | Verify that sudo isn't used                      | checker/docker/rules/verify_sudo_is_not_used.rego               |
| CB_DKR_013  | docker_instruction | RUN | Verify that certificate validation isn't disabled with curl                | checker/docker/rules/verify_certificate_validation_disabled_with_curl.rego                 |
| CB_DKR_014  | docker_instruction | RUN | Verify that certificate validation isn't disabled with wget                | checker/docker/rules/certificate_validation_disabled_with_wget.rego       |
| CB_DKR_015  | docker_instruction | RUN | Verify that certificate validation isn't disabled with the pip '--trusted-host' option                | checker/docker/rules/certificate_validation_disabled_with_pip.rego       |
| CB_DKR_016  | docker_instruction | ARG     | Verify that certificate validation isn't disabled with the PYTHONHTTPSVERIFY environmnet variable                                          | checker/docker/rules/certificate_validation_disabled_with_pip_env_var.rego                           |
| CB_DKR_016  | docker_instruction | ENV     | Verify that certificate validation isn't disabled with the PYTHONHTTPSVERIFY environmnet variable                                 | checker/docker/rules/certificate_validation_disabled_with_pip_env_var.rego                  |
| CB_DKR_016  | docker_instruction | RUN | Verify that certificate validation isn't disabled with the PYTHONHTTPSVERIFY environmnet variable | checker/docker/rules/certificate_validation_disabled_with_pip_env_var.rego                      |
| CB_DKR_017  | docker_instruction | ARG     | Verify Ensure that certificate validation isn't disabled with the NODE_TLS_REJECT_UNAUTHORIZED environmnet variable        | checker/docker/rules/certificate_validation_disabled_with_nodetls_env_var.rego             |
| CB_DKR_017  | docker_instruction | ENV     | Verify Ensure that certificate validation isn't disabled with the NODE_TLS_REJECT_UNAUTHORIZED environmnet variable9      | checker/docker/rules/certificate_validation_disabled_with_nodetls_env_var.rego              |
| CB_DKR_017  | docker_instruction | RUN | Verify Ensure that certificate validation isn't disabled with the NODE_TLS_REJECT_UNAUTHORIZED environmnet variable             | checker/docker/rules/certificate_validation_disabled_with_nodetls_env_var.rego |
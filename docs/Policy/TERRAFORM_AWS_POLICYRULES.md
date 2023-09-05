# Terraform AWS Policy Index


This document provides a comprehensive index of Terraform policies available in BrainIAC(Terraform AWS).


| ID | Type | Entity | Policy | Resource |
| --- | --- | --- | --- | --- |
| CB_TFAWS_001 | Data | aws_iam_policy_document | Prevent the creation of IAM policies that grant full administrative privileges using wildcard characters for both the actions and resources. | checker/terraform/rules/aws/iam/prevent_policy_that_allow_wildcard.rego |
| CB_TFAWS_002 | Resource | aws_alb_listener | Verify ALB protocol is HTTPS | checker/terraform/rules/aws/verify_alb_protocol_is_https.rego |
| CB_TFAWS_002 | Resource | aws_lb_listener | Verify ALB protocol is HTTPS | checker/terraform/rules/aws/verify_alb_protocol_is_https.rego |
| CB_TFAWS_003 | Resource | aws_ebs_volume | Ensure all data stored in the EBS is securely encrypted | checker/terraform/rules/aws/enable_ebs_encryption.rego |
| CB_TFAWS_004 | Resource | aws_elasticsearch_domain | Make sure that all data stored in Elasticsearch is encrypted securely while at rest. | checker/terraform/rules/aws/make_sure_elasticsearch_encrypted.rego |
| CB_TFAWS_004 | Resource | aws_opensearch_domain | Make sure that all data stored in Elasticsearch is encrypted securely while at rest. | checker/terraform/rules/aws/make_sure_elasticsearch_encrypted.rego |
| CB_TFAWS_005 | Resource | aws_elasticsearch_domain | Make sure that all data stored in Elasticsearch is encrypted securely while at rest. | checker/terraform/rules/aws/make_sure_elasticsearch_encrypted.rego |
| CB_TFAWS_005 | Resource | aws_opensearch_domain | Ensure all Elasticsearch has node-to-node encryption enabled. | checker/terraform/rules/aws/make_sure_elasticsearch_encrypted.rego |
| CB_TFAWS_006 | Resource | aws_kms_key | Enable key rotation for customer-created Customer Master Keys (CMKs). | checker/terraform/rules/aws/enable_key_rotation_for_CMKs.rego | 
| CB_TFAWS_007 | Resource | aws_instance | Make sure that all data stored in the Elastic Block Store of the instance or the Launch Configuration is encrypted in a secure manner. | checker/terraform/rules/aws/verify_elastic_block_store_encrypted.rego | 
| CB_TFAWS_007 | Resource | aws_launch_configuration | Make sure that all data stored in the Elastic Block Store of the instance or the Launch Configuration is encrypted in a secure manner. | checker/terraform/rules/aws/verify_elastic_block_store_encrypted.rego | 
| CB_TFAWS_008 | Resource | aws_iam_account_password_policy | Make sure that the IAM password policy mandates passwords to expire within 90 days or less. | checker/terraform/rules/aws/iam/iam_password_max_age.rego |
| CB_TFAWS_009 | Resource | aws_iam_account_password_policy | Make sure IAM password policy requires minimum length of 14 or greater. | checker/terraform/rules/aws/iam/iam_password_max_age copy.rego |
| CB_TFAWS_010 | Resource | aws_iam_account_password_policy | Make sure IAM password policy requires at least one lowercase letter | checker/terraform/rules/aws/iam/iam_password_require_lowercase.rego |
| CB_TFAWS_011 | Resource | aws_sns_topic | Enable encryption for SNS topics and uses custom master keys | checker/terraform/rules/aws/enable_sns_encryption.rego |
| CB_TFAWS_012 | Resource | aws_iam_account_password_policy | Make sure IAM password policy requires at least one number | checker/terraform/rules/aws/iam/iam_password_require_numbers.rego |
| CB_TFAWS_013 | Resource | aws_iam_account_password_policy | Make sure IAM password policy prevents password reuse | checker/terraform/rules/aws/iam/iam_password_reuse_prevention.rego |
| CB_TFAWS_014 | Resource | aws_sqs_queue | Enable encryption for SQS queue and uses custom master keys | checker/terraform/rules/aws/enable_sqs_queue_encryption.rego |
| CB_TFAWS_015 | Resource | aws_iam_account_password_policy | Make sure IAM password policy requires at least one symbol | checker/terraform/rules/aws/iam/iam_password_require_symbol.rego |
| CB_TFAWS_016 | Resource | aws_dynamodb_table | Enable point_in_time_recovery for DynamoDB tables | checker/terraform/rules/aws/enable_dynamodb_pitr.rego |  
| CB_TFAWS_017 | Resource | aws_elasticache_replication_group | Enable encryption at rest for ElastiCache Replication Groups | checker/terraform/rules/aws/enable_elasitcache_replication_group_at_rest_encryption.rego |  
| CB_TFAWS_018 | Resource | aws_iam_account_password_policy | Make sure IAM password policy requires at least one uppercase letter | checker/terraform/rules/aws/iam/iam_password_require_uppercase.rego |  
| CB_TFAWS_019 | Resource | aws_db_instance | Verify all data stored in the RDS is securely encrypted at rest | checker/terraform/rules/aws/verify_rds_securely_encrypted.rego |  
| CB_TFAWS_020 | Resource | aws_elasticache_replication_group | Enable Encryption at transit for ElastiCache Replication Groups | checker/terraform/rules/aws/enable_elasticache_replication_group_at_transit_encryption.rego |  
| CB_TFAWS_021 | Resource | aws_db_instance | Verify all data stored in RDS is not publicly accessible | checker/terraform/rules/aws/database/verify_rds_not_publicly_accessible.rego |  
| CB_TFAWS_021 | Resource | aws_rds_cluster_instance | Verify all data stored in RDS is not publicly accessible | checker/terraform/rules/aws/database/verify_rds_not_publicly_accessible.rego |  
| CB_TFAWS_022 | Resource | aws_elasticache_replication_group | Enable Encryption at transit with auth_token for ElastiCache Replication Groups | checker/terraform/rules/aws/enable_elasticache_replication_group_at_transit_encryption_auth.rego | 
| CB_TFAWS_023 | Resource | aws_s3_bucket | Verify the S3 bucket has access logging enabled | checker/terraform/rules/aws/bucket/verify_s3bucket_logging_enabled.rego | 
| CB_TFAWS_024 | Resource | aws_s3_bucket | Verify all data stored in the S3 bucket is securely encrypted at rest | checker/terraform/rules/aws/bucket/verify_s3bucket_encrypted_at_rest.rego |   
| CB_TFAWS_025 | Resource | aws_neptune_cluster | Make sure that the neptune storage is encrypted in a secure manner | checker/terraform/rules/aws/aws_neptune_cluster_encrypted.rego |
| CB_TFAWS_026 | Resource | aws_lambda_function | Ensure that tracing is enabled for AWS Lambda functions | checker/terraform/rules/aws/aws_lambda_function_tracing.rego |
| CB_TFAWS_027 | Resource | aws_kinesis_stream | AWS Kinesis streams must be encrypted | checker/terraform/rules/aws/aws_kinesis_stream_encrypted.rego |
| CB_TFAWS_028 | Resource | aws_efs_file_system | See to it that EFS is safely encrypted | checker/terraform/rules/aws/aws_efs_file_system_encrypted.rego |
| CB_TFAWS_029 | Resource | aws_ecr_repository_policy | Make certain that the ECR policy is not set to public | checker/terraform/rules/aws/aws_ecr_repository_policy_public_not_allowed.rego |
| CB_TFAWS_030 | Resource | aws_kms_key | Verify KMS key policy does not have wildcard principal | checker/terraform/rules/aws/verify_kms_key_wildcard_principal.rego |
| CB_TFAWS_031 | Resource | aws_cloudfront_distribution | Verify that cloudfront distribution ViewerProtocolPolicy is not set to allow-all | checker/terraform/rules/aws/verify_cloudfront_distribution_encryption.rego |
| CB_TFAWS_032 | Resource | aws_cloudtrail | Verify CloudTrail logs are encrypted with a KMS key | checker/terraform/rules/aws/verify_cloudtrail_logs_encryption_at_rest.rego |
| CB_TFAWS_033 | Resource | aws_cloudtrail | Enable CloudTrail log file validation | checker/terraform/rules/aws/enable_cloudtrail_logs_file_validation.rego |
| CB_TFAWS_034 | Resource | aws_eks_cluster | Verify Amazon EKS control plane logging enabled for all log types | checker/terraform/rules/aws/verify_eks_control_plane_logging.rego |
| CB_TFAWS_035 | Resource | aws_eks_cluster | Verify that Amazon EKS cluster endpoint public access is disabled or CIDR blocks are specified ip-ranges | checker/terraform/rules/aws/verify_eks_public_access_cidr.rego |
| CB_TFAWS_036 | Resource | aws_mq_broker | Check to see if MQ Broker logging is activated | checker/terraform/rules/aws/aws_mq_broker_logs.rego |
| CB_TFAWS_037 | Resource | aws_s3_bucket | The S3 Bucket allows public READ access through its ACL | checker/terraform/rules/aws/bucket/s3bucket_acl_is_private.rego |
| CB_TFAWS_037 | Resource | aws_s3_bucket_acl | The S3 Bucket allows public READ access through its ACL | checker/terraform/rules/aws/bucket/s3bucket_acl_is_private.rego |
| CB_TFAWS_038 | Resource | aws_s3_bucket | Make sure that the S3 bucket has versioning enabled for all data stored in it. | checker/terraform/rules/aws/bucket/verify_s3bucket_versioning_enabled.rego |
| CB_TFAWS_038 | Resource | aws_s3_bucket_versioning | Make sure that the S3 bucket has versioning enabled for all data stored in it. | checker/terraform/rules/aws/bucket/verify_s3bucket_versioning_enabled.rego |
| CB_TFAWS_039 | Resource | aws_sagemaker_notebook_instance | Verify SageMaker Notebook is encrypted at rest using KMS CMK | checker/terraform/rules/aws/verify_sagemakernotebook_encrypted_at_rest.rego |
| CB_TFAWS_040 | Resource | aws_lambda_function | Verify the lambda environment for any hard-coded secrets | checker/terraform/rules/aws/aws_lambda_function_secret.rego |
| CB_TFAWS_041 | Resource | aws_dax_cluster | Check to see if DAX is encrypted at rest (the default is unencrypted). | checker/terraform/rules/aws/aws_dax_cluster_encrypted.rego |
| CB_TFAWS_042 | Data | aws_iam_policy_document | Make sure that none of the IAM policies allow a statement's actions to use a wildcard. | checker/terraform/rules/aws/iam/aws_iam_policy_document_wildcard_not_allowed.rego |
| CB_TFAWS_043 | Resource | aws_db_security_group | Verify every security groups rule has a description | checker/terraform/rules/aws/verify_securitygroups_has_description.rego |
| CB_TFAWS_043 | Resource | aws_elasticache_security_group | Verify every security groups rule has a description | checker/terraform/rules/aws/verify_securitygroups_has_description.rego |
| CB_TFAWS_043 | Resource | aws_redshift_security_group | Verify every security groups rule has a description | checker/terraform/rules/aws/verify_securitygroups_has_description.rego |
| CB_TFAWS_043 | Resource | aws_security_group | Verify every security groups rule has a description | checker/terraform/rules/aws/verify_securitygroups_has_description.rego |
| CB_TFAWS_043 | Resource | aws_security_group_rule | Verify every security groups rule has a description | checker/terraform/rules/aws/verify_securitygroups_has_description.rego |
| CB_TFAWS_043 | Resource | aws_vpc_security_group_egress_rule | Verify every security groups rule has a description | checker/terraform/rules/aws/verify_securitygroups_has_description.rego |
| CB_TFAWS_043 | Resource | aws_vpc_security_group_ingress_rule | Verify every security groups rule has a description | checker/terraform/rules/aws/verify_securitygroups_has_description.rego |
| CB_TFAWS_044 | Resource | aws_security_group | Verify no security groups allow ingress from 0.0.0.0:0 to port 22 | checker/terraform/rules/aws/verify_securitygroups_ingress_port_22.rego |
| CB_TFAWS_044 | Resource | aws_security_group_rule | Verify no security groups allow ingress from 0.0.0.0:0 to port 22 | checker/terraform/rules/aws/verify_securitygroups_ingress_port_22.rego |
| CB_TFAWS_044 | Resource | aws_vpc_security_group_egress_rule | Verify no security groups allow ingress from 0.0.0.0:0 to port 22 | checker/terraform/rules/aws/verify_securitygroups_ingress_port_22.rego |
| CB_TFAWS_045 | Resource | aws_eks_cluster | Verify that Amazon EKS cluster endpoint public access is disabled | checker/terraform/rules/aws/verify_eks_endpoint_public_access.rego |
| CB_TFAWS_046 | Resource | aws_security_group | Verify no security groups allow ingress from 0.0.0.0:0 to port 3389 | checker/terraform/rules/aws/verify_securitygroups_ingress_port_3389.rego |
| CB_TFAWS_046 | Resource | aws_security_group_rule | VVerify no security groups allow ingress from 0.0.0.0:0 to port 3389 | checker/terraform/rules/aws/verify_securitygroups_ingress_port_3389.rego |
| CB_TFAWS_046 | Resource | aws_vpc_security_group_egress_rule | Verify no security groups allow ingress from 0.0.0.0:0 to port 3389 | checker/terraform/rules/aws/verify_securitygroups_ingress_port_3389.rego |
| CB_TFAWS_047 | Resource | aws_iam_user_policy_attachment | Verify that  IAM policies are attached only to groups, roles to avoid privilege escalation | checker/terraform/rules/aws/iam/iam_policy_attached_to_group_roles.rego |
| CB_TFAWS_047 | Resource | aws_iam_user_policy | Verify that  IAM policies are attached only to groups, roles to avoid privilege escalation | checker/terraform/rules/aws/iam/iam_policy_attached_to_group_roles.rego |
| CB_TFAWS_047 | Resource | aws_iam_policy_attachment | Verify that  IAM policies are attached only to groups, roles to avoid privilege escalation | checker/terraform/rules/aws/iam/iam_policy_attached_to_group_roles.rego |
| CB_TFAWS_048 | Resource | aws_instance | Verify that EC2 user data doesn't contain any hard-coded secrets | checker/terraform/rules/aws/aws_instance_secrets.rego |
| CB_TFAWS_049 | Resource | aws_ecr_repository | Verify ECR Image Tags are immutable | checker/terraform/rules/aws/verify_ecr_image_tags_immutable.rego |
| CB_TFAWS_050 | Resource | aws_s3_bucket_public_access_block | Verify S3 bucket has block public ACLS enabled | checker/terraform/rules/aws/bucket/s3bucket_block_public_acls_enabled.rego |
| CB_TFAWS_051 | Resource | aws_s3_bucket_public_access_block | Verify S3 bucket has block public policy enabled | checker/terraform/rules/aws/bucket/s3bucket_block_public_policy_enabled.rego |
| CB_TFAWS_052 | Resource | aws_s3_bucket_public_access_block | Verify S3 bucket has ignore public ACLs enabled | checker/terraform/rules/aws/bucket/s3bucket_ignore_public_acls_enabled.rego |
| CB_TFAWS_053 | Resource | aws_s3_bucket_public_access_block | Verify S3 bucket has 'restrict_public_bucket' enabled | checker/terraform/rules/aws/bucket/s3bucket_restrict_public_bucket_enabled.rego |
| CB_TFAWS_054 | Resource | aws | Verify that the provider has no hard-coded AWS access keys or secret keys | checker/terraform/rules/aws/aws_secret_allow_pattern.rego |
| CB_TFAWS_055 | Resource | aws_s3_bucket |S3 Bucket has an ACL defined which allows public WRITE access | checker/terraform/rules/aws/bucket/verify_s3bucket_acl_allows_public_write_access.rego |
| CB_TFAWS_055 | Resource | aws_s3_bucket_acl | S3 Bucket has an ACL defined which allows public WRITE access. | checker/terraform/rules/aws/bucket/verify_s3bucket_acl_allows_public_write_access.rego |
| CB_TFAWS_056 | Resource | aws_eks_cluster | Make sure Secrets Encryption is enabled in the EKS Cluster | checker/terraform/rules/aws/aws_eks_cluster_eks_encrypted.rego |
| CB_TFAWS_057 | Resource | aws_api_gateway_method | Check to make sure that there is no open API access to back-end resources | checker/terraform/rules/aws/aws_api_gateway_method_open_access.rego |
| CB_TFAWS_058 | Resource | aws_iam_role | Verify that the IAM role permits exclusive authorization for designated services or principals to assume its privileges | checker/terraform/rules/aws/iam/aws_iam_role_specific_principals.rego |
| CB_TFAWS_059 | Resource | aws_athena_database | A secure Athena Database should be encrypted at all times (the default is not encrypted). | checker/terraform/rules/aws/aws_athena_database_encrypted.rego |
| CB_TFAWS_060 | Resource | aws_ecs_cluster | Check that the ECS cluster's container insights are enabled | checker/terraform/rules/aws/aws_ecs_cluster_container_insights_enabled.rego |
| CB_TFAWS_061 | Resource | aws_iam_group_policy | Aim to prevent the creation of IAM policies that grant full administrative privileges | checker/terraform/rules/aws/iam/aws_iam_role_policy_privileges_not_allowed.rego |
| CB_TFAWS_061 | Resource | aws_iam_policy | Aim to prevent the creation of IAM policies that grant full administrative privileges | checker/terraform/rules/aws/iam/aws_iam_role_policy_privileges_not_allowed.rego |
| CB_TFAWS_061 | Resource | aws_iam_role_policy | Aim to prevent the creation of IAM policies that grant full administrative privileges | checker/terraform/rules/aws/iam/aws_iam_role_policy_privileges_not_allowed.rego |
| CB_TFAWS_061 | Resource | aws_iam_user_policy | Aim to prevent the creation of IAM policies that grant full administrative privileges | checker/terraform/rules/aws/iam/aws_iam_role_policy_privileges_not_allowed.rego |
| CB_TFAWS_061 | Resource | aws_ssoadmin_permission_set_inline_policy | Aim to prevent the creation of IAM policies that grant full administrative privileges | checker/terraform/rules/aws/iam/aws_iam_role_policy_privileges_not_allowed.rego |
| CB_TFAWS_062 | Resource | aws_redshift_cluster | Guarantee that the data stored within the Redshift cluster is adequately encrypted when it is at rest | checker/terraform/rules/aws/aws_redshift_cluster_encrypted.rego |
| CB_TFAWS_063 | Resource | aws_iam_group_policy | IAM policy documents should disallow the utilization of (*) as the action within any statement | checker/terraform/rules/aws/iam/aws_iam_user_policy_document_no_wildcard.rego |
| CB_TFAWS_063 | Resource | aws_iam_policy | IAM policy documents should disallow the utilization of (*) as the action within any statement | checker/terraform/rules/aws/iam/aws_iam_user_policy_document_no_wildcard.rego |
| CB_TFAWS_063 | Resource | aws_iam_role_policy | IAM policy documents should disallow the utilization of (*) as the action within any statement | checker/terraform/rules/aws/iam/aws_iam_user_policy_document_no_wildcard.rego |
| CB_TFAWS_063 | Resource | aws_iam_user_policy | IAM policy documents should disallow the utilization of (*) as the action within any statement | checker/terraform/rules/aws/iam/aws_iam_user_policy_document_no_wildcard.rego |
| CB_TFAWS_063 | Resource | aws_ssoadmin_permission_set_inline_policy | IAM policy documents should disallow the utilization of (*) as the action within any statement | checker/terraform/rules/aws/iam/aws_iam_user_policy_document_no_wildcard.rego |
| CB_TFAWS_064 | Resource | aws_iam_role | Make that the AWS IAM policy prohibits the assumption of roles for all services | checker/terraform/rules/aws/iam/aws_iam_role_assume_permission_not_allowed.rego |
| CB_TFAWS_065 | Resource | aws_lb | Verify that the load balancer is utilizing at least TLS 1.2 | checker/terraform/rules/aws/aws_lb_tls.rego |
| CB_TFAWS_065 | Resource | aws_lb_listener | Verify that the load balancer is utilizing at least TLS 1.2 | checker/terraform/rules/aws/aws_lb_tls.rego |
| CB_TFAWS_065 | Resource | aws_alb_listener | Verify that the load balancer is utilizing at least TLS 1.2 | checker/terraform/rules/aws/aws_lb_tls.rego |
| CB_TFAWS_066 | Resource | aws_cloudwatch_log_group | Verify that CloudWatch Log Group specifies retention days | checker/terraform/rules/aws/verify_cloudwatch_log_group_retention_days.rego |
| CB_TFAWS_067 | Resource | aws_cloudtrail | Verify CloudTrail is enabled in all Regions | checker/terraform/rules/aws/verify_cloudtrail_enabled_in_all_regions.rego |
| CB_TFAWS_068 | Resource | aws_elasticsearch_domain | Verify that Elasticsearch Domain enforces HTTPS | checker/terraform/rules/aws/verify_elasticsearch_domain_enforce_https.rego |
| CB_TFAWS_068 | Resource | aws_opensearch_domain | Verify that Elasticsearch Domain enforces HTTPS | checker/terraform/rules/aws/verify_elasticsearch_domain_enforce_https.rego |
| CB_TFAWS_069 | Resource | aws_ebs_encryption_by_default | Verify that EBS default encryption is active | checker/terraform/rules/aws/aws_ebs_encryption_by_default_encrypted.rego |
| CB_TFAWS_070 | Resource | aws_neptune_cluster | Make certain that Neptune logging is activated | checker/terraform/rules/aws/aws_neptune_cluster_neptune_logging_enabled.rego |
| CB_TFAWS_071 | Resource | aws_neptune_cluster_instance | See to it that the Neptune Cluster instance is not accessible to the general public | checker/terraform/rules/aws/aws_neptune_cluster_instance_public_restricted.rego |
| CB_TFAWS_072 | Resource | aws_ecs_task_definition | Make that ECS Task definitions for EFS volumes have Encryption in Transit enabled | checker/terraform/rules/aws/aws_ecs_task_definition_transit_encryption_enabled.rego |
| CB_TFAWS_073 | Resource | aws_docdb_cluster_parameter_group | Verify that audit logs are enabled for DocDB | checker/terraform/rules/aws/aws_docdb_cluster_parameter_group_audit_logs_enabled.rego |
| CB_TFAWS_074 | Resource | aws_cloudfront_distribution | CloudFront Distribution should have WAF enabled | checker/terraform/rules/aws/cloudfront_distribution_waf_enabled.rego |
| CB_TFAWS_075 | Resource | aws_mq_broker | Verify MQ Broker is not publicly exposed | checker/terraform/rules/aws/verify_mq_broker_not_publicly_exposed.rego |
| CB_TFAWS_076 | Resource | aws_athena_workgroup | Verify that Athena Workgroup enforces configuration | checker/terraform/rules/aws/verify_athena_workgroup_configuration.rego |
| CB_TFAWS_077 | Resource | aws_s3_bucket | Verify S3 bucket does not allow an action with any Principal | checker/terraform/rules/aws/bucket/verify_s3bucket_not_allow_action_any_principal.rego |
| CB_TFAWS_077 | Resource | aws_s3_bucket_policy | Verify S3 bucket does not allow an action with any Principal | checker/terraform/rules/aws/bucket/verify_s3bucket_not_allow_action_any_principal.rego |
| CB_TFAWS_078 | Resource | aws_redshift_cluster | Verify Redshift Cluster logging is enabled | checker/terraform/rules/aws/verify_redshift_cluster_logging_enabled.rego |
| CB_TFAWS_079 | Resource | aws_sqs_queue_policy | Verify SQS policy does not allow ALL (*) actions. | checker/terraform/rules/aws/verify_sqspolicy_not_allow_all_actions.rego |
| CB_TFAWS_080 | Resource | aws_elasticsearch_domain | Verify that Elasticsearch Domain Logging is enabled | checker/terraform/rules/aws/verify_elastic_domain_logging.rego |
| CB_TFAWS_080 | Resource | aws_opensearch_domain | Verify that Elasticsearch Domain Logging is enabled | checker/terraform/rules/aws/verify_elastic_domain_logging.rego |
| CB_TFAWS_081 | Resource | aws_api_gateway_stage | Verify API Gateway has X-Ray Tracing enabled | checker/terraform/rules/aws/verify_apigateway_xray_tracing_enabled.rego |
| CB_TFAWS_082 | Resource | aws_sagemaker_endpoint_configuration | Achieve secure at-rest encryption for all the data kept in the Sagemaker Endpoint | checker/terraform/rules/aws/aws_sagemaker_endpoint_configuration_encrypted.rego |
| CB_TFAWS_083 | Resource | aws_docdb_cluster | Verify DocDB is encrypted at rest (default is unencrypted) | checker/terraform/rules/aws/database/verify_docdb_encrypted_at_rest.rego |
| CB_TFAWS_084 | Resource | aws_globalaccelerator_accelerator | Verify Global Accelerator accelerator has flow logs enabled | checker/terraform/rules/aws/verify_global_accelerator_has_flow_logs.rego |
| CB_TFAWS_085 | Resource | aws_api_gateway_stage | Verify API Gateway has Access Logging enabled | checker/terraform/rules/aws/verify_apigateway_access_logging_enabled.rego |
| CB_TFAWS_085 | Resource | aws_apigatewayv2_stage | Verify API Gateway has Access Logging enabled | checker/terraform/rules/aws/verify_apigateway_access_logging_enabled.rego |
| CB_TFAWS_086 | Resource | aws_codebuild_project | Verify that CodeBuild Project encryption is not disabled | checker/terraform/rules/aws/verify_codebuild_project_encryption_disabled.rego |
| CB_TFAWS_087 | Resource | aws_ssm_document | Verify that all Session Manager data is transmitted securely | checker/terraform/rules/aws/aws_ssm_document_encrypted.rego |
| CB_TFAWS_088 | Data | aws_iam_policy_document | Make certain that IAM policies prohibit data exfiltration | checker/terraform/rules/aws/iam/aws_iam_policy_document_data_exfiltration_not_allowed.rego |
| CB_TFAWS_089 | Resource | aws_instance | Verify Instance Metadata Service Version 1 is not enabled | checker/terraform/rules/aws/verify_instance_metadata_servicev1_not_enabled.rego |
| CB_TFAWS_089 | Resource | aws_launch_configuration | Verify Instance Metadata Service Version 1 is not enabled | checker/terraform/rules/aws/verify_instance_metadata_servicev1_not_enabled.rego |
| CB_TFAWS_089 | Resource | aws_launch_template | Verify Instance Metadata Service Version 1 is not enabled | checker/terraform/rules/aws/verify_instance_metadata_servicev1_not_enabled.rego |
| CB_TFAWS_090 | Resource | aws_docdb_cluster | Verify that DocDB Logging is enabled | checker/terraform/rules/aws/verify_doc_db_logging.rego |
| CB_TFAWS_091 | Resource | aws_msk_cluster | Verify MSK Cluster logging is enabled | checker/terraform/rules/aws/verify_mskcluster_logging_enabled.rego |
| CB_TFAWS_092 | Resource | aws_cloudfront_distribution | Verify that Ensure Cloudfront distribution has Access Logging enabled | checker/kubernetes/rules/cloudfront_distribution_logging.rego |
| CB_TFAWS_093 | Resource | aws_msk_cluster | Verify MSK Cluster encryption in rest and transit is enabled | checker/terraform/rules/aws/verify_mskcluster_encryption_rest_transint_enabled.rego |
| CB_TFAWS_094 | Resource | aws_redshift_cluster | Verify that Redshift cluster should not be publicly accessible | checker/terraform/rules/aws/verify_redshift_cluster_publicly_available.rego |
| CB_TFAWS_095 | Resource | aws_instance | Verify that EC2 instance should not have public IP | checker/terraform/rules/aws/verify_ec2_public_ip.rego |
| CB_TFAWS_095 | Resource | aws_launch_template | Verify that EC2 instance should not have public IP | checker/terraform/rules/aws/verify_ec2_public_ip.rego |
| CB_TFAWS_096 | Resource | aws_dms_replication_instance | Verify that DMS replication instance should not be publicly accessible | checker/terraform/rules/aws/verify_dms_replication_instance_publicly_accessible.rego |
| CB_TFAWS_097 | Resource | aws_docdb_cluster_parameter_group | Verify that DocDB TLS is not disabled | checker/terraform/rules/aws/enable_doc_db_tls.rego |
| CB_TFAWS_098 | Resource | aws_alb | Verify that ELBv2 (Application/Network) has access logging enabled | checker/terraform/rules/aws/enable_elbv2_access_logs.rego |
| CB_TFAWS_098 | Resource | aws_lb | Verify that ELBv2 (Application/Network) has access logging enabled | checker/terraform/rules/aws/enable_elbv2_access_logs.rego |
| CB_TFAWS_099 | Resource | aws_elb | Verify that ELB has access logging enabled | checker/terraform/rules/aws/enable_elb_access_logs.rego |
| CB_TFAWS_100 | Data | aws_iam_policy_document | Make certain that IAM policies prohibit the disclosure of credentials | checker/terraform/rules/aws/iam/aws_iam_policy_document_credentials_exposed_not_allowed.rego |
| CB_TFAWS_101 | Resource | aws_redshift_parameter_group | Verify Redshift is using SSL | checker/terraform/rules/aws/aws_redshift_parameter_group_ssl.rego |
| CB_TFAWS_102 | Data | aws_iam_policy_document | Make certain IAM policies prohibit unrestricted write access | checker/terraform/rules/aws/iam/aws_iam_policy_document_constraints_restricted.rego |
| CB_TFAWS_103 | Resource | aws_emr_cluster | Verify that EMR clusters with Kerberos have Kerberos Realm set | checker/terraform/rules/aws/verify_emr_clusters_kerberos_realm_set.rego |
| CB_TFAWS_104 | Resource | aws_lambda_function | Verify that AWS Lambda function is configured for function-level concurrent execution limit | checker/terraform/rules/aws/verify_aws_lambda_functionlevel_concurrent_limit.rego |
| CB_TFAWS_105 | Resource | aws_glue_data_catalog_encryption_settings | Verify that Glue Data Catalog Encryption is enabled | checker/terraform/rules/aws/verify_glue_data_catalog_encryption.rego |
| CB_TFAWS_106 | Resource | aws_lambda_function | Verify that AWS Lambda function is configured for a Dead Letter Queue(DLQ) | checker/terraform/rules/aws/verify_aws_lamda_dead_letter_configured.rego |
| CB_TFAWS_107 | Resource | aws_glue_security_configuration | Make certain that Glue Security Configuration Encryption is activated | checker/terraform/rules/aws/aws_glue_security_configuration_encrypted.rego |
| CB_TFAWS_108 | Resource | aws_lambda_function | Verify that AWS Lambda function is configured inside a VPC | checker/terraform/rules/aws/verify_aws_Lambda_function_configured inside_vpc.rego |
| CB_TFAWS_109 | Resource | aws_db_instance | Verify that enhanced monitoring is enabled for Amazon RDS instances | checker/terraform/rules/aws/verify_monitoring_enabled_amazon_rds.rego |
| CB_TFAWS_109 | Resource | aws_rds_cluster_instance | Verify that enhanced monitoring is enabled for Amazon RDS instances | checker/terraform/rules/aws/verify_monitoring_enabled_amazon_rds.rego |
| CB_TFAWS_110 | Resource | aws_rds_cluster | Verify that all data stored in Aurora is securely encrypted at rest | checker/terraform/rules/aws/verify_aurora_encryption.rego |
| CB_TFAWS_111 | Resource | aws_dynamodb_table | Verify DynamoDB Tables are encrypted using a KMS Customer Managed CMK | checker/terraform/rules/aws/verify_dynamodb_tables_encrypted_kms_cmk.rego |
| CB_TFAWS_112 | Resource | aws_eks_node_group | Make certain that 0.0.0.0/0 does not automatically have SSH access to the AWS EKS node group | checker/terraform/rules/aws/aws_eks_node_group_implicit_SSH_access_restricted.rego |
| CB_TFAWS_113 | Resource | aws_elasticache_cluster | Verify that Amazon ElastiCache Redis clusters have automatic backup turned on | checker/terraform/rules/aws/verify_elastic_cache_automatic_backup.rego |
| CB_TFAWS_114 | Resource | aws_api_gateway_stage | Verify API Gateway caching is enabled | checker/terraform/rules/aws/verify_api_gateway_caching_enabled.rego |
| CB_TFAWS_115 | Data | aws_iam_policy_document | Make certain that IAM policies prohibit managing permissions and exposing resources without restrictions | checker/terraform/rules/aws/iam/aws_iam_policy_document_resource_exposure_without_constraints.rego |
| CB_TFAWS_116 | Resource | aws_config_configuration_aggregator | Verify AWS Config is enabled in all regions | checker/terraform/rules/aws/verify_aws_config_enabled_all_regions.rego |
| CB_TFAWS_117 | Resource | aws_sagemaker_notebook_instance | Verify that direct internet access is disabled for an Amazon SageMaker Notebook Instance | checker/terraform/rules/aws/verify_internet_access_disabled_amazon_sagemaker_notebook.rego |
| CB_TFAWS_118 | Resource | aws_ssm_document | Enable and encrypt Session Manager logs | checker/terraform/rules/aws/aws_ssm_document_session_manager_logs_enabled_encrypted.rego |
| CB_TFAWS_119 | Resource | aws_vpc_endpoint_service | Verify that VPC Endpoint Service is configured for Manual Acceptance | checker/terraform/rules/aws/verify_vpc_service_configured_manual_acceptance.rego |
| CB_TFAWS_120 | Resource | aws_cloudformation_stack | Verify that CloudFormation stacks are sending event notifications to an SNS topic | checker/terraform/rules/aws/verify_cloudformation_notifications_snstopic_set.rego |
| CB_TFAWS_121 | Resource | aws_instance | Verify that EC2 is EBS optimized | checker/terraform/rules/aws/enable_ec2_ebs_optimized.rego |
| CB_TFAWS_122 | Resource | aws_codebuild_project | Make certain that CodeBuild projects are CMK-encrypted | checker/terraform/rules/aws/aws_codebuild_project_encrypted.rego |
| CB_TFAWS_123 | Resource | aws_instance | Verify that detailed monitoring is enabled for EC2 instances | checker/terraform/rules/aws/verify_monitoring_enabled_ec2_instances.rego |
| CB_TFAWS_124 | Resource | aws_secretsmanager_secret | The Secrets Manager secret must be encrypted with KMS CMK | checker/terraform/rules/aws/aws_secretsmanager_secret_encrypted.rego |
| CB_TFAWS_125 | Resource | aws_elb | Verify that Elastic Load Balancer(s) uses SSL certificates provided by AWS Certificate Manager | checker/terraform/rules/aws/verify_elb_uses_ssl_certificate.rego |
| CB_TFAWS_126 | Resource | aws_db_instance | Verify that respective logs of Amazon Relational Database Service (Amazon RDS) are enabled | checker/terraform/rules/aws/verify_amazon_rds_respective_logs_enabled.rego |
| CB_TFAWS_127 | Resource | aws_ecr_repository | Verify that ECR repositories are encrypted using KMS | checker/terraform/rules/aws/enable_ecr_repository_encryption.rego |
| CB_TFAWS_128 | Resource | aws_subnet | Verify VPC subnets do not assign public IP by default | checker/terraform/rules/aws/verify_vpc_subnets_not_assign_public_ip.rego |
| CB_TFAWS_129 | Resource | aws_alb | Verify that deletion protection is activated in the load balancer | checker/terraform/rules/aws/aws_lb_deletion_protection_enabled.rego |
| CB_TFAWS_129 | Resource | aws_lb | Verify that deletion protection is activated in the load balancer | checker/terraform/rules/aws/aws_lb_deletion_protection_enabled.rego |
| CB_TFAWS_130 | Resource | aws_alb | Verify that deletion protection is activated in the load balancer | checker/terraform/rules/aws/aws_lb_deletion_protection_enabled.rego |
| CB_TFAWS_130 | Resource | aws_lb | Verify that ALB drops HTTP headers | checker/terraform/rules/aws/verify_alb_drops_http_headers.rego |
| CB_TFAWS_131 | Resource | aws_db_instance | Verify that RDS instances has backup policy | checker/terraform/rules/aws/database/verify_rds_intances_has_backup_policy.rego |
| CB_TFAWS_131 | Resource | aws_rds_cluster | Verify that RDS instances has backup policy | checker/terraform/rules/aws/database/verify_rds_intances_has_backup_policy.rego |
| CB_TFAWS_132 | Resource | aws_alb | Make certain cross-zone load balancing is enabled in the load balancer (network/gateway) | checker/terraform/rules/aws/aws_lb_cross_zone_load_balancing_enabled.rego |
| CB_TFAWS_132 | Resource | aws_lb | Make certain cross-zone load balancing is enabled in the load balancer (network/gateway) | checker/terraform/rules/aws/aws_lb_cross_zone_load_balancing_enabled.rego |
| CB_TFAWS_133 | Resource | aws_default_vpc | Verify that no default VPC is going to be provisioned | checker/terraform/rules/aws/aws_default_vpc_not_allowed.rego |
| CB_TFAWS_134 | Resource | aws_cloudwatch_log_group | Verify that CloudWatch Log Group is encrypted by KMS | checker/terraform/rules/aws/verify_cloudwatch_log_group_encrypted_kms.rego |
| CB_TFAWS_135 | Resource | aws_workspaces_workspace | Make that the root volumes of the workspace are encrypted | checker/terraform/rules/aws/aws_workspaces_workspace_encrypted.rego |
| CB_TFAWS_136 | Resource | aws_workspaces_workspace | Verify that the user volumes of the workspace are encrypted | checker/terraform/rules/aws/aws_workspaces_workspace_user_volumes_encrypted.rego |
| CB_TFAWS_137 | Resource | aws_athena_workgroup | Verify that Athena Workgroup is encrypted | checker/terraform/rules/aws/verify_athena_workgroup_encrypted.rego |
| CB_TFAWS_138 | Resource | aws_timestreamwrite_database | Verify that Timestream database is encrypted with KMS CMK | checker/terraform/rules/aws/database/verify_timestream_database_encrypted.rego |
| CB_TFAWS_139 | Resource | aws_redshift_cluster | Verify that Redshift is not set up outside of a VPC | checker/terraform/rules/aws/aws_redshift_cluster_not_deployed_outside_vpc.rego |
| CB_TFAWS_140 | Resource | aws_elasticsearch_domain | Verify that Elasticsearch is configured inside a VPC | checker/terraform/rules/aws/verify_elasticsearch_vpc.rego |
| CB_TFAWS_140 | Resource | aws_opensearch_domain | Verify that Elasticsearch is configured inside a VPC | checker/terraform/rules/aws/verify_elasticsearch_vpc.rego |
| CB_TFAWS_141 | Resource | aws_elb | Verify that ELB is cross-zone-load-balancing enabled | checker/terraform/rules/aws/verify_elb_cross_zone_enabled.rego |
| CB_TFAWS_142 | Resource | aws_rds_cluster | Verify that RDS clusters have deletion protection enabled | checker/terraform/rules/aws/verify_rds_deletion_protection.rego |
| CB_TFAWS_143 | Resource | aws_rds_global_cluster | Verify that RDS global clusters are encrypted | checker/terraform/rules/aws/verify_rds_cluster_encrypted.rego |
| CB_TFAWS_144 | Resource | aws_redshift_cluster | Verify that Redshift cluster allowing version upgrade by default | checker/terraform/rules/aws/verify_redshift_cluster_allow_version_upgrade.rego |
| CB_TFAWS_145 | Resource | aws_redshift_cluster | Verify that Redshift cluster is encrypted by KMS | checker/terraform/rules/aws/verifiy_redshift_cluster_kms_key.rego |
| CB_TFAWS_146 | Resource | aws_autoscaling_group | Tags for launch configurations should be provided by autoscaling groups | checker/terraform/rules/aws/aws_autoscaling_group_supply_tags_to_launch_configurations.rego |
| CB_TFAWS_147 | Resource | aws_s3_bucket | Verify that S3 bucket has lock configuration enabled by default | checker/terraform/rules/aws/verify_s3_bucket_object_lock.rego |
| CB_TFAWS_148 | Resource | aws_db_instance | Verify that Multi-AZ is enabled for RDS instances | checker/terraform/rules/aws/aws_db_instance_rds_instances_multi_az_enabled.rego |
| CB_TFAWS_149 | Resource | aws_s3_bucket | Verify that S3 bucket has cross-region replication enabled | checker/terraform/rules/aws/verifiy_s3_bucket_replication_configuration.rego |
| CB_TFAWS_149 | Resource | aws_s3_bucket_replication_configuration | Verify that S3 bucket has cross-region replication enabled | checker/terraform/rules/aws/verifiy_s3_bucket_replication_configuration.rego |
| CB_TFAWS_150 | Resource | aws_s3_bucket | Verify that S3 buckets are encrypted with KMS by default | checker/terraform/rules/aws/verify_kms_encrypted_by_default.rego |
| CB_TFAWS_150 | Resource | aws_s3_bucket_server_side_encryption_configuration | Verify that S3 buckets are encrypted with KMS by default | checker/terraform/rules/aws/verify_kms_encrypted_by_default.rego |
| CB_TFAWS_151 | Resource | aws_db_cluster_snapshot | Verify that RDS database cluster snapshot is encrypted | checker/terraform/rules/aws/verify_rds_cluster_snapshot_encryption.rego |
| CB_TFAWS_152 | Resource | aws_db_instance | Verify that IAM authentication is enabled in the RDS database | checker/terraform/rules/aws/aws_db_instance_rds_database_iam_authentication_enabled.rego |
| CB_TFAWS_153 | Resource | aws_rds_cluster | Verify that IAM authentication is enabled for the RDS cluster | checker/terraform/rules/aws/aws_rds_cluster_iam_authentication_enabled.rego |
| CB_TFAWS_154 | Resource | aws_transfer_server | Verify that the Transfer Server is not accessible to the public | checker/terraform/rules/aws/aws_transfer_server_disallow_public_exposure.rego |
| CB_TFAWS_155 | Resource | aws_ecr_repository | Verify that ECR image scanning on push is activated | checker/terraform/rules/aws/aws_ecr_repository_ecr_image_scanning_on_push_enabled.rego |
| CB_TFAWS_156 | Resource | aws_dynamodb_global_table | Make certain that global tables have Dynamodb point in time recovery (backup) enabled | checker/terraform/rules/aws/aws_dynamodb_global_table_point_in_time_recovery_for_global_tables_enabled.rego |
| CB_TFAWS_157 | Resource | aws_backup_vault | Verify that Backup Vault is encrypted at rest using KMS CMK | checker/terraform/rules/aws/verify_backup_vault_encrypted.rego |
| CB_TFAWS_158 | Resource | aws_glacier_vault | Verify that Glacier Vault access policy is not public by only allowing specific services or principals to access it | checker/terraform/rules/aws/verify_glacier_valut_any_principal.rego |
| CB_TFAWS_159 | Resource | aws_sqs_queue | Verify that SQS queue policy is not public by only allowing specific services or principals to access it | checker/terraform/rules/aws/verify_sqs_queue_policy_any_principal.rego |
| CB_TFAWS_160 | Resource | aws_sns_topic_policy | Verify that SNS topic policy is not public by only allowing specific services or principals to access it | checker/terraform/rules/aws/verify_sns_topic_policy_any_principal.rego |
| CB_TFAWS_161 | Resource | aws_qldb_ledger | Make certain that the QLDB ledger permissions mode is set to STANDARD | checker/terraform/rules/aws/aws_qldb_ledger_permissions_mode_standard.rego |
| CB_TFAWS_162 | Resource | aws_qldb_ledger | Verify that deletion protection is activated in QLDB ledger | checker/terraform/rules/aws/aws_qldb_ledger_deletion_protection_enabled.rego |
| CB_TFAWS_163 | Resource | aws_waf_web_acl | Verify that WAF is in compliance with all applicable rules | checker/terraform/rules/aws/aws_wafv2_web_acl_waf_associated_rules.rego |
| CB_TFAWS_163 | Resource | aws_wafregional_web_acl | Verify that WAF is in compliance with all applicable rules | checker/terraform/rules/aws/aws_wafv2_web_acl_waf_associated_rules.rego |
| CB_TFAWS_163 | Resource | aws_wafv2_web_acl | Verify that WAF is in compliance with all applicable rules | checker/terraform/rules/aws/aws_wafv2_web_acl_waf_associated_rules.rego |
| CB_TFAWS_164 | Resource | aws_emr_security_configuration | Make certain SSE-KMS is being used for the encryption in the Cluster security setup | checker/terraform/rules/aws/aws_emr_security_configuration_cluster_security_configuration_encryption_utilize_sse_kms.rego |
| CB_TFAWS_165 | Resource | aws_lambda_function | For the Lambda environmental variable, verify the encryption settings | checker/terraform/rules/aws/aws_lambda_function_lambda_environmental_variable_encryption_settings.rego |
| CB_TFAWS_166 | Resource | aws_cloudfront_distribution | Confirm that the CloudFront Distribution Viewer Certificate is TLS v1.2 compliant | checker/terraform/rules/aws/aws_cloudfront_distribution_cloudfront_distribution_viewer_certificate_utilizing_tls.rego |
| CB_TFAWS_167 | Resource | aws_waf_web_acl | Verify WAF Web Access Control Lists are configured with logging enabled | checker/terraform/rules/aws/aws_waf_web_acl_waf_web_access_control_lists_logging_enabled.rego
| CB_TFAWS_167 | Resource | aws_wafregional_web_acl | Verify WAF Web Access Control Lists are configured with logging enabled | checker/terraform/rules/aws/aws_waf_web_acl_waf_web_access_control_lists_logging_enabled.rego |
| CB_TFAWS_168 | Resource | aws_kinesis_video_stream | A Customer Managed Key (CMK) should be used by KMS to encrypt Kinesis Video Stream | checker/terraform/rules/aws/aws_kinesis_video_stream_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_169 | Resource | aws_fsx_ontap_file_system | A customer managed Key (CMK) should be used to encrypt the fx ontap file system | checker/terraform/rules/aws/aws_fsx_ontap_file_system_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_170 | Resource | aws_fsx_windows_file_system | A customer managed Key (CMK) should be used to encrypt the FSX Windows filesystem | checker/terraform/rules/aws/aws_fsx_windows_file_system_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_171 | Resource | aws_imagebuilder_component | A customer managed Key (CMK) should be used to encrypt the Image Builder component | checker/terraform/rules/aws/aws_imagebuilder_component_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_172 | Resource | aws_s3_object_copy | A customer managed Key (CMK) should be used to encrypt the S3 Object Copy | checker/terraform/rules/aws/aws_s3_object_copy_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_173 | Resource | aws_docdb_cluster | A customer managed Key (CMK) should be used to encrypt the Doc DB | checker/terraform/rules/aws/aws_docdb_cluster_encrypted_kms_utilizing_cmk.rego |
| CB_TFAWS_174 | Resource | aws_ebs_snapshot_copy | A customer managed Key (CMK) should be used to encrypt the EBS Snapshot Copy | checker/terraform/rules/aws/aws_ebs_snapshot_copy_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_175 | Resource | aws_efs_file_system | A customer managed Key (CMK) should be used to encrypt the resource | checker/terraform/rules/aws/aws_efs_file_system_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_176 | Resource | aws_kinesis_stream | A customer managed Key (CMK) should be used to encrypt the Kinesis Stream | checker/terraform/rules/aws/aws_kinesis_stream_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_177 | Resource | aws_s3_bucket_object | A customer managed Key (CMK) should be used to encrypt the S3 bucket Object | checker/terraform/rules/aws/aws_s3_bucket_object_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_178 | Resource | aws_sagemaker_domain | A customer managed Key (CMK) should be used to encrypt the Sagemaker domain | checker/terraform/rules/aws/aws_sagemaker_domain_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_179 | Resource | aws_redshift_cluster | A customer managed Key (CMK) should be used to encrypt the RedShift Cluster | checker/terraform/rules/aws/aws_redshift_cluster_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_180 | Resource | aws_ebs_volume | A customer managed Key (CMK) should be used to encrypt the EBS Volume | checker/terraform/rules/aws/aws_ebs_volume_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_181 | Resource | aws_fsx_lustre_file_system | A customer managed Key (CMK) should be used to encrypt the lustre file systems | checker/terraform/rules/aws/aws_fsx_lustre_file_system_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_182 | Resource | aws_elasticache_replication_group | A customer managed Key (CMK) should be used to encrypt the Elasticache replication group | checker/terraform/rules/aws/aws_elasticache_replication_group_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_183 | Resource | aws_wafv2_web_acl | See to it that WAF blocks Log4j2 message lookup. Take a look at CVE-2021-44228, also known as log4jshell | checker/terraform/rules/aws/aws_wafv2_web_acl_prevention_of_message_lookup_in_log4j2_by_waf.rego |
| CB_TFAWS_184 | Resource | aws_appsync_graphql_api | Verify that logging is enabled in AppSync | checker/terraform/rules/aws/aws_appsync_graphql_api_appsync_logging_enabled.rego |
| CB_TFAWS_185 | Resource | aws_appsync_graphql_api | Verify that Field-Level logs are activated in AppSync | checker/terraform/rules/aws/aws_appsync_graphql_api_field_level_logs_enabled.rego |
| CB_TFAWS_186 | Resource | aws_glue_crawler | Verify that the Glue component is connected to a security configuration | checker/terraform/rules/aws/aws_glue_crawler_glue_component_security_config_enabled.rego |
| CB_TFAWS_187 | Resource | aws_elasticache_security_group | Verify there are no resources named aws_elasticache_security_group | checker/terraform/rules/aws/aws_elasticache_security_group_must_not_exist.rego |
| CB_TFAWS_188 | Resource | aws_mq_broker | Make certain MQ Broker Audit logging is activated | checker/terraform/rules/aws/aws_mq_broker_mq_broker_audit_logging_enabled.rego |
| CB_TFAWS_189 | Resource | aws_db_security_group | Verify there are no resources named RDS Security Groups | checker/terraform/rules/aws/aws_db_security_group_must_not_exist.rego |
| CB_TFAWS_190 | Resource | aws_imagebuilder_distribution_configuration | Verify that the Image Builder Distribution Configuration uses KMS, a customer managed Key (CMK), to encrypt AMIs | checker/terraform/rules/aws/aws_imagebuilder_distribution_configuration_encrypts_ami_utilzing_kms_a_cmk.rego |
| CB_TFAWS_191 | Resource | aws_imagebuilder_image_recipe | Confirm that the Image Recipe EBS Disks are CMK encrypted | checker/terraform/rules/aws/aws_imagebuilder_image_recipe_encrypted_with_cmk.rego |
| CB_TFAWS_192 | Resource | aws_memorydb_cluster | Verify KMS CMKs are being used to encrypt MemoryDB at rest | checker/terraform/rules/aws/aws_memorydb_cluster_encrypted_at_rest_utilizing_kms_cmks.rego |
| CB_TFAWS_193 | Resource | aws_memorydb_cluster | Verify that MemoryDB data is encrypted while in transit | checker/terraform/rules/aws/aws_memorydb_cluster_memorydb_data_encrypted_in_transit.rego |
| CB_TFAWS_194 | Resource | aws_fsx_openzfs_file_system | A customer managed Key (CMK) should be used to encrypt the resource | checker/terraform/rules/aws/aws_fsx_openzfs_file_system_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_195 | Resource | aws_db_instance | Verify RDS uses a modern CaCert | checker/terraform/rules/aws/database/verify_rds_uses_modern_cacert.rego |
| CB_TFAWS_196 | Resource | aws_dms_replication_instance | Verify EBS Volume is encrypted by KMS using a customer managed Key (CMK) | checker/terraform/rules/aws/verify_ebs_volume_encrypted_kms_cmk.rego |
| CB_TFAWS_197 | Resource | aws_load_balancer_policy | Verify ELB Policy uses only secure protocols | checker/terraform/rules/aws/verify_elb_policy_uses_secure_protocols.rego |
| CB_TFAWS_198 | Resource | aws_db_instance | Verify that DB instance gets all minor upgrades automatically | checker/terraform/rules/aws/aws_db_instance_minor_upgrade.rego |
| CB_TFAWS_198 | Resource | aws_rds_cluster_instance | Verify that DB instance gets all minor upgrades automatically | checker/terraform/rules/aws/aws_db_instance_minor_upgrade.rego |
| CB_TFAWS_199 | Resource | aws_kms_key | Verify that KMS key is enabled | checker/terraform/rules/aws/verify_kms_key_enabled.rego |
| CB_TFAWS_200 | Resource | aws_appsync_api_cache | Verify Appsync API Cache is encrypted at rest | checker/terraform/rules/aws/verify_appsync_api_cache_encrypted_at_rest.rego |
| CB_TFAWS_201 | Resource | aws_appsync_api_cache | Verify Appsync API Cache is encrypted in transit | checker/terraform/rules/aws/verify_appsync_api_cache_encrypted_at_transit.rego |
| CB_TFAWS_202 | Resource | aws_cloudfront_distribution | Verify Cloudfront distribution is enabled | checker/terraform/rules/aws/verify_cloudfront_distribution_enabled.rego |
| CB_TFAWS_203 | Resource | aws_ami | Verify that AMIs have encryption enabled using KMS Customer Managed Keys (CMKs) | checker/terraform/rules/aws/aws_ami_amis_encrypted_utilizing_kms_cmks.rego |
| CB_TFAWS_204 | Resource | aws_ami_launch_permission | AMI launch permissions should be restricted | checker/terraform/rules/aws/aws_ami_launch_permission_limit_ami_launch_permissions.rego |
| CB_TFAWS_205 | Resource | aws_api_gateway_domain_name | Check that the API Gateway Domain utilizes a current security policy | checker/terraform/rules/aws/aws_api_gateway_domain_name_api_gateway_domain_utilizing_modern_security_policy.rego |
| CB_TFAWS_206 | Resource | aws_mq_broker | Verify that MQ Broker minor version updates are active | checker/terraform/rules/aws/aws_mq_broker_mq_broker_minor_version_updates_enabled.rego |
| CB_TFAWS_207 | Resource | aws_api_gateway_deployment | Verify Create before destroy for API deployments | checker/terraform/rules/aws/verify_create_before_destroy_api_deployments.rego |
| CB_TFAWS_208 | Resource | aws_cloudsearch_domain | Verify that Cloudsearch is using latest TLS | checker/terraform/rules/aws/verify_cloudsearch_using_latest_tls.rego |
| CB_TFAWS_209 | Resource | aws_mq_broker | Verify that the MQBroker version is up to date | checker/terraform/rules/aws/aws_mq_broker_current_mqbroker_version.rego |
| CB_TFAWS_209 | Resource | aws_mq_configuration | Verify that the MQBroker version is up to date | checker/terraform/rules/aws/aws_mq_broker_current_mqbroker_version.rego |
| CB_TFAWS_210 | Resource | aws_codepipeline | Verify Code Pipeline Artifact store is using a KMS CMK | checker/terraform/rules/aws/verify_code_pipeline_artifact_store_using_kms_cmk.rego |
| CB_TFAWS_211 | Resource | aws_cloudsearch_domain | Verify that Cloudsearch is using https | checker/terraform/rules/aws/verify_cloudsearch_using_https.rego |
| CB_TFAWS_212 | Resource | aws_codeartifact_domain | Verify Code artifact Domain is encrypted by KMS using a customer managed Key (CMK) | checker/terraform/rules/aws/verify_code_artifact_domain_encrypted_kms_cmk.rego |
| CB_TFAWS_213 | Resource | aws_dms_replication_instance | Verify DMS instance gets all minor upgrade automatically | checker/terraform/rules/aws/verify_dms_instance_minor_upgrade_automatically.rego |
| CB_TFAWS_214 | Resource | aws_ecs_cluster | Verify ECS Cluster enables logging of ECS Exec | checker/terraform/rules/aws/verify_ecs_cluster_enables_logging_ecs_exec.rego |
| CB_TFAWS_215 | Resource | aws_elasticsearch_domain | Ensure that Elasticsearch domain is using an up to date TLS policy | checker/terraform/rules/aws/aws_elasticsearch_domain_tls_policy.rego |
| CB_TFAWS_215 | Resource | aws_opensearch_domain | Ensure that Elasticsearch domain is using an up to date TLS policy | checker/terraform/rules/aws/aws_elasticsearch_domain_tls_policy.rego |
| CB_TFAWS_216 | Resource | aws_network_acl | Verify that AWS NACL does not allow ingress from 0.0.0.0/0 to port 21 | checker/terraform/rules/aws/verify_network_acl_unrestricted_ingress_21.rego |
| CB_TFAWS_216 | Resource | aws_network_acl_rule | Verify that AWS NACL does not allow ingress from 0.0.0.0/0 to port 21 | checker/terraform/rules/aws/verify_network_acl_unrestricted_ingress_21.rego |
| CB_TFAWS_217 | Resource | aws_ecs_cluster | Verify Cluster logging with CMK | checker/terraform/rules/aws/verify_cluster_logging_cmk.rego |
| CB_TFAWS_218 | Resource | aws_network_acl | Verify that AWS NACL does not allow ingress from 0.0.0.0/0 to port 20 | checker/terraform/rules/aws/verify_network_acl_unrestricted_ingress_20.rego |
| CB_TFAWS_218 | Resource | aws_network_acl_rule | Verify that AWS NACL does not allow ingress from 0.0.0.0/0 to port 20 | checker/terraform/rules/aws/verify_network_acl_unrestricted_ingress_20.rego |
| CB_TFAWS_219 | Resource | aws_network_acl | Verify that AWS NACL does not allow ingress from 0.0.0.0/0 to port 3389 | checker/terraform/rules/aws/verify_network_acl_unrestricted_ingress_3389.rego |
| CB_TFAWS_219 | Resource | aws_network_acl_rule | Verify that AWS NACL does not allow ingress from 0.0.0.0/0 to port 3389 | checker/terraform/rules/aws/verify_network_acl_unrestricted_ingress_3389.rego |
| CB_TFAWS_220 | Resource | aws_network_acl | Verify that AWS NACL does not allow ingress from 0.0.0.0/0 to port 22 | checker/terraform/rules/aws/verify_network_acl_unrestricted_ingress_22.rego |
| CB_TFAWS_220 | Resource | aws_network_acl_rule | Verify that AWS NACL does not allow ingress from 0.0.0.0/0 to port 22 | checker/terraform/rules/aws/verify_network_acl_unrestricted_ingress_22.rego |
| CB_TFAWS_221 | Resource | aws_acm_certificate | Verify Create before destroy for ACM certificates is enabled | checker/terraform/rules/aws/verify_acm_cert_create_before_destroy_enabled.rego |
| CB_TFAWS_222 | Resource | aws_acm_certificate | Verify that logging preference for ACM certificates is enabled | checker/terraform/rules/aws/verify_acm_cert_logging_preference_enabled.rego |
| CB_TFAWS_223 | Resource | aws_ami_copy | Verify that copied AMIs are encrypted | checker/terraform/rules/aws/verify_ami_copy_is_encrypted.rego |
| CB_TFAWS_224 | Resource | aws_api_gateway_method_settings | Verify API Gateway method setting caching is enabled | checker/terraform/rules/aws/verify_api_gateway_method_setting_caching_enabled.rego |
| CB_TFAWS_225 | Resource | aws_ami_copy | Verify that AMI copying uses a CMK | checker/terraform/rules/aws/verify_ami_copy_uses_cmk.rego |
| CB_TFAWS_226 | Resource | aws_api_gateway_rest_api | Verify Create before destroy for API GATEWAY | checker/terraform/rules/aws/verify_create_before_destroy_api_gateway_rest_api.rego |
| CB_TFAWS_227 | Resource | aws_guardduty_detector | Verify that Guard Duty detector is enabled | checker/terraform/rules/aws/verify_guard_duty_detector_is_enabled.rego |
| CB_TFAWS_228 | Resource | aws_dax_cluster | Verify that DAX cluster endpoint is using TLS | checker/terraform/rules/aws/verify_dax_endpoint_tls.rego |
| CB_TFAWS_229 | Resource | aws_kinesis_firehose_delivery_stream | Verify that Kinesis Firehose delivery stream is encrypted | checker/terraform/rules/aws/verify_kinesis_firehost_delivery_stream_sse.rego |
| CB_TFAWS_230 | Resource | aws_cloudtrail | Verify CloudTrail logging is enabled | checker/terraform/rules/aws/verify_cloudtrail_logging_enabled.rego |
| CB_TFAWS_231 | Resource | aws_cloudtrail | Verify CloudTrail defines an SNS Topic | checker/terraform/rules/aws/verify_cloudtrail_sns_topic_define.rego |
| CB_TFAWS_232 | Resource | aws_kinesis_firehose_delivery_stream | Verify that Kinesis Firehose Delivery Streams are encrypted with CMK | checker/terraform/rules/aws/verify_kinesis_firehost_delivery_stream_uses_cmk.rego |
| CB_TFAWS_233 | Resource | aws_mq_broker | A customer managed Key (CMK) should be used to encrypt the MQ broker | checker/terraform/rules/aws/aws_mq_broker_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_234 | Resource | aws_dlm_lifecycle_policy | Verify DLM cross region events are encrypted | checker/terraform/rules/aws/verify_dlm_cross_region_events_encrypted.rego |
| CB_TFAWS_235 | Resource | aws_batch_job_definition | There is no privileged container defined by a batch job | checker/terraform/rules/aws/aws_batch_job_definition_batch_job_no_defined_privileged_container.rego |
| CB_TFAWS_236 | Resource | aws_dlm_lifecycle_policy | Verify DLM cross region events are encrypted with Customer Managed Key | checker/terraform/rules/aws/verify_dlm_cross_region_events_encrypted_cmk.rego |
| CB_TFAWS_237 | Resource | aws_dlm_lifecycle_policy | Verify DLM cross region schedules are encrypted | checker/terraform/rules/aws/verify_dlm_cross_region_schedules_encrypted.rego |
| CB_TFAWS_238 | Resource | aws_dlm_lifecycle_policy | Verify DLM cross region schedules are encrypted using a Customer Managed Key | checker/terraform/rules/aws/verify_dlm_cross_region_schedules_encrypted_cmk.rego |
| CB_TFAWS_239 | Resource | aws_codecommit_approval_rule_template | Verify codecommit branch changes have at least 2 approvals | checker/terraform/rules/aws/verify_codecommit_branch_changes_have_2_approvals.rego |
| CB_TFAWS_240 | Resource | aws_lambda_function_url | Verify that Lambda function URLs AuthType is not None | checker/terraform/rules/aws/verify_lambda_function_urls_authtype_not_none.rego |
| CB_TFAWS_241 | Resource | aws_db_snapshot_copy | Verify that the App Flow connector profile utilizes CMK | checker/terraform/rules/aws/aws_db_snapshot_copy_app_flow_connector_profile_utilizing_cmk.rego |
| CB_TFAWS_242 | Resource | aws_comprehend_entity_recognizer | A customer managed Key (CMK) should be used to encrypt the Comprehend Entity Recognizer's model | checker/terraform/rules/aws/aws_comprehend_entity_recognizer_comprehend_entity_recognizer_model_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_243 | Resource | aws_comprehend_entity_recognizer | A customer managed Key (CMK) should be used to encrypt the Comprehend Entity Recognizer's volume | checker/terraform/rules/aws/aws_comprehend_entity_recognizer_comprehend_entity_recognizer_volume_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_244 | Resource | aws_connect_instance_storage_config | Verify that the Kinesis Video Stream Storage Config of the Connect Instance utilizes a Customer Managed Key (CMK) for encryption | checker/terraform/rules/aws/aws_connect_instance_storage_config_connect_instance_kinesis_video_stream_storage_config_utilizing_cmk.rego |
| CB_TFAWS_245 | Resource | aws_connect_instance_storage_config | Verify that the S3 Storage Config of the Connect Instance utilizes a Customer Managed Key (CMK) for encryption | checker/terraform/rules/aws/aws_connect_instance_storage_config_connect_instance_s3_storage_config_utilizing_cmk.rego |
| CB_TFAWS_246 | Resource | aws_dynamodb_table_replica | Verify that KMS encryption with a customer managed key (CMK) is employed for DynamoDB table replica encryption | checker/terraform/rules/aws/aws_dynamodb_table_replica_encrypted_by_kms_utlizing_cmk.rego |
| CB_TFAWS_247 | Resource | aws_cloudfront_response_headers_policy | Verify CloudFront response header policy enforces Strict Transport Security | checker/terraform/rules/aws/verify_cloudfront_policy_enforces_strict_transport_security.rego |
| CB_TFAWS_248 | Resource | aws_lambda_function | Verify that the AWS Lambda function is set up to authenticate code-signing | checker/terraform/rules/aws/aws_lambda_function_configured_to_validate_code_signing.rego |
| CB_TFAWS_249 | Resource | aws_iam_user | Verify that access is managed via Single Sign-On (SSO) rather than AWS IAM defined users | checker/terraform/rules/aws/aws_iam_user_controlled_access_through_sso_not_aws_iam_defined_users.rego |
| CB_TFAWS_250 | Resource | aws_iam_group_policy_attachment | Prohibit the usage of the AWS AdministratorAccess policy for IAM roles, users, and groups | checker/terraform/rules/aws/iam/aws_iam_role_deny_iam_roles_users_groups_utilizing_aws_administratoraccess_policy.rego |
| CB_TFAWS_250 | Resource | aws_iam_policy_attachment | Prohibit the usage of the AWS AdministratorAccess policy for IAM roles, users, and groups | checker/terraform/rules/aws/iam/aws_iam_role_deny_iam_roles_users_groups_utilizing_aws_administratoraccess_policy.rego |
| CB_TFAWS_250 | Resource | aws_iam_role | Prohibit the usage of the AWS AdministratorAccess policy for IAM roles, users, and groups | checker/terraform/rules/aws/iam/aws_iam_role_deny_iam_roles_users_groups_utilizing_aws_administratoraccess_policy.rego |
| CB_TFAWS_250 | Resource | aws_iam_role_policy_attachment | Prohibit the usage of the AWS AdministratorAccess policy for IAM roles, users, and groups | checker/terraform/rules/aws/iam/aws_iam_role_deny_iam_roles_users_groups_utilizing_aws_administratoraccess_policy.rego |
| CB_TFAWS_250 | Resource | aws_iam_user_policy_attachment | Prohibit the usage of the AWS AdministratorAccess policy for IAM roles, users, and groups | checker/terraform/rules/aws/iam/aws_iam_role_deny_iam_roles_users_groups_utilizing_aws_administratoraccess_policy.rego |
| CB_TFAWS_250 | Resource | aws_ssoadmin_managed_policy_attachment | Prohibit the usage of the AWS AdministratorAccess policy for IAM roles, users, and groups | checker/terraform/rules/aws/iam/aws_iam_role_deny_iam_roles_users_groups_utilizing_aws_administratoraccess_policy.rego |
| CB_TFAWS_251 | Resource | aws_api_gateway_method_settings | Check to make sure that there is no open API access to back-end resources | checker/terraform/rules/aws/aws_api_gateway_method_open_access.rego |
| CB_TFAWS_252 | Resource | aws_security_group | Verify no security groups allow ingress from 0.0.0.0:0 to port 80 | checker/terraform/rules/aws/verify_security_group_allow_ingress_port_80.rego |
| CB_TFAWS_252 | Resource | aws_security_group_rule | Verify no security groups allow ingress from 0.0.0.0:0 to port 80 | checker/terraform/rules/aws/verify_security_group_allow_ingress_port_80.rego |
| CB_TFAWS_252 | Resource | aws_vpc_security_group_ingress_rule | Verify no security groups allow ingress from 0.0.0.0:0 to port 80 | checker/terraform/rules/aws/verify_security_group_allow_ingress_port_80.rego |
| CB_TFAWS_253 | Resource | aws_security_group | Verify that no security groups permit incoming connections from 0.0.0.0:0 to port -1 | checker/terraform/rules/aws/aws_security_group_no_security_groups_allow_ingress.rego |
| CB_TFAWS_253 | Resource | aws_security_group_rule | Verify that no security groups permit incoming connections from 0.0.0.0:0 to port -1 | checker/terraform/rules/aws/aws_security_group_no_security_groups_allow_ingress.rego |
| CB_TFAWS_253 | Resource | aws_vpc_security_group_ingress_rule | Verify that no security groups permit incoming connections from 0.0.0.0:0 to port -1 | checker/terraform/rules/aws/aws_security_group_no_security_groups_allow_ingress.rego |
| CB_TFAWS_254 | Resource | aws_alb_target_group | Verify HTTP HTTPS Target group defines Healthcheck | checker/terraform/rules/aws/verify_http_https_target_group_defines_healthcheck.rego |
| CB_TFAWS_254 | Resource | aws_lb_target_group | Verify HTTP HTTPS Target group defines Healthcheck | checker/terraform/rules/aws/verify_http_https_target_group_defines_healthcheck.rego |
| CB_TFAWS_255 | Resource | aws_kendra_index | Verify Kendra index Server side encryption uses CMK | checker/terraform/rules/aws/verify_kendra_index_server_side_encryption_uses_cmk.rego |
| CB_TFAWS_256 | Resource | aws_mwaa_environment | Verify that MWAA environment has scheduler logs enabled | checker/terraform/rules/aws/verify_mwaa_scheduler_logs_enabled.rego |
| CB_TFAWS_257 | Resource | aws_appflow_flow | Verify App Flow flow uses CMK | checker/terraform/rules/aws/verify_app_flow_flow_uses_cmk.rego |
| CB_TFAWS_258 | Resource | aws_appflow_connector_profile | Verify App Flow connector profile uses CMK | checker/terraform/rules/aws/verify_app_flow_connector_profile_uses_cmk.rego |
| CB_TFAWS_259 | Resource | aws_memorydb_snapshot | A customer managed Key (CMK) should be used to encrypt the MemoryDB snapshot | checker/terraform/rules/aws/aws_memorydb_snapshot_memorydb_snapshot_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_260 | Resource | aws_keyspaces_table | Verify Keyspaces Table uses CMK | checker/terraform/rules/aws/aws_neptune_cluster_snapshot_neptune_snapshot_encrypted.rego |
| CB_TFAWS_261 | Resource | aws_neptune_cluster_snapshot | Verify that the encryption of Neptune snapshots is robust and secure | checker/terraform/rules/aws/aws_neptune_cluster_snapshot_neptune_snapshot_encrypted.rego |
| CB_TFAWS_262 | Resource | aws_neptune_cluster_snapshot | A customer managed Key (CMK) should be used to encrypt the Neptune snapshot | checker/terraform/rules/aws/aws_neptune_cluster_snapshot_neptune_snapshot_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_263 | Resource | aws_dms_s3_endpoint | Verify DMS S3 uses Customer Managed Key (CMK) | checker/terraform/rules/aws/verify_dms_s3_uses_cmk.rego |
| CB_TFAWS_264 | Resource | aws_dms_s3_endpoint | Verify DMS S3 defines in-transit encryption | checker/terraform/rules/aws/verify_dms_s3_defines_in_trainsit_encryption.rego |
| CB_TFAWS_265 | Resource | aws_redshift_snapshot_copy_grant | A customer managed Key (CMK) should be used to encrypt the RedShift snapshot copy | checker/terraform/rules/aws/aws_redshift_snapshot_copy_grant_redshift_snapshot_copy_encrypted_by_kms_utlilizing_cmk.rego |
| CB_TFAWS_266 | Resource | aws_redshiftserverless_namespace | A customer managed Key (CMK) should be used to encrypt the Redshift Serverless namespace | checker/terraform/rules/aws/aws_redshiftserverless_namespace_redshiftserverless_namespace_encrypted_by_kms_utilizing_cmk.rego |
| CB_TFAWS_267 | Resource | aws_sfn_state_machine | Verify that the State Machine includes active X-Ray tracing functionality | checker/terraform/rules/aws/aws_sfn_state_machine_state_machine_xray_tracing_enabled.rego |
| CB_TFAWS_268 | Resource | aws_sfn_state_machine | Guarantee that the State Machine has active execution history logging | checker/terraform/rules/aws/aws_sfn_state_machine_state_machine_execution_history_logging_enabled.rego |
| CB_TFAWS_269 | Resource | aws_docdb_global_cluster | Verify that the DocDB Global Cluster enforces encryption at rest, as the default state is unencrypted | checker/terraform/rules/aws/aws_docdb_global_cluster_encrypted.rego |
| CB_TFAWS_270 | Resource | aws_msk_cluster | Guarantee the privacy of MSK nodes | checker/terraform/rules/aws/aws_msk_cluster_msk_nodes_are_private.rego |
| CB_TFAWS_271 | Resource | aws_mwaa_environment | Verify that MWAA environment has worker logs enabled | checker/terraform/rules/aws/verify_mwaa_worker_logs_enabled.rego |
| CB_TFAWS_272 | Resource | aws_mwaa_environment | Verify that MWAA environment has webserver logs enabled | checker/terraform/rules/aws/verify_mwaa_webserver_logs_enabled.rego |
| CB_TFAWS_273 | Resource | aws_db_instance | Verify that deletion protection is activated for AWS database instances | checker/terraform/rules/aws/iam/aws_db_instance_database_instances_deletion_protection_enabled.rego |
| CB_TFAWS_274 | Resource | aws_db_instance_automated_backups_replication | Verify replicated backups are encrypted at rest using KMS CMKs | checker/terraform/rules/aws/database/verify_rds_instance_auto_backup_encryption_wth_cmk.rego |
| CB_TFAWS_275 | Resource | aws_s3_bucket_lifecycle_configuration | Verify S3 lifecycle configuration sets period for aborting failed uploads | checker/terraform/rules/aws/verify_s3_lifecycle_configuration_period_aborting_failed_uploads.rego |
| CB_TFAWS_276 | Resource | aws_rds_cluster_activity_stream | Verify RDS Cluster activity streams are encrypted using KMS CMKs. | checker/terraform/rules/aws/verify_rds_cluster_activity_stream_encrypted_with_cmk.rego |
| CB_TFAWS_277 | Resource | aws_lambda_permission | Verify that AWS Lambda function is not publicly accessible | checker/terraform/rules/aws/verify_aws_lambda_function_not_publicly_accessible.rego |
| CB_TFAWS_278 | Resource | aws_elasticsearch_domain | Verify all data stored in the Elasticsearch is encrypted with a CMK. | checker/terraform/rules/aws/verify_elasticsearch_encryption_with_cmk.rego |
| CB_TFAWS_278 | Resource | aws_opensearch_domain | Verify all data stored in the Elasticsearch is encrypted with a CMK. | checker/terraform/rules/aws/verify_elasticsearch_encryption_with_cmk.rego |
| CB_TFAWS_279 | Resource | aws_elasticsearch_domain | Verify that Elasticsearch is not using the default Security Group | checker/terraform/rules/aws/verify_elesticsearch_default_security_group.rego |
| CB_TFAWS_279 | Resource | aws_opensearch_domain | Verify that Elasticsearch is not using the default Security Group | checker/terraform/rules/aws/verify_elesticsearch_default_security_group.rego |
| CB_TFAWS_280 | Resource | aws_db_snapshot | Verify DB Snapshots are not Public | checker/terraform/rules/aws/verify_db_snapshots_not_public.rego |
| CB_TFAWS_281 | Resource | aws_ecs_task_definition | Verify that the Execution Role ARN and the Task Role ARN are different in ECS Task definitions | checker/terraform/rules/aws/verify_ecs_task_definition_role.rego |
| CB_TFAWS_282 | Resource | aws_ssm_document | Verify SSM documents are not Public | checker/terraform/rules/aws/verify_ssm_documents_not_public.rego |
| CB_TFAWS_283 | Resource | aws_db_instance | Verify that RDS PostgreSQL instances use a non vulnerable version with the log_fdw extension | checker/terraform/rules/aws/verify_rds_postgress_sql_log_fwd_extenstion.rego |
| CB_TFAWS_283 | Resource | aws_rds_cluster | Verify that RDS PostgreSQL instances use a non vulnerable version with the log_fdw extension | checker/terraform/rules/aws/verify_rds_postgress_sql_log_fwd_extenstion.rego |
| CB_TFAWS_284 | Resource | aws_cloudtrail_event_data_store | Require that the Cloud Trail Event Data Store utilizes a Customer Managed Key (CMK) | checker/terraform/rules/aws/aws_cloudtrail_event_data_store_utilizing_cmk.rego |
| CB_TFAWS_285 | Resource | aws_secretsmanager_secret_rotation | Verify Secrets Manager secrets should be rotated within 90 days | checker/terraform/rules/aws/verify_secrets_manager_secrets_should_be_rotated.rego |
| CB_TFAWS_286 | Resource | aws_datasync_location_object_storage | Verify that DataSync Location Object Storage does not reveal sensitive information | checker/terraform/rules/aws/aws_datasync_location_object_storage_no_secrets_exposed.rego |
| CB_TFAWS_287 | Resource | aws_cloudfront_distribution | Verify Cloudfront distribution has a default root object configured | checker/terraform/rules/aws/verify_cloudfront_distribution_default_root_object_configured.rego |
| CB_TFAWS_288 | Resource | aws_sagemaker_notebook_instance | Verify SageMaker notebook instances should be launched into a custom VPC | checker/terraform/rules/aws/verify_sagemakernotebook_launch_into_custom_vpc.rego |
| CB_TFAWS_289 | Resource | aws_dms_endpoint | Verify that the DMS endpoint utilizes a Customer Managed Key (CMK) for encryption | checker/terraform/rules/aws/aws_dms_endpoint_utilizing_cmk.rego |
| CB_TFAWS_290 | Resource | aws_sagemaker_notebook_instance | Verify SageMaker Users should not have root access to SageMaker notebook instances | checker/terraform/rules/aws/verify_sagemakernotebook_users_root_access_disabled.rego |
| CB_TFAWS_291 | Resource | aws_api_gateway_method_settings | Verify API Gateway method setting caching is set to encrypted | checker/terraform/rules/aws/verify_apigateway_method_setting_caching_encrypted.rego |
| CB_TFAWS_292 | Resource | aws_apigatewayv2_route | Verify API GatewayV2 routes specify an authorization type | checker/terraform/rules/aws/verify_apigatewayv2_routes_specify_auth_type.rego |
| CB_TFAWS_293 | Resource | aws_cloudfront_distribution | Verify CloudFront distributions should have origin failover configured | checker/terraform/rules/aws/verify_cloudfront_distributions_failover_configured.rego |
| CB_TFAWS_294 | Resource | aws_codebuild_project | Verify that CodeBuild S3 logs are encrypted | checker/terraform/rules/aws/verify_codebuild_s3_logs_encrypted.rego |
| CB_TFAWS_295 | Resource | aws_elastic_beanstalk_environment | Verify Elastic Beanstalk environments have enhanced health reporting enabled | checker/terraform/rules/aws/verify_elastic_beanstalk_env_health_reporting_enabled.rego |
| CB_TFAWS_296 | Resource | aws_rds_cluster | Verify that RDS cluster configured to copy tags to snapshots | checker/terraform/rules/aws/verify_rds_cluster_copy_tags.rego |
| CB_TFAWS_297 | Resource | aws_autoscaling_group | Verify that EC2 Auto Scaling groups use EC2 launch templates | checker/terraform/rules/aws/verify_auto_scaling_launch_template.rego |
| CB_TFAWS_298 | Resource | aws_rds_cluster | Verify RDS Aurora Clusters have backtracking enabled | checker/terraform/rules/aws/verify_rds_cluster_aurora_backtrack.rego |
| CB_TFAWS_299 | Resource | aws_rds_cluster | Verify RDS Clusters are encrypted using KMS CMKs | checker/terraform/rules/aws/verify_rds_cluster_encrypted_with_cmk.rego |
| CB_TFAWS_300 | Resource | aws_alb | Verify that ALB is configured with defensive or strictest desync mitigation mode | checker/terraform/rules/aws/verify_alb_desync_mode.rego.rego |
| CB_TFAWS_300 | Resource | aws_elb | Verify that ALB is configured with defensive or strictest desync mitigation mode | checker/terraform/rules/aws/verify_alb_desync_mode.rego.rego |
| CB_TFAWS_300 | Resource | aws_lb | Verify that ALB is configured with defensive or strictest desync mitigation mode | checker/terraform/rules/aws/verify_alb_desync_mode.rego.rego |
| CB_TFAWS_301 | Resource | aws_codebuild_project | Verify that CodeBuild project environments have a logging configuration | checker/terraform/rules/aws/verify_code_build_has_logs.rego |
| CB_TFAWS_302 | Resource | aws_codebuild_project | Verify that CodeBuild project environments do not have privileged mode enabled | checker/terraform/rules/aws/verify_auto_scaling_launch_template.rego |
| CB_TFAWS_303 | Resource | aws_efs_access_point | Verify EFS access points should enforce a root directory | checker/terraform/rules/aws/verify_efs_access_point_root.rego |
| CB_TFAWS_304 | Resource | aws_elasticsearch_domain | Verify that Elasticsearch Domain Logging is enabled | checker/terraform/rules/aws/verify_elasticsearch_domain_audit_logging.rego |
| CB_TFAWS_304 | Resource | aws_opensearch_domain | Verify that Elasticsearch Domain Logging is enabled | checker/terraform/rules/aws/verify_elasticsearch_domain_audit_logging.rego |
| CB_TFAWS_305 | Resource | aws_efs_access_point | Verify EFS access points should enforce a user identity | checker/terraform/rules/aws/verify_efs_access_user_identity.rego |
| CB_TFAWS_306 | Resource | aws_elasticsearch_domain | Verify that Elasticsearch domains are configured with at least three dedicated master nodes for HA | checker/terraform/rules/aws/verify_elasticsearch_domain_cluster_config.rego |
| CB_TFAWS_306 | Resource | aws_opensearch_domain | Verify that Elasticsearch domains are configured with at least three dedicated master nodes for HA | checker/terraform/rules/aws/verify_elasticsearch_domain_cluster_config.rego |
| CB_TFAWS_307 | Resource | aws_cloudwatch_metric_alarm | Verify that CloudWatch alarm actions are enabled | checker/terraform/rules/aws/verify_cloud_watch_alarms_enabled.rego |
| CB_TFAWS_308 | Resource | aws_redshift_cluster | Verify that Redshift clusters do not use the default database name | checker/terraform/rules/aws/database/verify_redshift_cluster_database_name.rego |
| CB_TFAWS_309 | Resource | aws_redshift_cluster | Verify that Redshift clusters use enhanced VPC routing | checker/terraform/rules/aws/verify_redshift_cluster_enchanced_vpc.rego |
| CB_TFAWS_310 | Resource | aws_elasticache_cluster | Verify that ElastiCache for Redis cache clusters have auto minor version upgrades enabled | checker/terraform/rules/aws/verify_aws_elasticache_cluster_automatic_minor_upgrade.rego |
| CB_TFAWS_311 | Resource | aws_elasticache_cluster | Verify that ElastiCache clusters do not use the default subnet group | checker/terraform/rules/aws/verify_aws_elasticache_cluster_custom_subnet.rego |
| CB_TFAWS_312 | Resource | aws_elasticache_cluster | Verify that RDS Cluster log capture is enabled | checker/terraform/rules/aws/verify_aws_rds_cluster_logging.rego |
| CB_TFAWS_314 | Resource | aws_rds_cluster | Verify that RDS Cluster audit logging is enabled for MySQL engine | checker/terraform/rules/aws/verify_aws_rds_cluster_audit_loging.rego |
| CB_TFAWS_315 | Resource | aws_ecs_service | Verify ECS Fargate services run on the latest Fargate platform version | checker/terraform/rules/aws/verify_ecs_service_fargate_latest.rego |
| CB_TFAWS_316 | Resource | aws_ecs_service | Verify ECS services do not have public IP addresses assigned to them automatically | checker/terraform/rules/aws/verify_ecs_service_public_ip.rego |
| CB_TFAWS_317 | Resource | aws_iam_group_membership | Verify that all IAM users are members of at least one IAM group. | checker/terraform/rules/aws/iam/iam_users_member_atleast_1_group.rego |
| CB_TFAWS_318 | Resource | aws_iam_user | Verify an IAM User does not have access to the console | checker/terraform/rules/aws/iam/verify_iam_user_does_not_have_access_to_console.rego |
| CB_TFAWS_319 | Resource | aws_route53_record | Route53 A Record has Attached Resource | checker/terraform/rules/aws/route53_record_has_attached_resource.rego |
| CB_TFAWS_320 | Resource | aws_network_acl | Verify that all NACL are connected to subnets | checker/terraform/rules/aws/aws_network_acl_nacl_attached_to_subnets.rego |
| CB_TFAWS_320 | Resource | aws_subnet | Verify that all NACL are connected to subnets | checker/terraform/rules/aws/aws_network_acl_nacl_attached_to_subnets.rego |
| CB_TFAWS_321 | Resource | aws_instance | Verify an IAM role is attached to EC2 instance | checker/terraform/rules/aws/verify_ec2_instance_has_iam_role_attached.rego |
| CB_TFAWS_322 | Resource | aws_rds_cluster | Verify Postgres RDS as aws_rds_cluster has Query Logging enabled | checker/terraform/rules/aws/verify_postgres_rds_as_aws_rds_cluster_query_logging_enabled.rego |
| CB_TFAWS_322 | Resource | aws_rds_cluster_parameter_group | Verify Postgres RDS as aws_rds_cluster has Query Logging enabled | checker/terraform/rules/aws/verify_postgres_rds_as_aws_rds_cluster_query_logging_enabled.rego |
| CB_TFAWS_323 | Resource | aws_security_group | Check to see if Security Groups are linked to another resource | checker/terraform/rules/aws/aws_security_group_attached_to_another_resource.rego |
| CB_TFAWS_324 | Resource | aws_cloudfront_distribution | Verify AWS CloudFront distribution uses custom SSL certificate | checker/terraform/rules/aws/verify_cloudfront_has_custom_ssl_certificate.rego |
| CB_TFAWS_325 | Resource | aws_alb | Verify public facing ALB are protected by WAF | checker/terraform/rules/aws/verify_public_facing_alb_waf_protected.rego |
| CB_TFAWS_325 | Resource | aws_lb | Verify public facing ALB are protected by WAF | checker/terraform/rules/aws/verify_public_facing_alb_waf_protected.rego |
| CB_TFAWS_326 | Resource | aws_api_gateway_method_settings | Verify that the API Gateway stage has the appropriate logging level specified | checker/terraform/rules/aws/aws_api_gateway_method_settings_api_gateway_have_logging_level_defined_as_appropriate.rego |
| CB_TFAWS_326 | Resource | aws_api_gateway_stage | Verify that the API Gateway stage has the appropriate logging level specified | checker/terraform/rules/aws/aws_api_gateway_method_settings_api_gateway_have_logging_level_defined_as_appropriate.rego |
| CB_TFAWS_327 | Resource | aws_s3_bucket_acl | Verify S3 Bucket does not allow access to all Authenticated users | checker/terraform/rules/aws/verify_s3_not_allow_access_to_all_authenticated_users.rego |
| CB_TFAWS_328 | Resource | aws_s3_bucket | A Public Access block must be present in the S3 bucket | checker/terraform/rules/aws/aws_s3_bucket_s3_bucket_has_public_access_block.rego |
| CB_TFAWS_328 | Resource | aws_s3_bucket_public_access_block | A Public Access block must be present in the S3 bucket | checker/terraform/rules/aws/aws_s3_bucket_s3_bucket_has_public_access_block.rego |
| CB_TFAWS_329 | Resource | aws_emr_cluster | Make certain that the security groups for Amazon EMR clusters are closed to the world | checker/terraform/rules/aws/aws_emr_cluster_ensure_security_groups_of_emr_clusters_are_not_open_to_the_world.rego |
| CB_TFAWS_329 | Resource | aws_security_group | Make certain that the security groups for Amazon EMR clusters are closed to the world | checker/terraform/rules/aws/aws_emr_cluster_ensure_security_groups_of_emr_clusters_are_not_open_to_the_world.rego |
| CB_TFAWS_330 | Resource | aws_rds_cluster | Check to see if the AWS Backup of RDS clusters have a backup plan | checker/terraform/rules/aws/aws_rds_cluster_rds_clusters_has_backup_plan_of_aws_backup.rego |
| CB_TFAWS_331 | Resource | aws_api_gateway_rest_api | Verify public API gateway are protected by WAF | checker/terraform/rules/aws/verify_ public_api_gateway_protected_waf.rego |
| CB_TFAWS_331 | Resource | aws_api_gateway_stage | Verify public API gateway are protected by WAF | checker/terraform/rules/aws/verify_ public_api_gateway_protected_waf.rego |
| CB_TFAWS_332 | Resource | aws_db_instance | Verify public API gateway are protected by WAF | checker/terraform/rules/aws/verify_ public_api_gateway_protected_waf.rego |
| CB_TFAWS_332 | Resource | aws_db_parameter_group | Verify public API gateway are protected by WAF | checker/terraform/rules/aws/verify_ public_api_gateway_protected_waf.rego |
| CB_TFAWS_333 | Resource | aws_route | Verify AWS route table with VPC peering does not contain routes overly permissive to all traffic | checker/terraform/rules/aws/verify_vpc_peering_route_table_overly_permissive.rego |
| CB_TFAWS_333 | Resource | aws_route_table | Verify AWS route table with VPC peering does not contain routes overly permissive to all traffic | checker/terraform/rules/aws/verify_vpc_peering_route_table_overly_permissive.rego |
| CB_TFAWS_334 | Resource | aws_wafv2_web_acl | Verify WAF2 has a Logging Configuration | checker/terraform/rules/aws/verify_waf2_has_logging.rego |
| CB_TFAWS_335 | Resource | aws_appsync_graphql_api | Verify AppSync is protected by WAF | checker/terraform/rules/aws/verify_appsync_waf_protected.rego |
| CB_TFAWS_336 | Resource | aws_ssm_parameter | Verify AWS SSM Parameter is Encrypted | checker/terraform/rules/aws/verify_aws_ssm_parameter_encrypted.rego |
| CB_TFAWS_337 | Resource | aws_route | Verify AWS NAT Gateways are utilized for the default route | checker/terraform/rules/aws/verify_aws_nat_utilized_default_route.rego |
| CB_TFAWS_337 | Resource | aws_route_table | Verify AWS NAT Gateways are utilized for the default route | checker/terraform/rules/aws/verify_aws_nat_utilized_default_route.rego |
| CB_TFAWS_338 | Resource | aws_backup_selection | Make certain that AWS Backup includes Elastic Block Store (EBS) volumes within its backup plans | checker/terraform/rules/aws/aws_backup_selection_ebs_added_in_backup_plans_of_aws_backup.rego |
| CB_TFAWS_339 | Resource | aws_cloudtrail | Verify that CloudWatch Logs are connected with CloudTrail trails | checker/terraform/rules/aws/aws_cloudtrail_trails_integrated_with_cloudwatch_logs.rego |
| CB_TFAWS_340 | Resource | aws_vpc | Verify that VPC flow logging is activated in every VPC | checker/terraform/rules/aws/aws_vpc_ensure_vpc_flow_logging_enabled_for_all_vpcs.rego |
| CB_TFAWS_341 | Resource | aws_config_configuration_recorder | Verify AWS Config recorder is enabled to record all supported resources | checker/terraform/rules/aws/verify_aws_config_recorder_enabled.rego |
| CB_TFAWS_341 | Resource | aws_config_configuration_recorder_status | Verify AWS Config recorder is enabled to record all supported resources | checker/terraform/rules/aws/verify_aws_config_recorder_enabled.rego |
| CB_TFAWS_342 | Resource | aws_default_security_group | Be certain that every VPC's default security group prohibits all traffic | checker/terraform/rules/aws/aws_default_security_group_default_security_group_of_every_vpc_restricts_all_traffic.rego |
| CB_TFAWS_342 | Resource | aws_vpc | Be certain that every VPC's default security group prohibits all traffic | checker/terraform/rules/aws/aws_default_security_group_default_security_group_of_every_vpc_restricts_all_traffic.rego |
| CB_TFAWS_343 | Resource | aws_ssm_parameter | Verify terraform is not sending SSM secrets to untrusted domains over HTTP | checker/terraform/rules/aws/verify_aws_ssm_secret_secured_for_untrusted_domain.rego |
| CB_TFAWS_343 | Resource | data.http | Verify terraform is not sending SSM secrets to untrusted domains over HTTP | checker/terraform/rules/aws/verify_aws_ssm_secret_secured_for_untrusted_domain.rego |
| CB_TFAWS_344 | Resource | aws_codecommit_repository | Verify Codecommit associates an approval rule | checker/terraform/rules/aws/verify_codecommit_associates_approval_rule.rego |
| CB_TFAWS_344 | Resource | aws_codecommit_approval_rule_template_association | Verify Codecommit associates an approval rule | checker/terraform/rules/aws/verify_codecommit_associates_approval_rule.rego |
| CB_TFAWS_345 | Resource | aws_cloudfront_distribution | Verify AWS Cloudfront Distribution with S3 have Origin Access set to enabled | checker/terraform/rules/aws/verify_aws_cloudfront_s3_origin_config_with_oai.rego |
| CB_TFAWS_346 | Resource | aws_config_configuration_recorder | Make sure that AWS Config captures all potential resources | checker/terraform/rules/aws/aws_config_configuration_recorder.rego |
| CB_TFAWS_347 | Resource | aws_iam_group | A minimum of one IAM user must be present in IAM groups | checker/terraform/rules/aws/aws_iam_group_ensure_iam_groups_includes_at_least_one_iam_user.rego |
| CB_TFAWS_347 | Resource | aws_iam_group_membership | A minimum of one IAM user must be present in IAM groups | checker/terraform/rules/aws/aws_iam_group_ensure_iam_groups_includes_at_least_one_iam_user.rego |
| CB_TFAWS_348 | Resource | aws_autoscaling_group | Verify that Elastic Load Balancing health checks are being utilized by auto scaling groups connected to load balancers | checker/terraform/rules/aws/aws_autoscaling_group_auto_scaling_groups_associated_with_load_balancer_are_utilizing_elastic_load_balancing_health_checks.rego |
| CB_TFAWS_348 | Resource | aws_elb | Verify that Elastic Load Balancing health checks are being utilized by auto scaling groups connected to load balancers | checker/terraform/rules/aws/aws_autoscaling_group_auto_scaling_groups_associated_with_load_balancer_are_utilizing_elastic_load_balancing_health_checks.rego |
| CB_TFAWS_348 | Resource | aws_lb_target_group | Verify that Elastic Load Balancing health checks are being utilized by auto scaling groups connected to load balancers | checker/terraform/rules/aws/aws_autoscaling_group_auto_scaling_groups_associated_with_load_balancer_are_utilizing_elastic_load_balancing_health_checks.rego |
| CB_TFAWS_349 | Resource | aws_route53_zone | Verify Domain Name System (DNS) query logging is enabled for Amazon Route 53 hosted zones | checker/terraform/rules/aws/verify_dns_query_logging_enabled.rego |
| CB_TFAWS_350 | Resource | aws_appautoscaling_target | Check to see if Auto Scaling is activated for your DynamoDB tables | checker/terraform/rules/aws/aws_appautoscaling_target_auto_scaling_enabled_on_dynamodb_tables.rego |
| CB_TFAWS_350 | Resource | aws_dynamodb_table | Check to see if Auto Scaling is activated for your DynamoDB tables | checker/terraform/rules/aws/aws_appautoscaling_target_auto_scaling_enabled_on_dynamodb_tables.rego |
| CB_TFAWS_351 | Resource | aws_backup_selection | Be certain to include Elastic File System (Amazon EFS) file systems in the backup plans of AWS Backup | checker/terraform/rules/aws/aws_backup_selection_ensure_efs_file_systems_are_added_in_backup_plans_of_aws_backup.rego |
| CB_TFAWS_352 | Resource | aws_eip | An EIP addresses of a VPC must be connected to EC2 instances | checker/terraform/rules/aws/aws_eip_eip_addresses_allocated_to_vpc_attached_to_ec2_instances.rego |
| CB_TFAWS_352 | Resource | aws_eip_association | An EIP addresses of a VPC must be connected to EC2 instances | checker/terraform/rules/aws/aws_eip_eip_addresses_allocated_to_vpc_attached_to_ec2_instances.rego |
| CB_TFAWS_353 | Resource | aws_elasticsearch_domain | Confirm that Fine-Grained Access Control is Activated for AWS ElasticSearch/OpenSearch | checker/terraform/rules/aws/aws_elasticsearch_domain_aws_elasticsearch_opensearch_fine_grained_access_control_enabled.rego |
| CB_TFAWS_353 | Resource | aws_opensearch_domain | Confirm that Fine-Grained Access Control is Activated for AWS ElasticSearch/OpenSearch | checker/terraform/rules/aws/aws_elasticsearch_domain_aws_elasticsearch_opensearch_fine_grained_access_control_enabled.rego |
| CB_TFAWS_354 | Resource | aws_iam_policy_attachment | Verify AWS Managed IAMFullAccess IAM policy is not used | checker/terraform/rules/aws/iam/verify_aws_managed_iamfullacces_not_used.rego |
| CB_TFAWS_354 | Resource | aws_iam_group_policy_attachment | Verify AWS Managed IAMFullAccess IAM policy is not used | checker/terraform/rules/aws/iam/verify_aws_managed_iamfullacces_not_used.rego |
| CB_TFAWS_354 | Resource | aws_iam_role | Verify AWS Managed IAMFullAccess IAM policy is not used | checker/terraform/rules/aws/iam/verify_aws_managed_iamfullacces_not_used.rego |
| CB_TFAWS_354 | Resource | aws_iam_role_policy_attachment | Verify AWS Managed IAMFullAccess IAM policy is not used | checker/terraform/rules/aws/iam/verify_aws_managed_iamfullacces_not_used.rego |
| CB_TFAWS_354 | Resource | aws_iam_user_policy_attachment | Verify AWS Managed IAMFullAccess IAM policy is not used | checker/terraform/rules/aws/iam/verify_aws_managed_iamfullacces_not_used.rego |
| CB_TFAWS_354 | Resource | aws_ssoadmin_managed_policy_attachment | Verify AWS Managed IAMFullAccess IAM policy is not used | checker/terraform/rules/aws/iam/verify_aws_managed_iamfullacces_not_used.rego |
| CB_TFAWS_354 | Resource | data.aws_iam_policy | Verify AWS Managed IAMFullAccess IAM policy is not used | checker/terraform/rules/aws/iam/verify_aws_managed_iamfullacces_not_used.rego |
| CB_TFAWS_355 | Resource | aws_secretsmanager_secret | Verify Secrets Manager secrets should have automatic rotation enable | checker/terraform/rules/aws/verify_secrets_manager_secrets_rotation_enabled.rego |
| CB_TFAWS_356 | Resource | aws_api_gateway_method | Confirm proper validation of AWS API gateway requests | checker/terraform/rules/aws/aws_api_gateway_method_aws_api_gateway_request_is_validated.rego |
| CB_TFAWS_357 | Resource | aws_cloudfront_distribution | Verify AWS CloudFront attached WAFv2 WebACL is configured with AMR for Log4j Vulnerability | checker/terraform/rules/aws/verify_aws_cloudfront_web_acl_configured_with_log4j_vulnerability.rego |
| CB_TFAWS_357 | Resource | aws_wafv2_web_acl | Verify AWS CloudFront attached WAFv2 WebACL is configured with AMR for Log4j Vulnerability | checker/terraform/rules/aws/verify_aws_cloudfront_web_acl_configured_with_log4j_vulnerability.rego |
| CB_TFAWS_358 | Resource | aws_neptune_cluster | Verify AWS Neptune cluster deletion protection is enabled | checker/terraform/rules/aws/aws_neptune_cluster_deletion_protected.rego |
| CB_TFAWS_359 | Resource | aws_elasticsearch_domain | Verify ElasticSearch/OpenSearch has dedicated master node enabled | checker/terraform/rules/aws/verify_elasticsearch_opensearch_dedicated_master_node_enabled.rego |
| CB_TFAWS_359 | Resource | aws_opensearch_domain | Verify ElasticSearch/OpenSearch has dedicated master node enabled | checker/terraform/rules/aws/verify_elasticsearch_opensearch_dedicated_master_node_enabled.rego |
| CB_TFAWS_360 | Resource | aws_db_instance | Verify RDS instance with copy tags to snapshots is enabled | checker/terraform/rules/aws/verify_rds_instance_copy_tags_snapshots_enabled.rego |
| CB_TFAWS_361 | Resource | aws_cloudfront_distribution | Guarantee the adoption of secure SSL protocols for HTTPS communication within the AWS CloudFront distribution | checker/terraform/rules/aws/aws_cloudfront_distribution_utilizing_secure_ssl_protocols_for_https_communication.rego |
| CB_TFAWS_362 | Resource | aws_s3_bucket | Verify that an S3 bucket has a lifecycle configuration | checker/terraform/rules/aws/verify_s3_lifecycle_config.rego |
| CB_TFAWS_363 | Resource | aws_s3_bucket | Verify S3 buckets should have event notifications enabled | checker/terraform/rules/aws/verify_s3_notification_enabled.rego |
| CB_TFAWS_364 | Resource | aws_dms_endpoint | Verify AWS Database Migration Service endpoints have SSL configured | checker/terraform/rules/aws/verify_aws_dms_endpoint_have_ssl_configured.rego |
| CB_TFAWS_365 | Resource | aws_emr_cluster | Guarantee proper configuration of a security setup for AWS EMR clusters | checker/terraform/rules/aws/aws_emr_cluster_configured_with_security_configuration.rego |
| CB_TFAWS_366 | Resource | aws_alb | See to it that ALB shifts HTTP requests to HTTPS requests | checker/terraform/rules/aws/aws_lb_listener_alb_redirects_http_requests_into_https.rego |
| CB_TFAWS_366 | Resource | aws_alb_listener | See to it that ALB shifts HTTP requests to HTTPS requests | checker/terraform/rules/aws/aws_lb_listener_alb_redirects_http_requests_into_https.rego |
| CB_TFAWS_366 | Resource | aws_lb | See to it that ALB shifts HTTP requests to HTTPS requests | checker/terraform/rules/aws/aws_lb_listener_alb_redirects_http_requests_into_https.rego |
| CB_TFAWS_366 | Resource | aws_lb_listener | See to it that ALB shifts HTTP requests to HTTPS requests | checker/terraform/rules/aws/aws_lb_listener_alb_redirects_http_requests_into_https.rego |
| CB_TFAWS_367 | Resource | aws_elasticache_replication_group | Verify AWS ElastiCache Redis cluster with Multi-AZ Automatic Failover feature set to enabled | checker/terraform/rules/aws/verify_aws_elasticache_redis_configured_automatic_failover.rego |
| CB_TFAWS_368 | Resource | aws_api_gateway_stage | Verify AWS API Gateway endpoints uses client certificate authentication | checker/terraform/rules/aws/verify_aws_api_gateway_endpoints_uses_certificate_for_authentication.rego |
| CB_TFAWS_368 | Resource | aws_apigatewayv2_api | Verify AWS API Gateway endpoints uses client certificate authentication | checker/terraform/rules/aws/verify_aws_api_gateway_endpoints_uses_certificate_for_authentication.rego |
| CB_TFAWS_368 | Resource | aws_apigatewayv2_stage | Verify AWS API Gateway endpoints uses client certificate authentication | checker/terraform/rules/aws/verify_aws_api_gateway_endpoints_uses_certificate_for_authentication.rego |
package lib.terraform.CB_TFAWS_330

import rego.v1

test_aws_rds_cluster_rds_clusters_has_backup_plan_of_aws_backup_passed if {
	result := passed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_rds_cluster",
				"rds_cluster_good",
			],
			"Attributes": {
				"availability_zones": [
					"us-west-2a",
					"us-west-2b",
					"us-west-2c",
				],
				"cluster_identifier": "aurora-cluster-demo",
				"database_name": "mydb",
				"engine": "aurora-mysql",
				"engine_version": "5.7.mysql_aurora.2.03.2",
				"master_password": "bar",
				"master_username": "foo",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_backup_plan",
				"example",
			],
			"Attributes": {"name": "tf_example_backup_plan"},
			"Blocks": [{
				"Type": "rule",
				"Labels": [],
				"Attributes": {
					"rule_name": "tf_example_backup_rule",
					"schedule": "cron(0 12 * * ? *)",
					"target_vault_name": "vault-name",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 19,
					"startLine": 15,
				},
			}],
			"line_range": {
				"endLine": 20,
				"startLine": 12,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_backup_selection",
				"backup_good",
			],
			"Attributes": {
				"iam_role_arn": "arn:partition:service:region:account-id:resource-id",
				"name": "tf_example_backup_selection",
				"plan_id": "aws_backup_plan.example.id",
				"resources": ["aws_rds_cluster.rds_cluster_good.arn"],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 30,
				"startLine": 22,
			},
		},
	]
	count(result) == 1
}

test_aws_rds_cluster_rds_clusters_has_backup_plan_of_aws_backup_failed if {
	result := failed with input as [
		{
			"Type": "resource",
			"Labels": [
				"aws_rds_cluster",
				"rds_cluster_good",
			],
			"Attributes": {
				"availability_zones": [
					"us-west-2a",
					"us-west-2b",
					"us-west-2c",
				],
				"cluster_identifier": "aurora-cluster-demo",
				"database_name": "mydb",
				"engine": "aurora-mysql",
				"engine_version": "5.7.mysql_aurora.2.03.2",
				"master_password": "bar",
				"master_username": "foo",
			},
			"Blocks": [],
			"line_range": {
				"endLine": 9,
				"startLine": 1,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_backup_plan",
				"example",
			],
			"Attributes": {"name": "tf_example_backup_plan"},
			"Blocks": [{
				"Type": "rule",
				"Labels": [],
				"Attributes": {
					"rule_name": "tf_example_backup_rule",
					"schedule": "cron(0 12 * * ? *)",
					"target_vault_name": "vault-name",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 19,
					"startLine": 15,
				},
			}],
			"line_range": {
				"endLine": 20,
				"startLine": 12,
			},
		},
		{
			"Type": "resource",
			"Labels": [
				"aws_backup_selection",
				"backup_good",
			],
			"Attributes": {
				"iam_role_arn": "arn:partition:service:region:account-id:resource-id",
				"name": "tf_example_backup_selection",
				"plan_id": "aws_backup_plan.example.id",
				"resources": [""],
			},
			"Blocks": [],
			"line_range": {
				"endLine": 30,
				"startLine": 22,
			},
		},
	]
	count(result) == 1
}

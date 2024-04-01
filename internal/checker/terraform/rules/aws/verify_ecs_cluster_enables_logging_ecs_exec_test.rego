package lib.terraform.CB_TFAWS_214
import rego.v1

test_ecs_cluster_enable_logging_ecs_exec if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ecs_cluster",
			"pass2",
		],
		"Attributes": {
			"name": "white-hart",
			"tags": {"test": "fail"},
		},
		"Blocks": [{
			"Type": "configuration",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "execute_command_configuration",
				"Labels": [],
				"Attributes": {"logging": "DEFAULT"},
				"Blocks": [],
				"line_range": {
					"endLine": 7,
					"startLine": 4,
				},
			}],
			"line_range": {
				"endLine": 8,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_ecs_cluster_enable_logging_ecs_exec_not_set if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_ecs_cluster",
			"pass2",
		],
		"Attributes": {
			"name": "white-hart",
			"tags": {"test": "fail"},
		},
		"Blocks": [{
			"Type": "configuration",
			"Labels": [],
			"Attributes": {},
			"Blocks": [{
				"Type": "execute_command_configuration",
				"Labels": [],
				"Attributes": {"logging": "NONE"},
				"Blocks": [],
				"line_range": {
					"endLine": 7,
					"startLine": 4,
				},
			}],
			"line_range": {
				"endLine": 8,
				"startLine": 3,
			},
		}],
		"line_range": {
			"endLine": 10,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

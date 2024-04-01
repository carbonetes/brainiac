package lib.terraform.CB_TFAWS_295

import rego.v1 

test_elastic_beanstalk_env_health_reporting_enabled if {
	result := passed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_elastic_beanstalk_environment",
			"example",
		],
		"Attributes": {
			"application": "aws_elastic_beanstalk_application.example.name",
			"name": "example-environment",
			"solution_stack_name": "64bit Amazon Linux 2 v5.6.0 running PHP 7.4",
		},
		"Blocks": [
			{
				"Type": "setting",
				"Labels": [],
				"Attributes": {
					"name": "SystemType",
					"namespace": "aws:elasticbeanstalk:healthreporting:system",
					"value": "enhanced",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 6,
				},
			},
			{
				"Type": "setting",
				"Labels": [],
				"Attributes": {
					"name": "SystemTypePerformance",
					"namespace": "aws:elasticbeanstalk:healthreporting:system",
					"value": true,
				},
				"Blocks": [],
				"line_range": {
					"endLine": 16,
					"startLine": 12,
				},
			},
			{
				"Type": "setting",
				"Labels": [],
				"Attributes": {
					"name": "HealthStreamingEnabled",
					"namespace": "aws:elasticbeanstalk:healthreporting:system",
					"value": "true",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 22,
					"startLine": 18,
				},
			},
		],
		"line_range": {
			"endLine": 23,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

test_elastic_beanstalk_env_health_reporting_not_enabled if {
	result := failed with input as [{
		"Type": "resource",
		"Labels": [
			"aws_elastic_beanstalk_environment",
			"example",
		],
		"Attributes": {
			"application": "aws_elastic_beanstalk_application.example.name",
			"name": "example-environment",
			"solution_stack_name": "64bit Amazon Linux 2 v5.6.0 running PHP 7.4",
		},
		"Blocks": [
			{
				"Type": "setting",
				"Labels": [],
				"Attributes": {
					"name": "SystemType",
					"namespace": "aws:elasticbeanstalk:healthreporting:system",
					"value": "enhanced",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 10,
					"startLine": 6,
				},
			},
			{
				"Type": "setting",
				"Labels": [],
				"Attributes": {
					"name": "SystemTypePerformance",
					"namespace": "aws:elasticbeanstalk:healthreporting:system",
					"value": true,
				},
				"Blocks": [],
				"line_range": {
					"endLine": 16,
					"startLine": 12,
				},
			},
			{
				"Type": "setting",
				"Labels": [],
				"Attributes": {
					"name": "HealthStreamingEnabled",
					"namespace": "aws:elasticbeanstalk:healthreporting:system",
					"value": "false",
				},
				"Blocks": [],
				"line_range": {
					"endLine": 22,
					"startLine": 18,
				},
			},
		],
		"line_range": {
			"endLine": 23,
			"startLine": 1,
		},
	}]
	count(result) == 1
}

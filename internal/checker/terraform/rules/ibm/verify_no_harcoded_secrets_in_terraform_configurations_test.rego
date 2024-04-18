package lib.terraform.CB_TFIBM_007
import rego.v1

test_no_hard_coded_secrets_terraform_configuration_passed if {
	result := passed with input as [{
    "Type": "resource",
    "Labels": [
        "ibm_app",
        "app"
    ],
    "Attributes": {
        "app_path": "hello.zip",
        "app_version": "1.0",
        "buildpack": "sdk-for-nodejs",
        "command": "",
        "disk_quota": "1024",
        "environment_json": {
            "VAR1": "",
            "VAR2": ""
        },
        "health_check_http_endpoint": "/health",
        "health_check_timeout": "30",
        "health_check_type": "port",
        "instances": "1",
        "memory": "256",
        "name": "my-app",
        "route_guids": [
            "route_guid_1",
            "route_guid_2"
        ],
        "service_instance_guids": [
            "service_instance_guid_1",
            "service_instance_guid_2"
        ],
        "space_guid": "data.ibm_space.space.id",
        "tags": [
            "tag1",
            "tag2"
        ],
        "wait_time_minutes": "15",
        "wait_timeout_minutes": "90"
    },
    "Blocks": [],
    "line_range": {
        "endLine": 29,
        "startLine": 6
    }
}]

	count(result) == 1
}

test_no_hard_coded_secrets_terraform_configuration_failed if {
	result := failed with input as [{
    "Type": "resource",
    "Labels": [
        "ibm_app",
        "app"
    ],
    "Attributes": {
        "app_path": "hello.zip",
        "app_version": "1.0",
        "buildpack": "sdk-for-nodejs",
        "command": "node app.js",
        "disk_quota": "1024",
        "environment_json": {
            "VAR1": "value1",
            "VAR2": "value2"
        },
        "health_check_http_endpoint": "/health",
        "health_check_timeout": "30",
        "health_check_type": "port",
        "instances": "1",
        "memory": "256",
        "name": "my-app",
        "route_guids": [
            "route_guid_1",
            "route_guid_2"
        ],
        "service_instance_guids": [
            "service_instance_guid_1",
            "service_instance_guid_2"
        ],
        "space_guid": "data.ibm_space.space.id",
        "tags": [
            "tag1",
            "tag2"
        ],
        "wait_time_minutes": "15",
        "wait_timeout_minutes": "90"
    },
    "Blocks": [],
    "line_range": {
        "endLine": 29,
        "startLine": 6
    }
}]
	count(result) == 1
}

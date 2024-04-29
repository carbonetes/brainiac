package lib.terraform.CB_TFIBM_092
import rego.v1

test_environment_variables_reference_pass if {
	result := passed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_code_engine_app",
            "code_engine_app_instance"
        ],
        "Attributes": {
            "image_port": "8080",
            "image_reference": "icr.io/codeengine/helloworld",
            "image_secret": "your_image_secret_name",
            "managed_domain_mappings": "local_public",
            "name": "my-app",
            "project_id": "ibm_code_engine_project.code_engine_project_instance.project_id",
            "run_arguments": [
                "your",
                "run",
                "arguments",
                "here"
            ],
            "run_as_user": "1001",
            "run_commands": [
                "your",
                "run",
                "commands",
                "here"
            ],
            "run_service_account": "default",
            "scale_concurrency": "100",
            "scale_concurrency_target": "100",
            "scale_cpu_limit": "1",
            "scale_down_delay": "0",
            "scale_ephemeral_storage_limit": "400M",
            "scale_initial_instances": "1",
            "scale_max_instances": "10",
            "scale_memory_limit": "4G",
            "scale_min_instances": "0",
            "scale_request_timeout": "300"
        },
        "Blocks": [
            {
                "Type": "run_env_variables",
                "Labels": [],
                "Attributes": {
                    "key": "023bast1p-134as1hg-s13",
                    "name": "environment_variables_1",
                    "prefix": "_prefix_1",
                    "reference": "carbonetes.com",
                    "type": "literal",
                    "value": "value_1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 11
                }
            },
            {
                "Type": "run_volume_mounts",
                "Labels": [],
                "Attributes": {
                    "mount_path": "/path/to/mount",
                    "name": "optional_mount_name",
                    "reference": "terraform.com",
                    "type": "secret"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 27,
                    "startLine": 22
                }
            }
        ],
        "line_range": {
            "endLine": 42,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

test_environment_variables_reference_fail if {
	result := failed with input as [
    {
        "Type": "resource",
        "Labels": [
            "ibm_code_engine_app",
            "code_engine_app_instance"
        ],
        "Attributes": {
            "image_port": "8080",
            "image_reference": "icr.io/codeengine/helloworld",
            "image_secret": "your_image_secret_name",
            "managed_domain_mappings": "local_public",
            "name": "my-app",
            "project_id": "ibm_code_engine_project.code_engine_project_instance.project_id",
            "run_arguments": [
                "your",
                "run",
                "arguments",
                "here"
            ],
            "run_as_user": "1001",
            "run_commands": [
                "your",
                "run",
                "commands",
                "here"
            ],
            "run_service_account": "default",
            "scale_concurrency": "100",
            "scale_concurrency_target": "100",
            "scale_cpu_limit": "1",
            "scale_down_delay": "0",
            "scale_ephemeral_storage_limit": "400M",
            "scale_initial_instances": "1",
            "scale_max_instances": "10",
            "scale_memory_limit": "4G",
            "scale_min_instances": "0",
            "scale_request_timeout": "300"
        },
        "Blocks": [
            {
                "Type": "run_env_variables",
                "Labels": [],
                "Attributes": {
                    "key": "023b#ast1p-134as1h!g-s13",
                    "name": "",
                    "prefix": "!-prefix",
                    "reference": "-reference.-com",
                    "type": "literal",
                    "value": "value_1"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 18,
                    "startLine": 11
                }
            },
            {
                "Type": "run_volume_mounts",
                "Labels": [],
                "Attributes": {
                    "mount_path": "/path/to/mount",
                    "name": "optional_mount_name",
                    "reference": "",
                    "type": "secret"
                },
                "Blocks": [],
                "line_range": {
                    "endLine": 27,
                    "startLine": 22
                }
            }
        ],
        "line_range": {
            "endLine": 42,
            "startLine": 1
        }
    }
]
	count(result) == 1
}

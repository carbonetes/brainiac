package lib.terraform.CB_TFYC_003

test_kubernetes_cluster_role_binding_default_not_used_passed {
	result := passed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_kms_symmetric_key",
            "key-a"
        ],
        "Attributes": {
            "default_algorithm": "AES_128",
            "description": "description for key",
            "name": "example-symetric-key",
            "rotation_period": "8760h"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_storage_bucket",
            "test"
        ],
        "Attributes": {
            "bucket": "mybucket"
        },
        "Blocks": [
            {
                "Type": "server_side_encryption_configuration",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "rule",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [
                            {
                                "Type": "apply_server_side_encryption_by_default",
                                "Labels": [],
                                "Attributes": {
                                    "kms_master_key_id": "yandex_kms_symmetric_key.key-a.id",
                                    "sse_algorithm": "aws:kms"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 16,
                                    "startLine": 13
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 17,
                            "startLine": 12
                        }
                    }
                ],
                "line_range": {
                    "endLine": 18,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 8
        }
    }]
	count(result) == 1
}

test_kubernetes_cluster_role_binding_default_not_used_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_kms_symmetric_key",
            "key-a"
        ],
        "Attributes": {
            "default_algorithm": "AES_128",
            "description": "description for key",
            "name": "example-symetric-key",
            "rotation_period": "8760h"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "yandex_storage_bucket",
            "test"
        ],
        "Attributes": {
            "bucket": "mybucket"
        },
        "Blocks": [
            {
                "Type": "server_side_encryption_configuration",
                "Labels": [],
                "Attributes": {},
                "Blocks": [
                    {
                        "Type": "rule",
                        "Labels": [],
                        "Attributes": {},
                        "Blocks": [
                            {
                                "Type": "apply_server_side_encryption_by_default",
                                "Labels": [],
                                "Attributes": {
                                    "sse_algorithm": "aws:kms"
                                },
                                "Blocks": [],
                                "line_range": {
                                    "endLine": 16,
                                    "startLine": 13
                                }
                            }
                        ],
                        "line_range": {
                            "endLine": 17,
                            "startLine": 12
                        }
                    }
                ],
                "line_range": {
                    "endLine": 18,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 19,
            "startLine": 8
        }
    }]
	count(result) == 1
}
package lib.terraform.CB_TFYC_009

test_yandex_kms_symmetric_key_rotation_period_is_set_passed {
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
    }]
	count(result) == 1
}

test_yandex_kms_symmetric_key_rotation_period_is_set_failed {
	result := failed with input as [{
        "Type": "resource",
        "Labels": [
            "yandex_kms_symmetric_key",
            "key-a"
        ],
        "Attributes": {
            "default_algorithm": "AES_128",
            "description": "description for key",
            "name": "example-symetric-key"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 6,
            "startLine": 1
        }
    }]
	count(result) == 1
}
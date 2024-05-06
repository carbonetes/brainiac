package lib.terraform.CB_TFAWS_145
import rego.v1

test_verifiy_redshift_cluster_kms_key_passed if {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_redshift_cluster",
                                    "example_cluster"
                                    ],
                                    "Attributes": {
                                    "kms_key_id": "arn:aws:kms:us-west-2:123456789012:key/abcd1234-5678-90ab-cdef-1234567890ab"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 3,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}

test_verifiy_redshift_cluster_kms_key_failed if {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_redshift_cluster",
                                    "example_cluster"
                                    ],
                                    "Attributes": {
                                    "tc": "arn:aws:kms:us-west-2:123456789012:key/abcd1234-5678-90ab-cdef-1234567890ab"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 3,
                                    "startLine": 1
                                    }
                                    }
                                    ]
    count(result) == 1
}
package lib.terraform.CB_TFAWS_308

import rego.v1 

test_verify_redshift_cluster_database_name_passed if {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_redshift_cluster",
                "example_cluster"
            ],
            "Attributes": {
                "database_name": "my_custom_database_name"
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

test_verify_redshift_cluster_database_name_failed if {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_redshift_cluster",
                "example_cluster"
            ],
            "Attributes": {
                "database_name": ""
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
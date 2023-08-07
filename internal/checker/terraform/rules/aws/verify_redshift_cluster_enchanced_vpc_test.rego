package lib.terraform.CB_TFAWS_309

test_verify_redshift_cluster_enchanced_vpc_passed {
    result := passed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_redshift_cluster",
                "example_cluster"
            ],
            "Attributes": {
                "enhanced_vpc_routing": true
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

test_verify_redshift_cluster_enchanced_vpc_failed {
    result := failed with input as [
        {
            "Type": "resource",
            "Labels": [
                "aws_redshift_cluster",
                "example_cluster"
            ],
            "Attributes": {
                "enhanced_vpc_routing": false
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
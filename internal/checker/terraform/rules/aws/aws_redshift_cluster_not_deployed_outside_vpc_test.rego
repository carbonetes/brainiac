package lib.terraform.CB_TFAWS_139

test_aws_redshift_cluster_not_deployed_outside_vpc_passed {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_redshift_cluster",
                                "pass"
                                ],
                                "Attributes": {
                                "cluster_subnet_group_name": "subnet-ebd9cead"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 4,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 1
}

test_aws_redshift_cluster_not_deployed_outside_vpc_failed {
result := failed with input as [
                               {
                                "Type": "resource",
                                "Labels": [
                                "aws_redshift_cluster",
                                "pass"
                                ],
                                "Attributes": {
                                "cluster_subnet_group_name": ""
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 4,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 1
}
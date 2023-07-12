package lib.terraform.CB_TFAWS_198

test_aws_db_instance_minor_upgrade_passed {
    result := passed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_db_instance",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "auto_minor_version_upgrade": true
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

test_aws_db_instance_minor_upgrade_failed {
    result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_db_instance",
                                    "example"
                                    ],
                                    "Attributes": {
                                    "auto_minor_version_upgrade": false
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
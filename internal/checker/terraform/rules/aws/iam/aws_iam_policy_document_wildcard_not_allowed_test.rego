package lib.terraform.CB_TFAWS_042

test_AWSIAM_no_wild_card{
    result := passed with input as [
        {
            "Type": "data",
            "Labels": [
                "aws_iam_policy_document",
                "example"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "statement",
                    "Labels": [],
                    "Attributes": {
                        "actions": [
                            "s3:ListAllMyBuckets",
                            "s3:GetBucketLocation"
                        ],
                        "effect": "Allow",
                        "resources": [
                            "arn:aws:s3:::*",
                            "*"
                        ],
                        "sid": "1"
                    },
                    "Blocks": []
                }
            ]
        }
    ]
    count(result) == 1
}

test_AWSIAM_have_wild_card {
    result := failed with input as [
        {
            "Type": "data",
            "Labels": [
                "aws_iam_policy_document",
                "example"
            ],
            "Attributes": {},
            "Blocks": [
                {
                    "Type": "statement",
                    "Labels": [],
                    "Attributes": {
                        "actions": [
                            "s3:ListAllMyBuckets",
                            "s3:GetBucketLocation",
                            "*"
                        ],
                        "effect": "Allow",
                        "resources": [
                            "arn:aws:s3:::*",
                            "*"
                        ],
                        "sid": "1"
                    },
                    "Blocks": []
                }
            ]
        }
    ]
    count(result) == 1
}
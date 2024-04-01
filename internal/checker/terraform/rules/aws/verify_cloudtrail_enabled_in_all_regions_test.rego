package lib.terraform.CB_TFAWS_067
import rego.v1

test_cloudtrail_enabeld_is_set if {
    result := passed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_cloudtrail",
                            "foobar"
                            ],
                            "Attributes": {
                            "include_global_service_events": false,
                            "is_multi_region_trail": true,
                            "name": "tf-trail-foobar",
                            "s3_bucket_name": "aws_s3_bucket.foo.id",
                            "s3_key_prefix": "prefix"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 7,
                            "startLine": 1
                            }
                        }
                    ]
    count(result) == 1
}

test_cloudwatch_log_group_no_retention if {
    result := failed with input as [
                            {
                            "Type": "resource",
                            "Labels": [
                            "aws_cloudtrail",
                            "foobar"
                            ],
                            "Attributes": {
                            "include_global_service_events": false,
                            "is_multi_region_trail": false,
                            "name": "tf-trail-foobar",
                            "s3_bucket_name": "aws_s3_bucket.foo.id",
                            "s3_key_prefix": "prefix"
                            },
                            "Blocks": [],
                            "line_range": {
                            "endLine": 7,
                            "startLine": 1
                            }
                        }
                    ]
    count(result) == 1
}
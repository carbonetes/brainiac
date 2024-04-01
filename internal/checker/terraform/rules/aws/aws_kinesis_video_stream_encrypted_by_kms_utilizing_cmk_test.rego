package lib.terraform.CB_TFAWS_168
import rego.v1

test_aws_kinesis_video_stream_encrypted_by_kms_utilizing_cmk_passed if {
    result := passed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_kinesis_video_stream",
                        "default"
                        ],
                        "Attributes": {
                        "data_retention_in_hours": "1",
                        "device_name": "kinesis-video-device-name",
                        "kms_key_id": "kms",
                        "media_type": "video/h264",
                        "name": "terraform-kinesis-video-stream",
                        "tags": {
                            "Name": "terraform-kinesis-video-stream"
                        }
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 10,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}

test_aws_kinesis_video_stream_encrypted_by_kms_utilizing_cmk_failed if {
    result := failed with input as [
                        {
                        "Type": "resource",
                        "Labels": [
                        "aws_kinesis_video_stream",
                        "default"
                        ],
                        "Attributes": {
                        "data_retention_in_hours": "1",
                        "device_name": "kinesis-video-device-name",
                        "kms_key_id": "",
                        "media_type": "video/h264",
                        "name": "terraform-kinesis-video-stream",
                        "tags": {
                            "Name": "terraform-kinesis-video-stream"
                        }
                        },
                        "Blocks": [],
                        "line_range": {
                        "endLine": 10,
                        "startLine": 1
                        }
                        }
                        ]
    count(result) == 1
}
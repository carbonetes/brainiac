package lib.terraform.CB_TFALI_012

test_alicloud_oss_bucket_cmk_encrypted_passed {
	result := passed with input as [{
  "Type": "resource",
  "Labels": [
   "alicloud_oss_bucket",
   "pass"
  ],
  "Attributes": {
   "acl": "private",
   "bucket": "bucket-123"
  },
  "Blocks": [
   {
    "Type": "server_side_encryption_rule",
    "Labels": [],
    "Attributes": {
     "kms_master_key_id": "your kms key id",
     "sse_algorithm": "KMS"
    },
    "Blocks": [],
    "line_range": {
     "endLine": 8,
     "startLine": 5
    }
   }
  ],
  "line_range": {
   "endLine": 9,
   "startLine": 1
  }
 }]
	count(result) == 1
}

test_alicloud_oss_bucket_cmk_encrypted_failed {
	result := failed with input as [{
  "Type": "resource",
  "Labels": [
   "alicloud_oss_bucket",
   "pass"
  ],
  "Attributes": {
   "acl": "private",
   "bucket": "bucket-123"
  },
  "Blocks": [
   {
    "Type": "server_side_encryption_rule",
    "Labels": [],
    "Attributes": {
     "kms_master_key_id": "",
     "sse_algorithm": "KMS"
    },
    "Blocks": [],
    "line_range": {
     "endLine": 8,
     "startLine": 5
    }
   }
  ],
  "line_range": {
   "endLine": 9,
   "startLine": 1
  }
 }]
	count(result) == 1
}

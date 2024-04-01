package lib.terraform.CB_TFAWS_260

import rego.v1

test_keyspaces_table_uses_cmk if {
	result := passed with input as [
 {
  "Type": "resource",
  "Labels": [
   "aws_keyspaces_table",
   "pass"
  ],
  "Attributes": {
   "keyspace_name": "aws_keyspaces_keyspace.example.name"
  },
  "Blocks": [
   {
    "Type": "encryption_specification",
    "Labels": [],
    "Attributes": {
     "kms_key_identifier": "aws_kms_key.example.arn",
     "type": "CUSTOMER_MANAGED_KEY"
    },
    "Blocks": [],
    "line_range": {
     "endLine": 6,
     "startLine": 3
    }
   }
  ],
  "line_range": {
   "endLine": 7,
   "startLine": 1
  }
 }
]
	count(result) == 1
}

test_keyspaces_table_not_uses_cmk if {
	result := failed with input as [
 {
  "Type": "resource",
  "Labels": [
   "aws_keyspaces_table",
   "pass"
  ],
  "Attributes": {
   "keyspace_name": "aws_keyspaces_keyspace.example.name"
  },
  "Blocks": [
   {
    "Type": "encryption_specification",
    "Labels": [],
    "Attributes": {
     "kms_key_identifier": "aws_kms_key.example.arn",
     "type": "AWS_OWNED_KMS_KEY"
    },
    "Blocks": [],
    "line_range": {
     "endLine": 6,
     "startLine": 3
    }
   }
  ],
  "line_range": {
   "endLine": 7,
   "startLine": 1
  }
 }
]
	count(result) == 1
}

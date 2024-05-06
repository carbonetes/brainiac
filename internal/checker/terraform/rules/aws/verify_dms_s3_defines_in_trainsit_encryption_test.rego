package lib.terraform.CB_TFAWS_264

import rego.v1 

test_dms_s3_defines_in_transit_encryption if {
	result := passed with input as [
 {
  "Type": "resource",
  "Labels": [
   "aws_dms_s3_endpoint",
   "example"
  ],
  "Attributes": {
   "ssl_mode": "require"
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

test_dms_s3_not_defines_in_transit_encryption if {
	result := failed with input as [
 {
  "Type": "resource",
  "Labels": [
   "aws_dms_s3_endpoint",
   "example"
  ],
  "Attributes": {
   "ssl_mode": "none"
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

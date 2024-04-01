package lib.terraform.CB_TFAWS_273

import rego.v1 

test_aws_db_instance_database_instances_deletion_protection_enabled_passed if {
	result := passed with input as [{
  "Type": "resource",
  "Labels": [
   "aws_db_instance",
   "example"
  ],
  "Attributes": {
   "deletion_protection": true,
   "engine": "mysql",
   "engine_version": "5.7",
   "identifier": "example-instance",
   "instance_class": "db.t2.micro"
  },
  "Blocks": [],
  "line_range": {
   "endLine": 7,
   "startLine": 1
  }
 }]
	count(result) == 1
}

test_aws_db_instance_database_instances_deletion_protection_enabled_failed if {
	result := failed with input as [{
  "Type": "resource",
  "Labels": [
   "aws_db_instance",
   "example"
  ],
  "Attributes": {
   "deletion_protection": false,
   "engine": "mysql",
   "engine_version": "5.7",
   "identifier": "example-instance",
   "instance_class": "db.t2.micro"
  },
  "Blocks": [],
  "line_range": {
   "endLine": 7,
   "startLine": 1
  }
 }]
	count(result) == 1
}

package lib.terraform.CB_TFAWS_267

import rego.v1 

test_aws_sfn_state_machine_state_machine_xray_tracing_enabled_passed if {
	result := passed with input as [{
  "Type": "resource",
  "Labels": [
   "aws_sfn_state_machine",
   "example"
  ],
  "Attributes": {
   "name": "my-state-machine"
  },
  "Blocks": [
   {
    "Type": "tracing_configuration",
    "Labels": [],
    "Attributes": {
     "enabled": true
    },
    "Blocks": [],
    "line_range": {
     "endLine": 7,
     "startLine": 5
    }
   }
  ],
  "line_range": {
   "endLine": 8,
   "startLine": 1
  }
 }]
	count(result) == 1
}

test_aws_sfn_state_machine_state_machine_xray_tracing_enabled_failed if {
	result := failed with input as [{
  "Type": "resource",
  "Labels": [
   "aws_sfn_state_machine",
   "example"
  ],
  "Attributes": {
   "name": "my-state-machine"
  },
  "Blocks": [
   {
    "Type": "tracing_configuration",
    "Labels": [],
    "Attributes": {
     "enablsed": false
    },
    "Blocks": [],
    "line_range": {
     "endLine": 7,
     "startLine": 5
    }
   }
  ],
  "line_range": {
   "endLine": 8,
   "startLine": 1
  }
 }]
	count(result) == 1
}

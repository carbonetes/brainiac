package lib.terraform.CB_TFAWS_268

import rego.v1 

test_aws_sfn_state_machine_state_machine_execution_history_logging_enabled_passed if {
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
    "Type": "logging_configuration",
    "Labels": [],
    "Attributes": {
     "include_execution_data": true,
     "level": "ERROR"
    },
    "Blocks": [],
    "line_range": {
     "endLine": 7,
     "startLine": 4
    }
   }
  ],
  "line_range": {
   "endLine": 10,
   "startLine": 1
  }
 }]
	count(result) == 1
}

test_aws_sfn_state_machine_state_machine_execution_history_logging_enabled_failed if {
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
    "Type": "logging_configuration",
    "Labels": [],
    "Attributes": {
     "include_execution_data": false,
     "level": "ERROR"
    },
    "Blocks": [],
    "line_range": {
     "endLine": 7,
     "startLine": 4
    }
   }
  ],
  "line_range": {
   "endLine": 10,
   "startLine": 1
  }
 }]
	count(result) == 1
}

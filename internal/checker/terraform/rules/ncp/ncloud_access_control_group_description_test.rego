package lib.terraform.CB_TFNCP_002

test_ncloud_access_control_group_description_passed {
	result := passed with input as [{
  "Type": "resource",
  "Labels": [
   "ncloud_access_control_group",
   "example_group"
  ],
  "Attributes": {
   "description": "Access Control Group Description",
   "name": "example-group"
  },
  "Blocks": [],
  "line_range": {
   "endLine": 4,
   "startLine": 1
  }
 }]
	count(result) == 1
}

test_ncloud_access_control_group_description_failed {
	result := failed with input as [{
  "Type": "resource",
  "Labels": [
   "ncloud_access_control_group",
   "example_group"
  ],
  "Attributes": {
   "name": "example-group"
  },
  "Blocks": [],
  "line_range": {
   "endLine": 4,
   "startLine": 1
  }
 }]
	count(result) == 1
}

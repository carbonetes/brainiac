package lib.terraform.CB_TFNCP_012

test_ncloud_network_acl_rule_all_ports_restricted_passed {
	result := passed with input as [{
  "Type": "resource",
  "Labels": [
   "ncloud_network_acl_rule",
   "example"
  ],
  "Attributes": {
   "action": "allow",
   "network_acl_id": "ncloud_network_acl.example.id",
   "type": "inbound"
  },
  "Blocks": [
   {
    "Type": "inbound",
    "Labels": [],
    "Attributes": {
     "port_range": [
      "80-90"
     ]
    },
    "Blocks": [],
    "line_range": {
     "endLine": 7,
     "startLine": 5
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

test_ncloud_network_acl_rule_all_ports_restricted_failed {
	result := failed with input as [{
  "Type": "resource",
  "Labels": [
   "ncloud_network_acl_rule",
   "example"
  ],
  "Attributes": {
   "action": "allow",
   "network_acl_id": "ncloud_network_acl.example.id",
   "type": "inbound"
  },
  "Blocks": [
   {
    "Type": "inbound",
    "Labels": [],
    "Attributes": {
     "port_range": [
      "1-65535"
     ]
    },
    "Blocks": [],
    "line_range": {
     "endLine": 7,
     "startLine": 5
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

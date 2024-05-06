package lib.terraform.CB_TFAWS_218
import rego.v1

test_verify_network_acl_unrestricted_ingress_20_passed if {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_network_acl_rule",
									"example"
									],
									"Attributes": {
									"cidr_block": "0.0.0.0/0",
									"egress": false,
									"from_port": "20",
									"network_acl_id": "aws_network_acl.example.id",
									"protocol": "tcp",
									"rule_number": "100",
									"to_port": "20"
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

test_verify_network_acl_unrestricted_ingress_21_failed if {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"aws_network_acl_rule",
									"example"
									],
									"Attributes": {
									"cidr_block": "0.0.0.0/0",
									"egress": false,
									"from_port": "20",
									"network_acl_id": "aws_network_acl.example.id",
									"protocol": "tcp",
									"rule_action": "allow",
									"rule_number": "100",
									"to_port": "20"
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

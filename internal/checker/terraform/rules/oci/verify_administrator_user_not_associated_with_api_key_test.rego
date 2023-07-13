package lib.terraform.CB_TFOCI_023

test_verify_administrator_user_not_associated_with_api_key_passed {
	result := passed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_identity_user",
									"user1"
									],
									"Attributes": {
									"compartment_id": "var.tenancy_ocid",
									"defined_tags": {
										"Operations.CostCenter": "42"
									},
									"description": "var.user_description",
									"email": "var.user_email",
									"freeform_tags": {
										"Department": "Finance"
									},
									"name": "user1"
									},
									"Blocks": [],
									"line_range": {
									"endLine": 11,
									"startLine": 1
									}
									},
									{
									"Type": "resource",
									"Labels": [
									"oci_identity_group",
									"admin_group"
									],
									"Attributes": {
									"compartment_id": "var.tenancy_ocid",
									"defined_tags": {
										"Operations.CostCenter": "42"
									},
									"description": "var.group_description",
									"freeform_tags": {
										"Department": "Finance"
									},
									"name": "Administrators"
									},
									"Blocks": [],
									"line_range": {
									"endLine": 22,
									"startLine": 13
									}
									},
									{
									"Type": "resource",
									"Labels": [
									"oci_identity_api_key",
									"user1_api_key"
									],
									"Attributes": {
									"key_value": "var.api_key_key_value",
									"user_id": "oci_identity_user.user1.id"
									},
									"Blocks": [],
									"line_range": {
									"endLine": 28,
									"startLine": 24
									}
									},
									{
									"Type": "resource",
									"Labels": [
									"oci_identity_user_group_membership",
									"user1_in_admin_group"
									],
									"Attributes": {
									"group_id": "oci_identity_group.admin_group.id",
									"user_id": "oci_identity_user.user2.id"
									},
									"Blocks": [],
									"line_range": {
									"endLine": 34,
									"startLine": 30
									}
									}
									]
	count(result) == 1
}

test_verify_administrator_user_not_associated_with_api_key_failed {
	result := failed with input as [
									{
									"Type": "resource",
									"Labels": [
									"oci_identity_user",
									"user1"
									],
									"Attributes": {
									"compartment_id": "var.tenancy_ocid",
									"defined_tags": {
										"Operations.CostCenter": "42"
									},
									"description": "var.user_description",
									"email": "var.user_email",
									"freeform_tags": {
										"Department": "Finance"
									},
									"name": "user1"
									},
									"Blocks": [],
									"line_range": {
									"endLine": 11,
									"startLine": 1
									}
									},
									{
									"Type": "resource",
									"Labels": [
									"oci_identity_group",
									"admin_group"
									],
									"Attributes": {
									"compartment_id": "var.tenancy_ocid",
									"defined_tags": {
										"Operations.CostCenter": "42"
									},
									"description": "var.group_description",
									"freeform_tags": {
										"Department": "Finance"
									},
									"name": "Administrators"
									},
									"Blocks": [],
									"line_range": {
									"endLine": 22,
									"startLine": 13
									}
									},
									{
									"Type": "resource",
									"Labels": [
									"oci_identity_api_key",
									"user1_api_key"
									],
									"Attributes": {
									"key_value": "var.api_key_key_value",
									"user_id": "oci_identity_user.user1.id"
									},
									"Blocks": [],
									"line_range": {
									"endLine": 28,
									"startLine": 24
									}
									},
									{
									"Type": "resource",
									"Labels": [
									"oci_identity_user_group_membership",
									"user1_in_admin_group"
									],
									"Attributes": {
									"group_id": "oci_identity_group.admin_group.id",
									"user_id": "oci_identity_user.user1.id"
									},
									"Blocks": [],
									"line_range": {
									"endLine": 34,
									"startLine": 30
									}
									}
									]
	count(result) == 1
}

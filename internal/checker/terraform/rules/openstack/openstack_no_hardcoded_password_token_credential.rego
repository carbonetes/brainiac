# METADATA
# title: "Verify that there are no static OpenStack credentials, such as passwords, tokens, or application_credential_secrets, present in the provider configuration"
# description: "Confirm that no static OpenStack credentials, including passwords, tokens, or application_credential_secrets, are hardcoded in the provider configuration. It helps prevent security risks associated with exposing sensitive credentials in plain text within Terraform configurations."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/terraform-provider-openstack/openstack/latest/docs
# custom:
#   id: CB_TFOPENSTACK_001
#   severity: HIGH
package lib.terraform.CB_TFOPENSTACK_001

import future.keywords.in

isvalid(block) {
	block.Type == "provider"
	"openstack" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

label_for_password[label] {
	some block in input
	block.Type == "variable"
	"openstack_password" in block.Labels
	label := concat(".", block.Labels)
}

label_for_token[label] {
	some block in input
	block.Type == "variable"
	"openstack_token" in block.Labels
	label := concat(".", block.Labels)
}

label_for_credential[label] {
	some block in input
	block.Type == "variable"
	"openstack_application_credential_secret" in block.Labels
	label := concat(".", block.Labels)
}

password_token_credential_connected {
	some block in input
	block.Type == "provider"
	"openstack" in block.Labels
	some label_pass in label_for_password
	contains(block.Attributes.password, label_pass)
	some label_token in label_for_token
	contains(block.Attributes.token, label_token)
	some label_credential in label_for_credential
	contains(block.Attributes.application_credential_secret, label_credential)
}

fail[block] {
	some block in input
	isvalid(block)
	not password_token_credential_connected
}

pass[block] {
	some block in input
	isvalid(block)
	not fail[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "There are no static OpenStack credentials such as passwords, tokens, or application_credential_secrets.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "There must be no static OpenStack credentials such as passwords, tokens, or application_credential_secrets.",
		"snippet": block,
	}
}

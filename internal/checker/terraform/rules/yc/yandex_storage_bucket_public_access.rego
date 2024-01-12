# METADATA
# title: "Restrict Public Access Permissions for Storage Bucket"
# description: "This policy ensures that a storage bucket does not have public access permissions. Publicly accessible buckets can pose security risks, exposing sensitive data to unauthorized users."
# related_resources:
# - https://registry.terraform.io/providers/webbankir/yandex/latest/docs/resources/storage_bucket
# custom:
#   id: CB_TFYC_017
#   severity: HIGH
package lib.terraform.CB_TFYC_017

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"yandex_storage_bucket" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

fail[resource] {
	some resource in input
	isvalid(resource)
	invalid_value := ["public-read", "public-read-write"]
	resource.Attributes.acl in invalid_value
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "grant"
	block.Attributes.uri == "http://acs.amazonaws.com/groups/global/AllUsers"
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "The storage bucket is configured with restricted access permissions, enhancing security by preventing public access.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Public access permissions are detected on the storage bucket. It is recommended to update the bucket settings to restrict public access for improved security.",
		"snippet": block,
	}
}

# METADATA
# title: "Verify API Gateway API Uses HTTPS Protocol"
# description: "This policy ensures that pgAudit is enabled for your Google Cloud Platform (GCP) PostgreSQL database. Enabling pgAudit enhances security by providing detailed auditing and monitoring capabilities."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/api_gateway_api
# custom:
#   id: CB_TFALI_005
#   severity: LOW
package lib.terraform.CB_TFALI_005

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_api_gateway_api" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[resource] {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

fail[resource] {
	some resource in input
	isvalid(resource)
	some block in resource.Blocks
	block.Type == "request_config"
	block.Attributes.protocol != "HTTPS"
}

passed[result] {
	some block in pass
	result := {
		"message": "The API Gateway API is configured to use the HTTPS protocol, ensuring secure data transmission.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The API Gateway API does not use the HTTPS protocol. Update the API configuration to use HTTPS for enhanced security in data transmission.",
		"snippet": block,
	}
}

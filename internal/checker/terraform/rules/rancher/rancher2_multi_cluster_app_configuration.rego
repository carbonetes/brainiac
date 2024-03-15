# METADATA
# title: "Verify Rancher2 Multi Cluster App Configuration"
# description: "This policy ensures that the Rancher2 Multi Cluster App configuration is properly set up and compliant with defined standards."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/rancher/rancher2/latest/docs/resources/multi_cluster_app
# custom:
#   id: CB_TFRAN_086
#   severity: MEDIUM
package lib.terraform.CB_TFRAN_086

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"rancher2_multi_cluster_app" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
	some block in input
	isvalid(block)
	block.Attributes.catalog_name != ""
	block.Attributes.name != ""
	count(block.Attributes.roles) != 0
    block.Attributes.template_name != ""
}

fail[block] {
	some block in input
	isvalid(block)
	not pass[block]
}

passed[result] {
	some block in pass
	result := {
		"message": "Successful validation confirms compliance of the Rancher2 Multi Cluster App configuration with specified standards and parameters.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "The Rancher2 Multi Cluster App configuration failed validation. Please review and update settings to ensure compliance with specified standards and parameters.",
		"snippet": block,
	}
}

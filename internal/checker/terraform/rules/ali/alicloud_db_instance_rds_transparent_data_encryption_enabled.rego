# METADATA
# title: "Verify Transparent Data Encryption is Enabled on Instances"
# description: "This policy ensures that Transparent Data Encryption (TDE) is enabled on instances. TDE helps protect sensitive data stored in databases by encrypting the entire database, including backups."
# related_resources:
# - https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/db_instance
# custom:
#   id: CB_TFALI_006
#   severity: LOW
package lib.terraform.CB_TFALI_006

import future.keywords.in

isvalid(block) {
	block.Type == "resource"
	"alicloud_db_instance" in block.Labels
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
	some engine in ["MySQL", "SQLServer"]
	engine == resource.Attributes.engine
	some engine_version in ["5.6", "5.7", "8", "8.0", "08r2_ent_ha", "2012_ent_ha", "2016_ent_ha", "2017_ent", "2019_std_ha", "2019_ent"]
	engine_version == resource.Attributes.engine_version
	resource.Attributes.tde_status == "Enabled"
}

fail[resource] {
	some resource in input
	isvalid(resource)
	not pass[resource]
}

passed[result] {
	some block in pass
	result := {
		"message": "Transparent Data Encryption is enabled on the instances, providing enhanced security for stored data.",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "Transparent Data Encryption is not enabled on the instances. Enable TDE to enhance the security of stored data in databases.",
		"snippet": block,
	}
}
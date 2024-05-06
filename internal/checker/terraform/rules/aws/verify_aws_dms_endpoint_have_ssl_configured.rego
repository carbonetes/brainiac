# METADATA
# title: "Verify AWS Database Migration Service endpoints have SSL configured"
# description: "This policy ensures the secure and encrypted communication of Amazon Web Services (AWS) Database Migration Service (DMS) endpoints by verifying the proper configuration of SSL (Secure Sockets Layer)."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_endpoint.html
# custom:
#   id: CB_TFAWS_364
#   severity: HIGH
package lib.terraform.CB_TFAWS_364

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	label == "aws_dms_endpoint"
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

isEngineValidForTypeSource(resource) if {
	valid_engines := ["s3", "azuredb"]
	resource.Attributes.engine_name in valid_engines
}

isEngineValidForTypeSource(resource) if {
	resource.Attributes.ssl_mode != "none"
}

isEngineValidForTypeTarget(resource) if {
	valid_engines := ["dynamodb", "kinesis", "neptune", "redshift", "s3", "elasticsearch", "kafka"]
	resource.Attributes.engine_name in valid_engines
}

isEngineValidForTypeTarget(resource) if {
	resource.Attributes.ssl_mode != "none"
}

pass contains block if {
	some block in input
	isvalid(block)
	block.Attributes.endpoint_type == "source"
	isEngineValidForTypeSource(block)
}

pass contains block if {
	some block in input
	isvalid(block)
	block.Attributes.endpoint_type == "target"
	isEngineValidForTypeTarget(block)
}

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "AWS Database Migration Service endpoints have SSL configured.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "AWS Database Migration Service endpoints must have SSL configured.",
		"snippet": block,
	}
}

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

isvalid(block) {
	block.Type == "resource"
	block.Labels[_] == "aws_dms_endpoint"
}

resource[resource] {
	block := pass[_]
	resource := concat(".", block.Labels)
}

resource[resource] {
	block := fail[_]
	resource := concat(".", block.Labels)
}

isEngineValidForTypeSource {
	resource := input[_]
	resource.Type == "resource"
	validEngine := ["s3", "azuredb"]
	resource.Attributes.engine_name == validEngine[_]
	resource.Attributes.ssl_mode != "none"
}

isEngineValidForTypeTarget {
	resource := input[_]
	resource.Type == "resource"
	validEngine := ["dynamodb", "kinesis", "neptune", "redshift", "s3", "elasticsearch", "kafka"]
	resource.Attributes.engine_name == validEngine[_]
	resource.Attributes.ssl_mode != "none"
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.endpoint_type == "source"
	isEngineValidForTypeSource
}

pass[block] {
	block := input[_]
	isvalid(block)
	block.Attributes.endpoint_type == "target"
	isEngineValidForTypeTarget
}

fail[block] {
	block := input[_]
	isvalid(block)
	not pass[block]
}

passed[result] {
	block := pass[_]
	result := {
		"message": "AWS Database Migration Service endpoints have SSL configured.",
		"snippet": block,
	}
}

failed[result] {
	block := fail[_]
	result := {
		"message": "AWS Database Migration Service endpoints must have SSL configured.",
		"snippet": block,
	}
}

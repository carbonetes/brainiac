# METADATA
# title: "Verify DMS S3 defines in-transit encryption"
# description: "By enforcing in-transit encryption, data is protected against unauthorized access and potential eavesdropping during transit."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dms_s3_endpoint#ssl_mode
# custom:
#   id: CB_TFAWS_264
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_264

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_dms_s3_endpoint"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.ssl_mode != "none"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "DMS S3 defines in-transit encryption.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "DMS S3 must define in-transit encryption.",
                "snippet": block }
} 
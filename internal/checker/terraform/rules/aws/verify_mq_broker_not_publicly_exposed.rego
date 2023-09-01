# METADATA
# title: "Verify MQ Broker is not publicly exposed"
# description: "By configuring the MQ broker to not be publicly accessible, you can prevent unauthorized access and potential attacks on your messaging system."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/mq_broker
# custom:
#   id: CB_TFAWS_075
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_075


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_mq_broker"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.publicly_accessible == true
}

pass[block] {
    block := input[_]
	isvalid(block)
   	not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_mq_broker' 'publicly_accessible' is enabled.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_mq_broker' 'publicly_accessible' should be enabled.",
                "snippet": block }
} 
# METADATA
# title: "Verify that Redshift cluster should not be publicly accessible"
# description: "By keeping the Redshift cluster not publicly accessible enhances security by limiting access to authorized users and preventing potential unauthorized access or attacks from the internet."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster#publicly_accessible
# custom:
#   id: CB_TFAWS_094
#   severity: LOW
package lib.terraform.CB_TFAWS_094

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_redshift_cluster"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
	resource := input[_]
    isvalid(resource)
    has_attribute(resource.Attributes, "publicly_accessible")
    resource.Attributes.publicly_accessible == false
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_redshift_cluster' for 'publicly_accessible' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_redshift_cluster' for 'publicly_accessible' should be set.",
                "snippet": block }
} 
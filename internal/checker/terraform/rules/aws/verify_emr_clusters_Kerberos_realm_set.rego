# METADATA
# title: "Verify that EMR clusters with Kerberos have Kerberos Realm set"
# description: "By enforcing the requirement for the Kerberos Realm to be set, unauthorized access is mitigated, and only authenticated and authorized users can access the cluster resources."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/emr_cluster
# custom:
#   id: CB_TFAWS_103
#   severity: LOW
package lib.terraform.CB_TFAWS_103

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_emr_cluster"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) {
  _ = key[value]
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Blocks[_].Type == "kerberos_attributes"
    has_attribute(resource.Blocks[_].Attributes, "realm")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_emr_cluster' 'kerberos_attributes' realm is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_emr_cluster' 'kerberos_attributes' realm should be set.",
                "snippet": block }
} 
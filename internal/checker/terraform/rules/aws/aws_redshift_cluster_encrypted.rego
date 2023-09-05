# METADATA
# title: "Guarantee that the data stored within the Redshift cluster is adequately encrypted when it is at rest"
# description: "It is advised to encrypt all data stored within the Redshift cluster to ensure its security while at rest."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster
# custom:
#   id: CB_TFAWS_062
#   severity: HIGH
package lib.terraform.CB_TFAWS_062

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_redshift_cluster"
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.encrypted == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Data that is saved within the Redshift cluster is encrypted.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "Data that is saved within the Redshift cluster should be encrypted.",
                "snippet": block }
}

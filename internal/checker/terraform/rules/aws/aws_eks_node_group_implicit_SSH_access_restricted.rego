# METADATA
# title: "Make certain that 0.0.0.0/0 does not automatically have SSH access to the AWS EKS node group"
# description: "Maintaining a robust security posture involves ensuring that your AWS EKS node group does not allow unrestricted SSH access from 0.0.0.0/0. By implementing this measure, you minimize the risk of unauthorized SSH connections originating from the internet, enhancing the overall security of your environment."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group
# custom:
#   id: CB_TFAWS_112
#   severity: HIGH
package lib.terraform.CB_TFAWS_112

import future.keywords.in 



isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_eks_node_group"
}

has_attribute(key, value){
    _ = key[value]
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
    remoteAccess := resource.Blocks[_]
    remoteAccess.Type == "remote_access"
    has_attribute(remoteAccess.Attributes, "source_security_group_ids")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "AWS EKS node group does not allow unrestricted SSH access from 0.0.0.0/0.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "AWS EKS node group should not allow unrestricted SSH access from 0.0.0.0/0.",
                "snippet": block }
}

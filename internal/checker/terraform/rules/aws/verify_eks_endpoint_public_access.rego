# METADATA
# title: "Verify that Amazon EKS cluster endpoint public access is disabled"
# description: "An Amazon EKS cluster endpoint is a network interface in a subnet that you use to communicate with your cluster control plane. Amazon EKS creates an endpoint for your cluster in each subnet associated with the cluster. The cluster endpoint is the same for all subnets. By default, the cluster endpoint is public to the internet. You can disable public access to the cluster endpoint by setting the endpointPublicAccess property to false."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
# custom:
#   id: CB_TFAWS_045
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_045

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_eks_cluster"
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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Blocks[_].Attributes, "endpoint_public_access")
    resource.Blocks[_].Attributes.endpoint_public_access == false
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_eks_cluster' 'endpoint_public_access' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_eks_cluster' 'endpoint_public_access' must be set to 'false'.",
                "snippet": block }
} 
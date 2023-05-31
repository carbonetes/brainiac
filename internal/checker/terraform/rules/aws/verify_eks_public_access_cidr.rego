# METADATA
# title: "Verify that Amazon EKS cluster endpoint public access is disabled or CIDR blocks are specified ip-ranges"
# description: "An Amazon EKS cluster endpoint is a network interface in a subnet that you use to communicate with your cluster control plane. Amazon EKS creates an endpoint for your cluster in each subnet associated with the cluster. The cluster endpoint is the same for all subnets. By default, the cluster endpoint is public to the internet. You can disable public access to the cluster endpoint by setting the endpointPublicAccess property to false."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster
# custom:
#   id: CB_TFAWS_035
#   severity: HIGH
package lib.terraform.CB_TFAWS_035

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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Blocks[_].Attributes, "public_access_cidrs")
    resource.Blocks[_].Attributes.public_access_cidrs[_] != "0.0.0.0/0"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_eks_cluster' 'endpoint_public_access' and 'public_access_cidrs' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_eks_cluster' 'endpoint_public_access' must be set to 'false' or 'public_access_cidrs' must not be set to '0.0.0.0/0'.",
                "snippet": block }
} 
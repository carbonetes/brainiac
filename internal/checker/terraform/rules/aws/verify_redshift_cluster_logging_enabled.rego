# METADATA
# title: "Verify Redshift Cluster logging is enabled"
# description: "Enabling Redshift Cluster logging ensures that important information about the cluster's activities, queries, errors, and performance metrics is captured and stored for analysis. "
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster
# custom:
#   id: CB_TFAWS_078
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_078

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
    block := resource.Blocks[_]
    block.Type == "logging"
    block.Attributes.enable == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_redshift_cluster' 'logging' is enabled.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_redshift_cluster' 'logging' should be enabled.",
                "snippet": block }
}

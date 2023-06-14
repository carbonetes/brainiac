# METADATA
# title: "Verify that enhanced monitoring is enabled for Amazon RDS instances"
# description: "By enabling enhanced monitoring, you can collect and analyze additional metrics at a higher resolution, which helps in identifying performance bottlenecks, troubleshooting issues, and optimizing the database performance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance.html
# custom:
#   id: CB_TFAWS_109
#   severity: LOW
package lib.terraform.CB_TFAWS_109

supportedResources := ["aws_db_instance", "aws_rds_cluster_instance"]
isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 


has_attribute(key, value) {
  _ = key[value]
}

pass[resource]{
    resource := input[_]
	isvalid(resource)
    has_attribute(resource.Attributes, "monitoring_interval")
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'Amazon RDS instances' monitoring_interval is configured",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "'Amazon RDS instances' monitoring_interval should be configured.",
                "snippet": block }
}

# METADATA
# title: "Verify that Multi-AZ is enabled for RDS instances"
# description: "Databases inside a single region benefit from improved availability thanks to Amazon RDS Multi-AZ deployments. If you have configured Multi-AZ, Amazon RDS will automatically transition to a standby replica in another Availability Zone in the case of a scheduled or unforeseen outage of your DB instance."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance.html
# custom:
#   id: CB_TFAWS_148
#   severity: LOW
package lib.terraform.CB_TFAWS_148

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_db_instance"
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
    has_attribute(resource.Attributes, "multi_az")
    resource.Attributes.multi_az == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "Multi-AZ is enabled for RDS instances.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Multi-AZ should be enabled for RDS instances.",
                "snippet": block }
} 
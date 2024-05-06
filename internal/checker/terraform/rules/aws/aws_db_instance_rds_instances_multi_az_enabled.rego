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
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_db_instance"
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
	isvalid(resource)
    has_attribute(resource.Attributes, "multi_az")
    resource.Attributes.multi_az == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Multi-AZ is enabled for RDS instances.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Multi-AZ should be enabled for RDS instances.",
                "snippet": block }
} 
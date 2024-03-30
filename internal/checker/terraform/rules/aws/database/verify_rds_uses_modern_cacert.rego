# METADATA
# title: "Verify RDS uses a modern CaCert"
# description: "By using a modern and up-to-date certificate authority (CaCert), the RDS service can establish trusted connections and encrypt the data in transit."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
# custom:
#   id: CB_TFAWS_195
#   severity: LOW
package lib.terraform.CB_TFAWS_195
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
    has_attribute(resource.Attributes, "ca_cert_identifier")
    resource.Attributes.ca_cert_identifier == "rds-ca-2019"
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_db_instance' 'ca_cert_identifier' uses a modern CaCert.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_db_instance' 'ca_cert_identifier' should use modern CaCert",
                "snippet": block }
} 
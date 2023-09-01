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
    has_attribute(resource.Attributes, "ca_cert_identifier")
    resource.Attributes.ca_cert_identifier == "rds-ca-2019"
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_db_instance' 'ca_cert_identifier' uses a modern CaCert.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_db_instance' 'ca_cert_identifier' should use modern CaCert",
                "snippet": block }
} 
# METADATA
# title: "Verify that Athena Workgroup is encrypted"
# description: "By enabling encryption for Athena Workgroup, data at rest and in transit is encrypted, providing an additional layer of security."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/3.17.0/docs/resources/athena_workgroup
# custom:
#   id: CB_TFAWS_137
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_137
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_athena_workgroup"
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

has_attribute(key, value) if {
    value in object.keys(key)
}

pass contains resource if {
	some resource in input
    isvalid(resource)
    some conf in resource.Blocks
    conf.Type == "configuration"
    some res_conf in conf.Blocks
    res_conf.Type == "result_configuration"
    some encrypt_conf in res_conf.Blocks
    encrypt_conf.Type == "encryption_configuration"
    has_attribute(encrypt_conf.Attributes, "encryption_option")
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_athena_workgroup' encryption is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_athena_workgroup' should be encrypted",
                "snippet": block }
} 
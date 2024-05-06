# METADATA
# title: "Verify that DAX cluster endpoint is using TLS"
# description: "By enabling TLS encryption for the DAX cluster endpoint, sensitive data transmitted between client applications and the DAX cluster is protected, ensuring secure and confidential communication."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dax_cluster#cluster_endpoint_encryption_type
# custom:
#   id: CB_TFAWS_228
#   severity: LOW
package lib.terraform.CB_TFAWS_228
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_dax_cluster"
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
    resource.Attributes.cluster_endpoint_encryption_type == "TLS"
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "DAX cluster endpoint is using TLS",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "DAX cluster endpoint should use TLS",
                "snippet": block }
}
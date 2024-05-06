# METADATA
# title: "Verify Code Pipeline Artifact store is using a KMS CMK"
# description: "The benefit of verifying that the Code Pipeline Artifact store is using a KMS (Key Management Service) Customer Managed Key (CMK) is to ensure the encryption of artifacts stored in the Code Pipeline."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline
# custom:
#   id: CB_TFAWS_210
#   severity: LOW
package lib.terraform.CB_TFAWS_210
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_codepipeline"
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
    some block in resource.Blocks
    block.Type == "artifact_store"
    some type in block.Blocks
    type.Type == "encryption_key"
    type.Attributes.id != ""
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'Code Pipeline Artifact store is using a KMS CMK",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "Code Pipeline Artifact store encryption_key should be using KMS CMK",
                "snippet": block }
} 
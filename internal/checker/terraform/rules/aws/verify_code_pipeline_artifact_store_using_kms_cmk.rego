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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_codepipeline"
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
    resource.Blocks[_].Type == "artifact_store"
    resource.Blocks[_].Blocks[_].Type == "encryption_key"
    resource.Blocks[_].Blocks[_].Attributes.id != ""
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'Code Pipeline Artifact store is using a KMS CMK",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "Code Pipeline Artifact store encryption_key should be using KMS CMK",
                "snippet": block }
} 
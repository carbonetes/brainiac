# METADATA
# title: "Make certain SSE-KMS is being used for the encryption in the Cluster security setup"
# description: "Implementing Amazon S3 Server-Side Encryption with AWS Key Management Service (SSE-KMS) in your Amazon Elastic MapReduce (EMR) cluster's security configuration can effectively safeguard the data stored within the cluster."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/emr_security_configuration
# custom:
#   id: CB_TFAWS_164
#   severity: INFO
package lib.terraform.CB_TFAWS_164

import future.keywords.in 


isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_emr_security_configuration"
}

has_attribute(key, value) {
    _ = key[value]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[block] {
    block := input[_]
    isvalid(block)
    configStr := block.Attributes.configuration
    configParsed := json.unmarshal(configStr)
    configParsed.EncryptionConfiguration.AtRestEncryptionConfiguration.S3EncryptionConfiguration.EncryptionMode != "SSE-KMS"
}

fail[block] {
    block := input[_]
    isvalid(block)
    configStr := block.Attributes.configuration
    configParsed := json.unmarshal(configStr)
    configParsed.EncryptionConfiguration.AtRestEncryptionConfiguration.S3EncryptionConfiguration == {}
}

pass[block] {
    block := input[_]
	isvalid(block)
    not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "SSE-KMS is utilized for the encryption in the Cluster security setup.",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "SSE-KMS must be utilized for the encryption in the Cluster security setup.",
                "snippet": block}
}

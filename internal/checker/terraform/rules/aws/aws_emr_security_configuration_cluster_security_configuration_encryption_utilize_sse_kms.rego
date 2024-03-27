# METADATA
# title: "Make certain SSE-KMS is being used for the encryption in the Cluster security setup"
# description: "Implementing Amazon S3 Server-Side Encryption with AWS Key Management Service (SSE-KMS) in your Amazon Elastic MapReduce (EMR) cluster's security configuration can effectively safeguard the data stored within the cluster."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/emr_security_configuration
# custom:
#   id: CB_TFAWS_164
#   severity: MEDIUM
package lib.terraform.CB_TFAWS_164
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_emr_security_configuration"
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

fail contains resource if {
    some resource in input
	isvalid(resource)
    config_str := resource.Attributes.configuration
    config_parsed := json.unmarshal(config_str)
    config_parsed.EncryptionConfiguration.AtRestEncryptionConfiguration.S3EncryptionConfiguration.EncryptionMode != "SSE-KMS"
}

fail contains resource if {
    some resource in input
	isvalid(resource)
    config_str := resource.Attributes.configuration
    config_parsed := json.unmarshal(config_str)
    config_parsed.EncryptionConfiguration.AtRestEncryptionConfiguration.S3EncryptionConfiguration == {}
}

pass contains block if {
	some block in input
	isvalid(block)
    not fail[block]
}

passed contains result if {
    some block in pass
	result := { "message": "SSE-KMS is utilized for the encryption in the Cluster security setup.",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "SSE-KMS must be utilized for the encryption in the Cluster security setup.",
                "snippet": block}
}

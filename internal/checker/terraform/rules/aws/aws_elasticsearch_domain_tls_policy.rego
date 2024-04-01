# METADATA
# title: "Ensure that Elasticsearch domain is using an up to date TLS policy"
# description: "By enforcing an up-to-date TLS policy for the Elasticsearch domain, data exchanged between clients and the domain is secured with the latest cryptographic protocols, ensuring the confidentiality and integrity of sensitive information."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticsearch_domain#domain_endpoint_options
# custom:
#   id: CB_TFAWS_215
#   severity: LOW
package lib.terraform.CB_TFAWS_215
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    supported_resource := ["aws_elasticsearch_domain", "aws_opensearch_domain"]
    label in supported_resource
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
    block.Attributes.tls_security_policy == "Policy-Min-TLS-1-2-2019-07"
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "Elasticsearch domain is using an up to date TLS policy.",
                "snippet": block}
}

failed contains result if {
    some block in fail
	result := { "message": "Elasticsearch domain is not using an up to date TLS policy.",
                "snippet": block }
}

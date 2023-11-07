# METADATA
# title: "Verify no HTTPS or SSL proxy load balancers permit SSL policies with weak cipher suites"
# description: "This check ensures that HTTPS or SSL proxy load balancers do not allow the use of weak cipher suites, enhancing security by preventing the usage of vulnerable encryption algorithms, thereby reducing the risk of potential security breaches and data exposure."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance
# custom:
#   id: CB_TFGCP_009
#   severity: MEDIUM
package lib.terraform.CB_TFGCP_009
import future.keywords.in

isvalid(block){
	block.Type == "resource"
    "google_compute_ssl_policy" in block.Labels
}

resource[resource] {
	some block in pass
	resource := concat(".", block.Labels)
}

resource[resource] {
	some block in fail
	resource := concat(".", block.Labels)
}

pass[block] {
    some block in input
	isvalid(block)
	block.Attributes.profile == "MODERN"
	block.Attributes.min_tls_version == "TLS_1_2"
}

pass[block] {
    some block in input
	isvalid(block)
	block.Attributes.profile == "RESTRICTED"
}

pass[block] {
    some block in input
	isvalid(block)
	block.Attributes.profile == "CUSTOM"
	invalid_features := ["TLS_RSA_WITH_AES_128_GCM_SHA256",
                        "TLS_RSA_WITH_AES_256_GCM_SHA384",
                        "TLS_RSA_WITH_AES_128_CBC_SHA",
                        "TLS_RSA_WITH_AES_256_CBC_SHA",
                        "TLS_RSA_WITH_3DES_EDE_CBC_SHA"]
	not block.Attributes.custom_features in invalid_features
}

fail[block] {
    some block in input
	isvalid(block)
    not pass[block]
}


passed[result] {
    some block in pass
	result := { "message": "No HTTPS or SSL proxy load balancers permit SSL policies with weak cipher suites.",
                "snippet": block }
}

failed[result] {
    some block in fail
	result := { "message": "HTTPS or SSL proxy load balancers should not permit SSL policies with weak cipher suites.",
                "snippet": block }
}
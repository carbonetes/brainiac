# METADATA
# title: "Verify Elasticsearch Domain enforces HTTPS"
# description: "Checks if the EnforceHTTPS property of an Elasticsearch Domain is set to true. This encrypts communication between your clients and the domain, safeguarding sensitive data in transit."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html
# custom:
#   id: CB_CFT_064
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_064

import future.keywords.in

resource := "AWS::Elasticsearch::Domain"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[https] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    https := resources.Properties.DomainEndpointOptions
    https.EnforceHTTPS == true
}

fail[resources] {
    some resources in input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Elasticsearch Domain enforces HTTPS.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Elasticsearch Domain does not enforce HTTPS.",
        "snippet": block,
    }
}
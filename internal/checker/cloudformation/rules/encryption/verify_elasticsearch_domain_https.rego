# METADATA
# title: "Verify HTTPS are enforced by Elasticsearch Domain"
# description: "This policy allows for the creation of applications using Amazon Elasticsearch Service (Amazon ES) without managing your own search cluster. You can configure domains to require HTTPS for encrypted communication with clients. It's recommended to set the minimum required TLS version to ensure client configurations are secure."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html
# custom:
#   id: CB_CFT_059
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_059

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
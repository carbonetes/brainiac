 # METADATA
# title: "Verify node-to-node encryption for Elasticsearch are enabled."
# description: "This policy ensures that sensitive workloads hosted on the AWS Elasticsearch Service benefit from node-to-node encryption using Transport Layer Security (TLS). It guarantees that data transmitted over HTTPS to your Amazon Elasticsearch Service domain remains encrypted during distribution and replication across nodes." 
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-elasticsearch-domain.html
# custom:
#   id: CB_CFT_004
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_004
import future.keywords.in

resource := "AWS::Elasticsearch::Domain"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[resources] {
    is_valid
    some resources in input.Resources
    node := resources.Properties.NodeToNodeEncryptionOptions
    node.Enabled == true
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Node-to-node encryption is enabled for the Elasticsearch domain.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Node-to-node encryption must be enabled for the Elasticsearch domain.",
        "snippet": block,
    }
}

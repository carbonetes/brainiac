 # METADATA
# title: "Verify that all information stored within Elasticsearch has node-to-node encryption enabled."
# description: "This policy enables secure hosting of sensitive workloads by implementing encryption at rest. This feature safeguards data stored on instances within a cluster using encryption protocols, ensuring protection against unauthorized access." 
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-elasticsearch-domain-nodetonodeencryptionoptions.html
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

pass[block] {
    is_valid
    some resources in input.Resources
    node := resources.Properties.NodeToNodeEncryptionOptions
    node.Enabled == true
    block := node
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

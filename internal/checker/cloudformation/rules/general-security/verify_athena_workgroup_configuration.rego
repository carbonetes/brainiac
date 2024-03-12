# METADATA
# title: "Verify Athena Workgroup should enforce configuration to prevent client disabling encryption"
# description: "Checks if the EnforceWorkGroupConfiguration property of an Athena Workgroup is set to true. This setting prevents users from disabling encryption at the client level"
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html
# custom:
#   id: CB_CFT_063
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_063

import future.keywords.in

resource := "AWS::Athena::WorkGroup"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[config] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    config := resources.Properties.Configuration 
    config.EnforceWorkGroupConfiguration == true
}

fail[resources] {
    some resources in input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Athena Workgroup configuration is enforced.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Athena Workgroup configuration is not enforced.",
        "snippet": block,
    }
}
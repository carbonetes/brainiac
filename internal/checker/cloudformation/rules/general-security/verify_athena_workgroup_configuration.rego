# METADATA
# title: "Verify prevention of Athena workgroup for disabling encryption"
# description: "This policy allows configuration settings at the workgroup level, affecting queries executed within that workgroup. If a query runs within a workgroup and the workgroup overrides client-side settings, Athena will use the workgroup's encryption settings, overriding any other settings specified for the query."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-athena-workgroup.html
# custom:
#   id: CB_CFT_058
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_058

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
# METADATA
# title: "Verify Instance Metadata Service Version 1 is not enabled for EC2 Launch Template"
# description: "Instance Metadata Service (IMDS) version 1 exposes security vulnerabilities. Disabling v1 improves the security posture of your instances launched from this template."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html
# custom:
#   id: CB_CFT_062
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_062

import future.keywords.in

resource := "AWS::EC2::LaunchTemplate"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[http] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    http := resources.Properties.LaunchTemplateData.MetadataOptions
    http.HttpEndpoint == "disabled"
    http.HttpTokens == "required"
}

fail[resources] {
    some resources in input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Instance Metadata Service Version 1 is not enabled.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Instance Metadata Service Version 1 is enabled.",
        "snippet": block,
    }
}
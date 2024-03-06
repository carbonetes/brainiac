# METADATA
# title: "Verify Redshift Cluster Logging is Enabled"
# description: "Checks if logging is enabled for an AWS Redshift Cluster."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-cluster.html
# custom:
#   id: CB_CFT_057
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_057

import future.keywords.in

resource := "AWS::Redshift::Cluster"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

pass[block] {
    is_valid
    some resources in input.Resources
    resources.Type == resource
    block := resources.Properties.LoggingProperties
    block.BucketName
    block.S3KeyPrefix
}

fail[resources] {
    is_valid
    some resources in input.Resources
    count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Redshift Cluster has logging enabled.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Redshift Cluster does not have logging enabled.",
        "snippet": block,
    }
}
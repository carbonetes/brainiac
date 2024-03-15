# METADATA
# title: "Verify Redshift Cluster Logging is Enabled"
# description: "This policy entails Amazon Redshift logging connections and user actions in S3 buckets for security monitoring and troubleshooting, commonly referred to as database auditing. Enabling S3 bucket logging for Redshift databases captures all events affecting the database, aiding in security and incident response workflows."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-redshift-cluster.html
# custom:
#   id: CB_CFT_052
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_052

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
    block := resources.Properties
    "BucketName" in object.keys(block.LoggingProperties)
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
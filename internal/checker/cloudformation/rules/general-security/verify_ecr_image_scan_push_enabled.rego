# METADATA
# title: "Verify ECR image scan on push are enabled"
# description: "This policy allows Amazon ECR to manage container images by scanning for operating system vulnerabilities. Automated scans ensure vulnerabilities are identified before images are pushed to production with notifications provided by ECR APIs upon completion."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ecr-repository.html
# custom:
#   id: CB_CFT_102
#   severity: HIGH
package lib.cloudformation.CB_CFT_102
import future.keywords.in

resource := "AWS::ECR::Repository"

is_valid {
	some resources in input.Resources
	resources.Type == resource
}

pass[properties] {
    some resource in input.Resources
    properties := resource.Properties
    image := properties.ImageScanningConfiguration.scanOnPush
    image == true
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "ECR image scanning on push is enabled",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "ECR image scanning on push is not enabled",
		"snippet": block,
	}
}
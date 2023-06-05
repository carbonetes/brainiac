# METADATA
# title: "Verify S3 bucket does not allow an action with any Principal"
# description: "Enforcing this check helps to maintain the principle of least privilege and ensures that only authorized entities have the necessary permissions to interact with the S3 bucket, reducing the risk of data breaches and unauthorized data modifications."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# custom:
#   id: CB_TFAWS_077
#   severity: CRITICAL
package lib.terraform.CB_TFAWS_077

import future.keywords.in 

supportedResources := ["aws_s3_bucket", "aws_s3_bucket_policy"]
isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResources[_]
}

resource [resource]{
    block := pass[_]
	resource := concat(".", block.Labels)
} 
resource [resource]{
    block := fail[_]
	resource := concat(".", block.Labels)
} 

fail[block] {
    block := input[_]
    isvalid(block)
    policyStr := block.Attributes.policy
    policyParsed := json.unmarshal(policyStr)
    statement := policyParsed.Statement[0]
    statement.Effect != "Deny"
    contains(statement.Principal, "*")
}

pass[block] {
    block := input[_]
	isvalid(block)
    not fail[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "S3 bucket does not allow an action with any Principal",
                "snippet": block}
}

failed[result] {
    block := fail[_]
	result := { "message": "S3 bucket should not allow an action with any Principal",
                "snippet": block}
}

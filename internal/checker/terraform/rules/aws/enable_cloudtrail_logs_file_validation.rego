# METADATA
# title: "Enable CloudTrail log file validation"
# description: "CloudTrail log file validation helps ensure the integrity of your log files. When log file integrity validation is enabled, CloudTrail validates the integrity of log files delivered to your S3 bucket. CloudTrail uses industry standard algorithms: SHA-256 for hashing and SHA-256 with RSA for digital signing. CloudTrail uses a hash file to validate the integrity of compressed log files."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudtrail
# custom:
#   id: CB_TFAWS_033
#   severity: LOW
package lib.terraform.CB_TFAWS_033

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_cloudtrail"
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource]{
    resource := input[_]
	isvalid(resource)
    resource.Attributes.enable_log_file_validation == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_cloudtrail' 'enable_log_file_validation' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_cloudtrail' 'enable_log_file_validation' should be set to 'true'",
                "snippet": block }
} 
# METADATA
# title: "Verify that public access to RDS data is prohibited."
# description: "This policy guarantees the protection of all your public AWS Application Load Balancers from application-layer attacks by integrating them with the Web Application Firewall (AWS WAF) service, ensuring that they remain inaccessible to the public."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbinstance.html
# custom:
#   id: CB_CFT_008
#   severity: MEDIUM
package lib.cloudformation.CB_CFT_008
import future.keywords.in

resource := "AWS::RDS::DBInstance"

is_valid{
    some resources in input.Resources
    resources.Type == resource
}

pass[block] {
    is_valid
    some resources in input.Resources
    block := resources.Properties.PubliclyAccessible 
    block == false
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

passed[result] {
    some block in pass
    result := {
        "message": "Public access to RDS data is properly restricted.",
        "snippet": block,
    }
}

failed[result] {
    some block in fail
    result := {
        "message": "Public access to RDS data is detected, which is prohibited to ensure database security.",
        "snippet": block,
    }
}


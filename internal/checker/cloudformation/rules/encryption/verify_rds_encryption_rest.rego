# METADATA
# title: "Verify all data stored in RDS is encrypted at rest"
# description: "This policy ensures enhanced security and compliance with data-at-rest encryption regulations for your cloud databases, providing robust protection and regulatory adherence."
# scope: package
# related_resources:
# - https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-rds-dbcluster.html
# custom:
#   id: CB_CFT_007
#   severity: HIGH
package lib.cloudformation.CB_CFT_007
import future.keywords.in

resource := "AWS::RDS::DBInstance"

is_valid {
    some resources in input.Resources
    resources.Type == resource
}

permitted_engines := {"aurora", "mysql", "oracle", "postgresql", "mariadb", "sqlserver"}

pass[resources] {
    is_valid
    some resources in input.Resources
    rest := resources.Properties.StorageEncrypted 
    rest == true
    some permitted_engine in permitted_engines
    permitted_engine == resources.Properties.Engine
}

fail[resources] {
    resources := input.Resources
    is_valid
    count(pass) == 0
}

failed[result] {
    some block in fail
    result := {
        "message": "Encryption settings are necessary to ensure the security of the RDS instance when data is at rest.",
        "snippet": block,
    }
}

passed[result] {
    some block in pass
    result := {
        "message": "Encryption requirements are met for securing the RDS instance while data is at rest.",
        "snippet": block,
    }
}
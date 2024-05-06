# METADATA
# title: "Verify that Redshift cluster allowing version upgrade by default"
# description: "By allowing version upgrades by default in the Redshift cluster, you ensure that your cluster stays up to date with the latest features, bug fixes, and security patches, ensuring optimal performance and minimizing the risk of potential vulnerabilities."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster#allow_version_upgrade
# custom:
#   id: CB_TFAWS_144
#   severity: LOW
package lib.terraform.CB_TFAWS_144
import rego.v1

isvalid(block) if{
	block.Type == "resource"
    some label in block.Labels 
    label == "aws_redshift_cluster"
}

has_attribute(key, value) if {
    value in object.keys(key)
}

resource contains resource if {
    some block in pass
	resource := concat(".", block.Labels)
} 

resource contains resource if{
	some block in fail
	resource := concat(".", block.Labels)
} 

pass contains resource if {
    some resource in input
    isvalid(resource)
    not has_attribute(resource.Attributes, "allow_version_upgrade")
}

pass contains resource if {
    some resource in input
    isvalid(resource)
    resource.Attributes.allow_version_upgrade == true
}

fail contains block if {
	some block in input
	isvalid(block)
   	not pass[block]
}

passed contains result if {
    some block in pass
	result := { "message": "'aws_redshift_cluster' for 'allow_version_upgrade' is set properly.",
                "snippet": block }
}

failed contains result if {
    some block in fail
	result := { "message": "'aws_redshift_cluster' for 'allow_version_upgrade' should be set.",
                "snippet": block }
} 
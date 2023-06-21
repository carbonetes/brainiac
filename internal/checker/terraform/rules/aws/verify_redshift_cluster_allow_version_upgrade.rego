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

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == "aws_redshift_cluster"
}

has_attribute(key, value) {
  _ = key[value]
}

resource[resource] {
    block := pass[_]
	resource := concat(".", block.Labels)
} 

resource[resource] { 
    block := fail[_]
	resource := concat(".", block.Labels)
} 

pass[resource] {
	resource := input[_]
    isvalid(resource)
    not has_attribute(resource.Attributes, "allow_version_upgrade")
}

pass[resource] {
	resource := input[_]
    isvalid(resource)
    resource.Attributes.allow_version_upgrade == true
}

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "'aws_redshift_cluster' for 'allow_version_upgrade' is set properly.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "'aws_redshift_cluster' for 'allow_version_upgrade' should be set.",
                "snippet": block }
} 
# METADATA
# title: "Verify the git url is properly configured"
# description: "This policy ensures that the 'git_url' attribute within the 'ibm_app_config_snapshot' resource is properly configured. The URL must be in the format 'https://api.github.com/repos/{owner}/{repo_name}'. Improper configuration can lead to operational issues."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/app_config_snapshot
# custom:
#   id: CB_TFIBM_100
#   severity: MEDIUM
package lib.terraform.CB_TFIBM_100

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	"ibm_app_config_snapshot" in block.Labels
}

resource contains resource if {
	some block in pass
	resource := concat(".", block.Labels)
}

resource contains resource if {
	some block in fail
	resource := concat(".", block.Labels)
}

pass contains resource if {
	some resource in input
	isvalid(resource)
	not fail[resource]
}

fail contains resource if {
	some resource in input
	isvalid(resource)
	hasImproperGitUrlConfiguration(resource)
}

hasImproperGitUrlConfiguration(block) if {
	not regex.match(`https:\/\/api\.github\.com\/repos\/[^\/]+\/[^\/]+`, block.Attributes.git_url)
}

passed contains result if {
	some block in pass
	result := {
		"message": "IBM App Config Snapshot resource has a properly configured 'git_url'. No action required.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "IBM App Config Snapshot resource has an improperly configured 'git_url'. Please ensure the URL is in the format 'https://api.github.com/repos/{owner}/{repo_name}'.",
		"snippet": block,
	}
}

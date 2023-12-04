# METADATA
# title: "Verify that a user for the container has been created"
# description: "This ensures that a specific user has been created within the container, enhancing security by minimizing the risks associated with running processes as the default root user."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#user
# custom:
#   id: CB_DKR_003
#   severity: LOW
package lib.docker.CB_DKR_003

import future.keywords.in

resource := "USER"

pass[args]{
    some args in input
    args.instruction == resource
}
 
passed[result] {
    some line in pass
	result := { "message": "USER for the container has been created",
                "snippet": line }
}

failed[result] {
    count(pass) == 0
	result := { "message": "USER for the container should be created.",
                "snippet": {} }
} 
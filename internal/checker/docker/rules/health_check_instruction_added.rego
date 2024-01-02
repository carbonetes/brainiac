# METADATA
# title: "Verify that HEALTHCHECK instructions have been added to container images"
# description: "Adding HEALTHCHECK instructions to Dockerfiles enhances the reliability and robustness of containerized applications by allowing Docker to periodically check the health of the running containers, ensuring better monitoring and automated recovery in case of issues."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#healthcheck
# custom:
#   id: CB_DKR_002
#   severity: LOW
package lib.docker.CB_DKR_002

import future.keywords.in

resource := "HEALTHCHECK"

pass[args]{
    some args in input
    args.instruction == resource
}
 
passed[result] {
    some line in pass
	result := { "message": "HEALTHCHECK instructions have been added to container images",
                "snippet": line }
}

failed[result] {
    count(pass) == 0
	result := { "message": "HEALTHCHECK instructions should be added to container images.",
                "snippet": {} }
} 
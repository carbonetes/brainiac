# METADATA
# title: "Verify that APT isn't used"
# description: "Avoiding APT (Advanced Package Tool) in Dockerfiles provides benefits such as reduced image size, improved security by minimizing dependencies, enhanced build consistency, efficient layer caching, and faster builds."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#run
# custom:
#   id: CB_DKR_009
#   severity: LOW
package lib.docker.CB_DKR_009

import future.keywords.in

resource := "RUN"

fail[args]{
    some args in input
    args.instruction == resource
    some argument in args.args
    argument == "apt"
}
 
pass[args] {
    some args in input
    args.instruction == resource
    count(fail) == 0
}

passed[result] {
    some line in pass
	result := { "message": "APT is not used.",
                "snippet": line }
}

failed[result] {
    some line in fail
	result := { "message": "APT should not be used.",
                "snippet": line }
} 
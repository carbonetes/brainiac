# METADATA
# title: "Verify update instructions are not use alone in the Dockerfile"
# description: "Combining update instructions with package installations in the same layer helps minimize the number of layers and reduces the overall image size, making the Docker image more efficient and easier to manage."
# scope: package
# related_resources:
# - https://docs.docker.com/engine/reference/builder/#run
# custom:
#   id: CB_DKR_005
#   severity: LOW
package lib.docker.CB_DKR_005

import future.keywords.in

resource := "RUN"

install_commands := [
    "install",
    "source-install",
    "reinstall",
    "groupinstall",
    "localinstall",
    "add",
    "upgrade",
]

has_update_args{
    some args in input
    args.instruction == resource
    some argument in args.args
	contains(argument, "update")
}

pass[args]{
    has_update_args
    some args in input
    args.instruction == resource
    some arguments in args.args
    arguments in install_commands
}
 
fail[args] {
    has_update_args
    some args in input
    args.instruction == resource
    not pass[args]
}

passed[result] {
    some line in pass
	result := { "message": "'update' instructions are not use alone in the Dockerfile.",
                "snippet": line }
}

failed[result] {
    some line in fail
	result := { "message": "update instructions should not be use alone in the Dockerfile.",
                "snippet": line }
} 
# METADATA
# title: "Verify that the kubelet only use Strong Cryptographic Ciphers"
# description: "Ensure that the kubelet uses Strong Cryptographic Ciphers to increase the encryption strength"
# scope: package
# related_resources:
# - https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/
# custom:
#   id: CB_K8S_053
#   severity: HIGH
package lib.kubernetes.CB_K8S_053

import data.lib.kubernetes
import future.keywords.if

resource = kubernetes.resource

validResource := ["CronJob", "Pod"]
isValid{
	kubernetes.is_controller

}
isValid{
	kubernetes.kind == validResource[_]
}

default flag := "--tls-cipher-suites"
default is_passed := true
default is_failed := false
default strong_ciphers_argument := [
    "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
    "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
    "TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384",
    "TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256",
    "TLS_RSA_WITH_AES_128_GCM_SHA256",
    "TLS_RSA_WITH_AES_256_GCM_SHA384",
]

hasContainersCommands {
    commands := kubernetes.containers_commands
    commands[_] == "kubelet"
}

ciphers := split(split({ r | r := kubernetes.containers_commands[_]; startswith(r, flag) }[_], "=")[1], ",")
matching_ciphers := kubernetes.array_to_set(ciphers) & kubernetes.array_to_set(strong_ciphers_argument)
non_matching_ciphers := kubernetes.array_to_set(ciphers) - kubernetes.array_to_set(strong_ciphers_argument)

unmatch_ciphers := result if {
	count(non_matching_ciphers) > 1
    count(non_matching_ciphers[_]) > 0
    result := non_matching_ciphers
} else := result if {
    result := ["empty cipher"]
}

matched_ciphers := result if {
    count(matching_ciphers) > 1
    count(matching_ciphers[_]) > 0
	result := matching_ciphers
} else := result if {
    result := ["default cipher"]
}

is_passed := false {
    count(non_matching_ciphers) > 0
}

is_failed {
	count(non_matching_ciphers) > 0
}

getContainerCommand[kubernetes.containers[_]]

passed[result] {
    isValid
    hasContainersCommands
	is_passed
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is using '%s'", [kubernetes.kind, kubernetes.name, flag, concat(",", matched_ciphers)]),
                "snippet": getContainerCommand[_] }
}

failed[result] {
    isValid
    hasContainersCommands
	is_failed
	result := { "message": sprintf("The commands for %s - %s with the flag of '%s' is using weak/invalid ciphers '%s'", [kubernetes.kind, kubernetes.name, flag, concat(",", unmatch_ciphers)]),
                "snippet": getContainerCommand[_] }
}
# METADATA
# title: "Verify Utilization of Latest Net Framework in Web Application"
# description: "Ensure verification of the utilization of the latest version of the .NET Framework within the web application."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.web/sites/config-web?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_051
#   severity: LOW
package lib.azurearm.CB_AZR_051
import future.keywords.in

resource := "Microsoft.Web/sites/config"

is_valid{
	some res in input.resources
    res.type == resource
}

pass[properties] {
    is_valid
    some resource in input.resources
    properties := resource.properties
    properties.netFrameworkVersion == "v7.0"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
    some properties in pass
    result := { "message": "Net Framework is latest.",
                "snippet": properties }
}

failed[result] {
    some properties in fail
    result := { "message": "Net Framework must be latest.",
                "snippet": properties }
}

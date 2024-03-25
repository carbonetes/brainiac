# METADATA
# title: "Verify SSL connection is enabled for MariaDB servers"
# description: "This policy ensures that Azure Database for MariaDB enables Secure Sockets Layer (SSL) connections, enhancing security by encrypting data transmission between the server and client applications, thus guarding against potential 'man in the middle' attacks."
# scope: package
# related_resources:
# - https://learn.microsoft.com/en-us/azure/templates/microsoft.dbformariadb/servers?pivots=deployment-language-arm-template
# custom:
#   id: CB_AZR_043
#   severity: HIGH
package lib.azurearm.CB_AZR_043
import future.keywords.in

resource := "Microsoft.DBforMariaDB/servers"

is_valid {
	some res in input.resources
	res.type == resource
}

pass[properties] {
 	is_valid
	some resource in input.resources
    properties := resource.properties
   	"sslEnforcement" in object.keys(properties)
    properties.sslEnforcement == "Enabled"
}

fail[resources] {
	resources := input.resources
	is_valid
	count(pass) == 0
}

passed[result] {
	some block in pass
	result := {
		"message": "SSL connection is enabled for MariaDB servers",
		"snippet": block,
	}
}

failed[result] {
	some block in fail
	result := {
		"message": "SSL connection is not enabled for MariaDB servers",
		"snippet": block,
	}
}
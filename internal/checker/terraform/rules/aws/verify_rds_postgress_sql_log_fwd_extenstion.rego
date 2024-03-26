# METADATA
# title: "Verify that RDS PostgreSQL instances use a non vulnerable version with the log_fdw extension."
# description: "By ensuring that RDS PostgreSQL instances use a non-vulnerable version with the log_fdw extension, we mitigate potential security risks and enhance the database's capabilities for secure and efficient log data processing."
# scope: package
# related_resources:
# - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster
# custom:
#   id: CB_TFAWS_283
#   severity: LOW
package lib.terraform.CB_TFAWS_283

import rego.v1

isvalid(block) if {
	block.Type == "resource"
	some label in block.Labels
	supported_resources := ["aws_rds_cluster", "aws_db_instance"]
	label in supported_resources
	engines := ["postgres", "aurora-postgresql"]
	block.Attributes.engine in engines
	version_parts := count(split(block.Attributes.engine_version, "."))
	version_parts > 1
	version_parts <= 3
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
	version_check(resource.Attributes.engine_version, resource.Attributes.engine)
}

version_check(engine_version, engine) := result if {
	major_version := to_number(split(engine_version, ".")[0])
	minor_version := to_number(split(engine_version, ".")[1])
	engine == "postgres"
	result := postgres_version(major_version, minor_version)
} else := result if {
	major_version := to_number(split(engine_version, ".")[0])
	minor_version := to_number(split(engine_version, ".")[1])
	engine == "aurora-postgresql"
	result := postgresql_version(major_version, minor_version)
}

postgres_version(major_version, minor_version) if {
	major_version >= 14
} else if {
	major_version == 13
	minor_version > 2
} else if {
	major_version == 12
	minor_version > 6
} else if {
	major_version == 11
	minor_version > 11
} else if {
	major_version == 10
	minor_version > 16
} else := false

postgresql_version(major_version, minor_version) if {
	major_version >= 12
} else if {
	major_version == 11
	minor_version > 8
} else if {
	major_version == 10
	minor_version > 13
} else := false

fail contains block if {
	some block in input
	isvalid(block)
	not pass[block]
}

passed contains result if {
	some block in pass
	result := {
		"message": "RDS PostgreSQL instances is using a non vulnerable version with the log_fdw extension.",
		"snippet": block,
	}
}

failed contains result if {
	some block in fail
	result := {
		"message": "RDS PostgreSQL instances is using a vulnerable version with the log_fdw extension.",
		"snippet": block,
	}
}

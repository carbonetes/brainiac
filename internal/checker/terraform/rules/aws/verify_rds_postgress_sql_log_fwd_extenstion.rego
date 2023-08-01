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
import future.keywords.if

supportedResource := ["aws_rds_cluster", "aws_db_instance"]
engines := ["postgres", "aurora-postgresql"]

isvalid(block){
	block.Type == "resource"
    block.Labels[_] == supportedResource[_]
    block.Attributes.engine == engines[_]
    version_parts := count(split(block.Attributes.engine_version, "."))
    version_parts > 1
    version_parts <= 3
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

pass[resource]{
    resource := input[_]
	isvalid(resource)
    version_check(resource.Attributes.engine_version, resource.Attributes.engine)
}

version_check(engine_version, engine) := result if {
    major_version := to_number(split(engine_version, ".")[0])
    minor_version := to_number(split(engine_version, ".")[1])
    engine == engines[0]
    result := postgres_version(major_version, minor_version)
} else := result if {
    major_version := to_number(split(engine_version, ".")[0])
    minor_version := to_number(split(engine_version, ".")[1])
    engine == engines[1]
    result := postgresql_version(major_version, minor_version)
}

postgres_version(major_version, minor_version) := true if {
    major_version >= 14
} else := true if {
    major_version == 13
    minor_version > 2
} else := true if {
    major_version == 12 
    minor_version > 6
} else := true if {
    major_version == 11 
    minor_version > 11
} else := true if {
    major_version == 10 
    minor_version > 16
} else := false

postgresql_version(major_version, minor_version) := true if {
    major_version >= 12
} else := true if {
    major_version == 11
    minor_version > 8
} else := true if {
    major_version == 10
    minor_version > 13
} else := false

fail[block] {
    block := input[_]
	isvalid(block)
   	not pass[block]
}

passed[result] {
	block := pass[_]
	result := { "message": "RDS PostgreSQL instances is using a non vulnerable version with the log_fdw extension.",
                "snippet": block }
}

failed[result] {
    block := fail[_]
	result := { "message": "RDS PostgreSQL instances is using a vulnerable version with the log_fdw extension.",
                "snippet": block }
} 
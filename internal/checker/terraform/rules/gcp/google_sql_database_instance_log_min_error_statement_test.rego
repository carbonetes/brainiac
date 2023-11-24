package lib.terraform.CB_TFGCP_122

test_google_sql_database_instance_log_min_error_statement_passed {
	result := passed with input as [
    {
        "Type": "provider",
        "Labels": [
            "google"
        ],
        "Attributes": {
            "project": "<your-project-id>",
            "region": "<your-region>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_sql_database_instance",
            "example_instance"
        ],
        "Attributes": {
            "database_version": "POSTGRES_13",
            "name": "example-instance"
        },
        "Blocks": [
            {
                "Type": "settings",
                "Labels": [],
                "Attributes": {
                    "tier": "db-custom-1-3840",
                    "user_labels": {
                        "environment": "production"
                    }
                },
                "Blocks": [
                    {
                        "Type": "ip_configuration",
                        "Labels": [],
                        "Attributes": {
                            "ipv4_enabled": true,
                            "private_network": "<your-private-network>"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 21,
                            "startLine": 18
                        }
                    },
                    {
                        "Type": "database_flags",
                        "Labels": [],
                        "Attributes": {
                            "name": "log_min_error_statement",
                            "value": "error"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 26,
                            "startLine": 23
                        }
                    },
                    {
                        "Type": "backup_configuration",
                        "Labels": [],
                        "Attributes": {
                            "binary_log_enabled": true,
                            "enabled": true,
                            "location": "us-central1",
                            "point_in_time_recovery_enabled": true
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 33,
                            "startLine": 28
                        }
                    }
                ],
                "line_range": {
                    "endLine": 34,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 35,
            "startLine": 7
        }
    }]
	count(result) == 1
}

test_google_sql_database_instance_log_min_error_statement_failed {
	result := failed with input as [{
        "Type": "provider",
        "Labels": [
            "google"
        ],
        "Attributes": {
            "project": "<your-project-id>",
            "region": "<your-region>"
        },
        "Blocks": [],
        "line_range": {
            "endLine": 5,
            "startLine": 1
        }
    },
    {
        "Type": "resource",
        "Labels": [
            "google_sql_database_instance",
            "example_instance"
        ],
        "Attributes": {
            "database_version": "POSTGRES_13",
            "name": "example-instance"
        },
        "Blocks": [
            {
                "Type": "settings",
                "Labels": [],
                "Attributes": {
                    "tier": "db-custom-1-3840",
                    "user_labels": {
                        "environment": "production"
                    }
                },
                "Blocks": [
                    {
                        "Type": "ip_configuration",
                        "Labels": [],
                        "Attributes": {
                            "ipv4_enabled": true,
                            "private_network": "<your-private-network>"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 21,
                            "startLine": 18
                        }
                    },
                    {
                        "Type": "database_flags",
                        "Labels": [],
                        "Attributes": {
                            "name": "log_min_error_statement",
                            "value": "success"
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 26,
                            "startLine": 23
                        }
                    },
                    {
                        "Type": "backup_configuration",
                        "Labels": [],
                        "Attributes": {
                            "binary_log_enabled": true,
                            "enabled": true,
                            "location": "us-central1",
                            "point_in_time_recovery_enabled": true
                        },
                        "Blocks": [],
                        "line_range": {
                            "endLine": 33,
                            "startLine": 28
                        }
                    }
                ],
                "line_range": {
                    "endLine": 34,
                    "startLine": 11
                }
            }
        ],
        "line_range": {
            "endLine": 35,
            "startLine": 7
        }
    }]
	count(result) == 1
}

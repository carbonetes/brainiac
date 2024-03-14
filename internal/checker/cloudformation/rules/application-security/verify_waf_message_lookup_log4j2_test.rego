package lib.cloudformation.CB_CFT_110

test_verify_elasticsearch_domain_audit_logs_enabled {
    result := passed with input as {"Resources": {
        "MyWebACL": {
            "Type": "AWS::WAFv2::WebACL",
            "Properties": {
                "DefaultAction": {
                    "Allow": {}
                },
                "Rules": [
                    {
                        "Name": "RuleToPreventLog4jLookup",
                        "Priority": 1,
                        "Action": {
                            "Allow": {}
                        },
                        "Statement": {
                            "ManagedRuleGroupStatement": {
                                "Name": "AWSManagedRulesKnownBadInputsRuleSet",
                                "ExcludedRules": [
                                    {
                                        "Name": "Log4ShellFinder"
                                    }
                                ]
                            }
                        },
                        "VisibilityConfig": {
                            "SampledRequestsEnabled": true,
                            "CloudWatchMetricsEnabled": true
                        }
                    }
                ]
            }
        }
    }
}
        count(result) == 1
}

test_verify_waf_message_lookup_log4j2_enabled {
    result := failed with input as {"Resources": {
        "MyWebACL": {
            "Type": "AWS::WAFv2::WebACL",
            "Properties": {
                "DefaultAction": {
                    "Allow": {}
                },
                "Rules": [
                    {
                        "Name": "RuleToPreventLog4jLookup",
                        "Priority": 1,
                        "Action": {
                            "Allow": {}
                        },
                        "Statement": {
                            "ManagedRuleGroupStatement": {
                                "Name": "AWSManagedRulesKnownBadInputsRuleSet",
                                "ExcludedRules": [
                                    {
                                        "Name": "Log4JRCE"
                                    }
                                ]
                            }
                        },
                        "VisibilityConfig": {
                            "SampledRequestsEnabled": true,
                            "CloudWatchMetricsEnabled": true
                        }
                    }
                ]
            }
        }
    }
}
        count(result) == 1
}
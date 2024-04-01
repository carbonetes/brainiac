package lib.terraform.CB_TFAWS_209
import rego.v1

test_aws_mq_broker_current_mqbroker_version_passed if {
    result := passed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_mq_configuration",
                                "example"
                                ],
                                "Attributes": {
                                "data": "\u003c?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?\u003e\n\u003cbroker xmlns=\"http://activemq.apache.org/schema/core\"\u003e\n  \u003cplugins\u003e\n    \u003cforcePersistencyModeBrokerPlugin persistenceFlag=\"true\"/\u003e\n    \u003cstatisticsBrokerPlugin/\u003e\n    \u003ctimeStampingBrokerPlugin ttlCeiling=\"86400000\" zeroExpirationOverride=\"86400000\"/\u003e\n  \u003c/plugins\u003e\n\u003c/broker\u003e\n",
                                "description": "Example Configuration",
                                "engine_type": "ActiveMQ",
                                "engine_version": "5.17.1",
                                "name": "example"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 17,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 1
}

test_aws_mq_broker_current_mqbroker_version_failed if {
result := failed with input as [
                                {
                                "Type": "resource",
                                "Labels": [
                                "aws_mq_configuration",
                                "example"
                                ],
                                "Attributes": {
                                "data": "\u003c?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?\u003e\n\u003cbroker xmlns=\"http://activemq.apache.org/schema/core\"\u003e\n  \u003cplugins\u003e\n    \u003cforcePersistencyModeBrokerPlugin persistenceFlag=\"true\"/\u003e\n    \u003cstatisticsBrokerPlugin/\u003e\n    \u003ctimeStampingBrokerPlugin ttlCeiling=\"86400000\" zeroExpirationOverride=\"86400000\"/\u003e\n  \u003c/plugins\u003e\n\u003c/broker\u003e\n",
                                "description": "Example Configuration",
                                "engine_type": "ActiveMQ",
                                "engine_version": "1.17.1",
                                "name": "example"
                                },
                                "Blocks": [],
                                "line_range": {
                                "endLine": 17,
                                "startLine": 1
                                }
                                }
                            ]
    count(result) == 1
}
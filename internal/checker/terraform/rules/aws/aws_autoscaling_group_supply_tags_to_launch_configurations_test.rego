package lib.terraform.CB_TFAWS_146
import rego.v1

test_aws_autoscaling_group_supply_tags_to_launch_configurations_passed if {
    result := passed with input as [
                                   {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_autoscaling_group",
                                    "example_group"
                                    ],
                                    "Attributes": {
                                    "tags": "    [\n      {\n        key                 = \"interpolation1\"\n        value               = \"value3\"\n        propagate_at_launch = true\n      },\n     \n    ]\n"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 14,
                                    "startLine": 1
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_autoscaling_group_supply_tags_to_launch_configurations_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_autoscaling_group",
                                    "example_group"
                                    ],
                                    "Attributes": {
                                    
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 14,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}

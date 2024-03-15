package lib.cloudformation.CB_CFT_047

test_ecs_cluster_settings_enabled_pass {
    result := passed with input as {
        "Resources": {
            "ECSCluster": {
                "Type": "AWS::ECS::Cluster",
                "Properties": {
                    "ClusterSettings": [
                        {
                            "Name": "containerInsights",
                            "Value": "enabled"
                        }
                    ],                  
                }
            }
        }
    }
    count(result) == 1
}

test_ecs_cluster_settings_not_enabled_fail {
    result := failed with input as {
        "Resources": {
            "ECSCluster": {
                "Type": "AWS::ECS::Cluster",
                "Properties": {
                    "ClusterSettings": [
                        {
                            "Name": "containerInsights",
                            "Value": "disabled"
                        }
                    ],                  
                }
            }
        }
    }
    count(result) == 1
}

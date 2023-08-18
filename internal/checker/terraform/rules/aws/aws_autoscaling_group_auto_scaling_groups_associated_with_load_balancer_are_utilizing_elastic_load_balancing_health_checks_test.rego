package lib.terraform.CB_TFAWS_348

test_aws_autoscaling_group_auto_scaling_groups_associated_with_load_balancer_are_utilizing_elastic_load_balancing_health_checks_passed {
    result := passed with input as [
                                   {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_autoscaling_group",
                                    "autoscalling_ok"
                                    ],
                                    "Attributes": {
                                    "desired_capacity": "4",
                                    "force_delete": true,
                                    "health_check_grace_period": "300",
                                    "health_check_type": "ELB",
                                    "max_size": "5",
                                    "min_size": "2"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "lifecycle",
                                        "Labels": [],
                                        "Attributes": {
                                        "ignore_changes": "load_balancers"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 11,
                                        "startLine": 9
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 12,
                                    "startLine": 1
                                    }
                                    },
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_autoscaling_attachment",
                                    "test_ok_attachment"
                                    ],
                                    "Attributes": {
                                    "autoscaling_group_name": "aws_autoscaling_group.autoscalling_ok.name",
                                    "elb": "aws_elb.test_ok.name"
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 17,
                                    "startLine": 14
                                    }
                                    },
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elb",
                                    "test_ok"
                                    ],
                                    "Attributes": {
                                    "availability_zones": [
                                        "us-west-2a",
                                        "us-west-2b",
                                        "us-west-2c"
                                    ],
                                    "connection_draining": true,
                                    "connection_draining_timeout": "400",
                                    "cross_zone_load_balancing": true,
                                    "idle_timeout": "400",
                                    "instances": "aws_instance.foo.id",
                                    "name": "foobar-terraform-elb",
                                    "tags": {
                                        "Name": "foobar-terraform-elb"
                                    }
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "access_logs",
                                        "Labels": [],
                                        "Attributes": {
                                        "bucket": "foo",
                                        "bucket_prefix": "bar",
                                        "interval": "60"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 27,
                                        "startLine": 23
                                        }
                                    },
                                    {
                                        "Type": "listener",
                                        "Labels": [],
                                        "Attributes": {
                                        "instance_port": "8000",
                                        "instance_protocol": "http",
                                        "lb_port": "80",
                                        "lb_protocol": "http"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 34,
                                        "startLine": 29
                                        }
                                    },
                                    {
                                        "Type": "listener",
                                        "Labels": [],
                                        "Attributes": {
                                        "instance_port": "8000",
                                        "instance_protocol": "http",
                                        "lb_port": "443",
                                        "lb_protocol": "https",
                                        "ssl_certificate_id": "arn:aws:iam::123456789012:server-certificate/certName"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 42,
                                        "startLine": 36
                                        }
                                    },
                                    {
                                        "Type": "health_check",
                                        "Labels": [],
                                        "Attributes": {
                                        "healthy_threshold": "2",
                                        "interval": "30",
                                        "target": "HTTP:8000/",
                                        "timeout": "3",
                                        "unhealthy_threshold": "2"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 50,
                                        "startLine": 44
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 61,
                                    "startLine": 19
                                    }
                                    }
                                ]
    count(result) == 1
}

test_aws_autoscaling_group_auto_scaling_groups_associated_with_load_balancer_are_utilizing_elastic_load_balancing_health_checks_failed {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_autoscaling_group",
                                    "autoscalling_ok"
                                    ],
                                    "Attributes": {
                                    "desired_capacity": "4",
                                    "force_delete": true,
                                    "health_check_grace_period": "300",
                                    "health_check_type": "ELB",
                                    "max_size": "5",
                                    "min_size": "2"
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "lifecycle",
                                        "Labels": [],
                                        "Attributes": {
                                        "ignore_changes": "load_balancers"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 11,
                                        "startLine": 9
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 12,
                                    "startLine": 1
                                    }
                                    },
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_autoscaling_attachment",
                                    "test_ok_attachment"
                                    ],
                                    "Attributes": {                                   
                                    "elb": ""
                                    },
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 17,
                                    "startLine": 14
                                    }
                                    },
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_elb",
                                    "test_ok"
                                    ],
                                    "Attributes": {
                                    "availability_zones": [
                                        "us-west-2a",
                                        "us-west-2b",
                                        "us-west-2c"
                                    ],
                                    "connection_draining": true,
                                    "connection_draining_timeout": "400",
                                    "cross_zone_load_balancing": true,
                                    "idle_timeout": "400",
                                    "instances": "aws_instance.foo.id",
                                    "name": "foobar-terraform-elb",
                                    "tags": {
                                        "Name": "foobar-terraform-elb"
                                    }
                                    },
                                    "Blocks": [
                                    {
                                        "Type": "access_logs",
                                        "Labels": [],
                                        "Attributes": {
                                        "bucket": "foo",
                                        "bucket_prefix": "bar",
                                        "interval": "60"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 27,
                                        "startLine": 23
                                        }
                                    },
                                    {
                                        "Type": "listener",
                                        "Labels": [],
                                        "Attributes": {
                                        "instance_port": "8000",
                                        "instance_protocol": "http",
                                        "lb_port": "80",
                                        "lb_protocol": "http"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 34,
                                        "startLine": 29
                                        }
                                    },
                                    {
                                        "Type": "listener",
                                        "Labels": [],
                                        "Attributes": {
                                        "instance_port": "8000",
                                        "instance_protocol": "http",
                                        "lb_port": "443",
                                        "lb_protocol": "https",
                                        "ssl_certificate_id": "arn:aws:iam::123456789012:server-certificate/certName"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 42,
                                        "startLine": 36
                                        }
                                    },
                                    {
                                        "Type": "",
                                        "Labels": [],
                                        "Attributes": {
                                        "healthy_threshold": "2",
                                        "interval": "30",
                                        "target": "HTTP:8000/",
                                        "timeout": "3",
                                        "unhealthy_threshold": "2"
                                        },
                                        "Blocks": [],
                                        "line_range": {
                                        "endLine": 50,
                                        "startLine": 44
                                        }
                                    }
                                    ],
                                    "line_range": {
                                    "endLine": 61,
                                    "startLine": 19
                                    }
                                    }
                            ]
    count(result) == 1
}

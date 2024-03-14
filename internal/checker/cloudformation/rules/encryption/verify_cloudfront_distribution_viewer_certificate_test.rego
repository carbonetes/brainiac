package lib.cloudformation.CB_CFT_109

test_verify_cloudfront_distribution_viewer_certificate_tlsv1_2 {
    result := passed with input as {"Resources": {
        "MyCloudFrontDistribution": {
            "Type": "AWS::CloudFront::Distribution",
            "Properties": {
                "DistributionConfig": {
                    "Origins": [
                        {
                            "Id": "MyS3Origin",
                            "DomainName": "my-s3-bucket.s3.amazonaws.com",
                            "S3OriginConfig": {
                                "OriginAccessIdentity": ""
                            }
                        }
                    ],
                    "Enabled": true,
                    "DefaultRootObject": "index.html",
                    "ViewerCertificate": {
                        "CloudFrontDefaultCertificate": true,
                        "MinimumProtocolVersion": "TLSv1.2_2021"
                    },
                    "DefaultCacheBehavior": {
                        "TargetOriginId": "MyS3Origin",
                        "ForwardedValues": {
                            "QueryString": false,
                            "Cookies": {
                                "Forward": "none"
                            }
                        },
                        "ViewerProtocolPolicy": "redirect-to-https"
                    }
                }
            }
        }
    }
}
        count(result) == 1
}

test_verify_cloudfront_distribution_viewer_certificate_not_tlsv1_2 {
    result := failed with input as {"Resources": {
        "MyCloudFrontDistribution": {
            "Type": "AWS::CloudFront::Distribution",
            "Properties": {
                "DistributionConfig": {
                    "Origins": [
                        {
                            "Id": "MyS3Origin",
                            "DomainName": "my-s3-bucket.s3.amazonaws.com",
                            "S3OriginConfig": {
                                "OriginAccessIdentity": ""
                            }
                        }
                    ],
                    "Enabled": true,
                    "DefaultRootObject": "index.html",
                    "ViewerCertificate": {
                        "CloudFrontDefaultCertificate": true,
                        "MinimumProtocolVersion": "TLSv1"
                    },
                    "DefaultCacheBehavior": {
                        "TargetOriginId": "MyS3Origin",
                        "ForwardedValues": {
                            "QueryString": false,
                            "Cookies": {
                                "Forward": "none"
                            }
                        },
                        "ViewerProtocolPolicy": "redirect-to-https"
                    }
                }
            }
        }
    }
}
        count(result) == 1
}
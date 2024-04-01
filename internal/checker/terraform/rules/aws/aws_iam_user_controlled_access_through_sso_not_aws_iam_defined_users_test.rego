package lib.terraform.CB_TFAWS_249

import rego.v1

# test_aws_iam_user_controlled_access_through_sso_not_aws_iam_defined_users_passed {
#     result := passed with input as [
#                                     {
#                                     "Type": "resource",
#                                     "Labels": [
#                                     "aws_other_resource",
#                                     "example"
#                                     ],
#                                     "Attributes": {},
#                                     "Blocks": [],
#                                     "line_range": {
#                                     "endLine": 3,
#                                     "startLine": 1
#                                     }
#                                     }
#                                 ]
#     count(result) == 0
# }

test_aws_iam_user_controlled_access_through_sso_not_aws_iam_defined_users_failed if {
result := failed with input as [
                                    {
                                    "Type": "resource",
                                    "Labels": [
                                    "aws_iam_user",
                                    "example"
                                    ],
                                    "Attributes": {},
                                    "Blocks": [],
                                    "line_range": {
                                    "endLine": 3,
                                    "startLine": 1
                                    }
                                    }
                            ]
    count(result) == 1
}

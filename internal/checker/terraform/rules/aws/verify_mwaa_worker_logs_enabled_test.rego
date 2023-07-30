package lib.terraform.CB_TFAWS_271

test_verify_mwaa_scheduler_logs_enabled_passed {
	result := passed with input as [
									{
										"Type": "resource",
										"Labels": [
											"aws_mwaa_environment",
											"pass"
										],
										"Attributes": {},
										"Blocks": [
											{
												"Type": "logging_configuration",
												"Labels": [],
												"Attributes": {},
												"Blocks": [
													{
														"Type": "worker_logs",
														"Labels": [],
														"Attributes": {
															"enabled": true
														},
														"Blocks": [],
														"line_range": {
															"endLine": 5,
															"startLine": 3
														}
													}
												],
												"line_range": {
													"endLine": 6,
													"startLine": 2
												}
											}
										],
										"line_range": {
											"endLine": 7,
											"startLine": 1
										}
									}
								]
	count(result) == 1
}

test_verify_mwaa_scheduler_logs_enabled_failed {
	result := failed with input as [
									{
										"Type": "resource",
										"Labels": [
											"aws_mwaa_environment",
											"pass"
										],
										"Attributes": {},
										"Blocks": [
											{
												"Type": "logging_configuration",
												"Labels": [],
												"Attributes": {},
												"Blocks": [
													{
														"Type": "worker_logs",
														"Labels": [],
														"Attributes": {
															"enabled": false
														},
														"Blocks": [],
														"line_range": {
															"endLine": 5,
															"startLine": 3
														}
													}
												],
												"line_range": {
													"endLine": 6,
													"startLine": 2
												}
											}
										],
										"line_range": {
											"endLine": 7,
											"startLine": 1
										}
									}
								]
	count(result) == 1
}

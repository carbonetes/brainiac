package lib.azurearm.CB_AZR_061

test_azr_data_factory_uses_git_repo_pass {
	result := passed with input as {
        "resources": [
             {
                "type": "Microsoft.DataFactory/factories",
                "apiVersion": "2018-06-01",
                "properties": {
                    "repoConfiguration": {
                        "type": "FactoryVSTSConfiguration"
                    }
                }
            }
        ]
}
	count(result) == 1
}

test_azr_data_factory_uses_git_repo_fail {
	result := failed with input as {
        "resources": [
            {
                "type": "Microsoft.DataFactory/factories",
                "apiVersion": "2018-06-01",
                "properties": {
                    "repoConfiguration": {
                        "type": ""
                    }
                }
            }
        ]
    }
	count(result) == 1
}

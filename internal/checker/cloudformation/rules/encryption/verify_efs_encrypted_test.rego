package lib.cloudformation.CB_CFT_028

test_efs_is_encrypted_securely {
    result := passed with input as {
        "Resources": {
            "MyEFSFileSystem": {
                "Type": "AWS::EFS::FileSystem",
                "Properties": {
                    "Encrypted": true
                }
            }
        }
    }
    count(result) == 1
}

test_efs_is_not_encrypted_securely {
    result := failed with input as {
        "Resources": {
            "MyEFSFileSystem": {
                "Type": "AWS::EFS::FileSystem",
                "Properties": {
                    "Encrypted": false
                }
            }
        }
    }
    count(result) == 1
}

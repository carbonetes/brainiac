package lib.cloudformation.CB_CFT_029

test_kinesis_stream_is_encrypted_securely_pass{
    result := passed with input as {
        "Resources": {
            "MyKinesisStream": {
                "Type": "AWS::Kinesis::Stream",
                "Properties": {
                    "StreamEncryption": {
                        "EncryptionType": "KMS"
                    }
                }
            }
        }
    }
    count(result) == 1
}

test_kinesis_stream_is_encrypted_securely_fail{
    result := failed with input as {
        "Resources": {
            "MyKinesisStream": {
                "Type": "AWS::Kinesis::Stream",
                "Properties": {
                    "StreamEncryption": {
                        "EncryptionType": "NotKMS"
                    }
                }
            }
        }
    }
    count(result) == 1
}

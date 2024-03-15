package lib.cloudformation.CB_CFT_088
test_verify_dynamo_db_encrypted_with_kms {
    result := passed with input as {"Resources": {
    "MyDynamoDBTab11le": {
      "Type": "AWS::DynamoDB::Table",
      "Properties": {
        "AttributeDefinitions": [
          {
            "AttributeName": "YourPrimaryKey",
            "AttributeType": "S"
          }
        ],
        "KeySchema": [
          {
            "AttributeName": "YourPrimaryKey",
            "KeyType": "HASH"
          }
        ],
        "ProvisionedThroughput": {
          "ReadCapacityUnits": 5,
          "WriteCapacityUnits": 5
        },
        "SSESpecification": {
          "SSEEnabled": true,
          "KMSMasterKeyId": "your-cmk-arn"
        }
      }
    }
  }
}
        count(result) == 1
}

test_verify_dynamo_db_not_encrypted_with_kms {
    result := failed with input as {"Resources": {
    "MyDynamoDBTab11le": {
      "Type": "AWS::DynamoDB::Table",
      "Properties": {
        "AttributeDefinitions": [
          {
            "AttributeName": "YourPrimaryKey",
            "AttributeType": "S"
          }
        ],
        "KeySchema": [
          {
            "AttributeName": "YourPrimaryKey",
            "KeyType": "HASH"
          }
        ],
        "ProvisionedThroughput": {
          "ReadCapacityUnits": 5,
          "WriteCapacityUnits": 5
        },
        "SSESpecification": {
        }
      }
    }
  }
}
        count(result) == 1
}
package lib.cloudformation.CB_CFT_018

test_verify_dynamodb_table_recovery_enabled {
    result := passed with input as {"Resources": {
    "MyDynamoDBTable": {
      "Type": "AWS::DynamoDB::Table",
      "Properties": {
        "TableName": "MyTable",
        "AttributeDefinitions": [
          {
            "AttributeName": "PrimaryKey",
            "AttributeType": "S"
          }
        ],
        "KeySchema": [
          {
            "AttributeName": "PrimaryKey",
            "KeyType": "HASH"
          }
        ],
        "ProvisionedThroughput": {
          "ReadCapacityUnits": 5,
          "WriteCapacityUnits": 5
        },
        "PointInTimeRecoverySpecification": {
          "PointInTimeRecoveryEnabled": true
        }
      }
    }
  }
}
        count(result) == 1
}

test_verify_dynamodb_table_recovery_disabled {
    result := failed with input as {"Resources": {
    "MyDynamoDBTable": {
      "Type": "AWS::DynamoDB::Table",
      "Properties": {
        "TableName": "MyTable",
        "AttributeDefinitions": [
          {
            "AttributeName": "PrimaryKey",
            "AttributeType": "S"
          }
        ],
        "KeySchema": [
          {
            "AttributeName": "PrimaryKey",
            "KeyType": "HASH"
          }
        ],
        "ProvisionedThroughput": {
          "ReadCapacityUnits": 5,
          "WriteCapacityUnits": 5
        },
        "PointInTimeRecoverySpecification": {
        }
      }
    }
  }
}
        count(result) == 1
}
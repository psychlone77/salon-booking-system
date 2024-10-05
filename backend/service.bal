import ballerina/io;
import ballerinax/aws.dynamodb;

configurable string ACCESS_KEY_ID = ?;
configurable string SECRET_ACCESS_KEY = ?;

dynamodb:ConnectionConfig amazonDynamodbConfig = {
        awsCredentials: {
            accessKeyId: ACCESS_KEY_ID,
            secretAccessKey: SECRET_ACCESS_KEY
        },
        region: "us-east-1"
    };

public function createUser(User User) returns record{} | error {

    dynamodb:Client amazonDynamodbClient = check new (amazonDynamodbConfig);

    dynamodb:ItemCreateInput createItemInput = {
        TableName: "sbs_users",
        Item: {
            "UserName": {"S": User.UserName},
            "Password": {"S": User.Password},
            "Email": {"S": User.Email},
            "FirstName": {"S": User.FirstName},
            "LastName": {"S": User.LastName},
            "PhoneNumber": {"S": User.PhoneNumber}
        }
    };
    dynamodb:ItemDescription createItemResult = check amazonDynamodbClient->createItem(createItemInput);
    io:println("Added item: ", createItemResult);
    return createItemResult;
}

public function getUser(UserID UserID) returns record{} | error {
    dynamodb:Client amazonDynamodbClient = check new (amazonDynamodbConfig);

    dynamodb:ItemGetInput getItemInput = {
        TableName: "sbs_users",
        Key: {
            "UserName": {"S": UserID.UserName},
            "Email": {"S": UserID.Email}
        }
    };
    dynamodb:ItemGetOutput getItemResult = check amazonDynamodbClient->getItem(getItemInput);
    io:println("Item: ", getItemResult);
    return getItemResult;
}

public function updateUser(User User) returns record{} | error {
    dynamodb:Client amazonDynamodbClient = check new (amazonDynamodbConfig);

    dynamodb:ItemUpdateInput updateItemInput = {
        TableName: "sbs_users",
        Key: {
            "UserName": {"S": User.UserName},
            "Email": {"S": User.Email}
        },
        UpdateExpression: "SET FirstName = :fn, LastName = :ln, PhoneNumber = :pn, Password = :pw",
        ExpressionAttributeValues: {
            ":fn": {"S": User.FirstName},
            ":ln": {"S": User.LastName},
            ":pn": {"S": User.PhoneNumber},
            ":pw": {"S": User.Password}
        }
    };
    dynamodb:ItemDescription updateItemResult = check amazonDynamodbClient->updateItem(updateItemInput);
    io:println("Updated item: ", updateItemResult);
    return updateItemResult;
}

public function deleteUser(UserID UserID) returns record{} | error {
    dynamodb:Client amazonDynamodbClient = check new (amazonDynamodbConfig);

    dynamodb:ItemDeleteInput deleteItemInput = {
        TableName: "sbs_users",
        Key: {
            "UserName": {"S": UserID.UserName},
            "Email": {"S": UserID.Email}
        }
    };
    dynamodb:ItemDescription deleteItemResult = check amazonDynamodbClient->deleteItem(deleteItemInput);
    io:println("Deleted item: ", deleteItemResult);
    return deleteItemResult;

}

public function getAllUsers() returns stream<anydata, error?>|error {
    dynamodb:Client amazonDynamodbClient = check new (amazonDynamodbConfig);

    dynamodb:ScanInput scanInput = {
        TableName: "sbs_users"
    };
    stream<dynamodb:ScanOutput, error?>|error scanResult = check amazonDynamodbClient->scan(scanInput);
    // io:println("Items: ", scanResult);
    
    return scanResult;

}


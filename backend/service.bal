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
dynamodb:Client amazonDynamodbClient = check new (amazonDynamodbConfig);


public function createUser(User User) returns record{} | error {
    dynamodb:ItemCreateInput createItemInput = {
        TableName: "sbs_users",
        Item: {
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
    dynamodb:ItemGetInput getItemInput = {
        TableName: "sbs_users",
        Key: {
            "Email": {"S": UserID.Email}
        }
    };
    dynamodb:ItemGetOutput getItemResult = check amazonDynamodbClient->getItem(getItemInput);
    io:println("Item: ", getItemResult);
    return getItemResult;
}

public function updateUser(User User) returns record{} | error {
    dynamodb:ItemUpdateInput updateItemInput = {
        TableName: "sbs_users",
        Key: {
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
    dynamodb:ItemDeleteInput deleteItemInput = {
        TableName: "sbs_users",
        Key: {
            "Email": {"S": UserID.Email}
        }
    };
    dynamodb:ItemDescription deleteItemResult = check amazonDynamodbClient->deleteItem(deleteItemInput);
    io:println("Deleted item: ", deleteItemResult);
    return deleteItemResult;

}

public function getAllUsers() returns json[] {
    dynamodb:ScanInput scanInput = {TableName: "sbs_users"};
        stream<dynamodb:ScanOutput, error?>|error scanResult = amazonDynamodbClient->scan(scanInput);
        if (scanResult is stream<dynamodb:ScanOutput, error?>) {
            json[]|error list = from var item in scanResult
                                select item.toJson();
            if (list is json[]) {
                return list;
            }
        }
    return [];
}

public function createSalon(Salon Salon) returns record{} | error {
    dynamodb:ItemCreateInput createItemInput = {
        TableName: "sbs_salons",
        Item: {
            "Email": {"S": Salon.Email},
            "Password": {"S": Salon.Password},
            "SalonName": {"S": Salon.SalonName},
            "Address": {"S": Salon.Address},
            "PhoneNumber": {"S": Salon.PhoneNumber},
            "Description": {"S": Salon.Description},
            "Image": {"S": Salon.Image}
        }
    };
    dynamodb:ItemDescription createItemResult = check amazonDynamodbClient->createItem(createItemInput);
    io:println("Added item: ", createItemResult);
    return createItemResult;
}

public function getSalon(SalonID SalonID) returns record{} | error {
    dynamodb:ItemGetInput getItemInput = {
        TableName: "sbs_salons",
        Key: {
            "Email": {"S": SalonID.Email}
        }
    };
    dynamodb:ItemGetOutput getItemResult = check amazonDynamodbClient->getItem(getItemInput);
    io:println("Item: ", getItemResult);
    return getItemResult;
}

public function updateSalon(Salon Salon) returns record{} | error {
    dynamodb:ItemUpdateInput updateItemInput = {
        TableName: "sbs_salons",
        Key: {
            "Email": {"S": Salon.Email}
        },
        UpdateExpression: "SET SalonName = :n, Address = :a, PhoneNumber = :pn, Description = :d, Image = :i, Password = :pw",
        ExpressionAttributeValues: {
            ":n": {"S": Salon.SalonName},
            ":a": {"S": Salon.Address},
            ":pn": {"S": Salon.PhoneNumber},
            ":d": {"S": Salon.Description},
            ":i": {"S": Salon.Image},
            ":pw": {"S": Salon.Password}
        }
    };
    dynamodb:ItemDescription updateItemResult = check amazonDynamodbClient->updateItem(updateItemInput);
    io:println("Updated item: ", updateItemResult);
    return updateItemResult;
}

public function deleteSalon(SalonID SalonID) returns record{} | error {
    dynamodb:ItemDeleteInput deleteItemInput = {
        TableName: "sbs_salons",
        Key: {
            "Email": {"S": SalonID.Email}
        }
    };
    dynamodb:ItemDescription deleteItemResult = check amazonDynamodbClient->deleteItem(deleteItemInput);
    io:println("Deleted item: ", deleteItemResult);
    return deleteItemResult;

}

public function getAllSalons() returns json[] {
    dynamodb:ScanInput scanInput = {TableName: "sbs_salons"};
        stream<dynamodb:ScanOutput, error?>|error scanResult = amazonDynamodbClient->scan(scanInput);
        if (scanResult is stream<dynamodb:ScanOutput, error?>) {
            json[]|error list = from var item in scanResult
                                select item.toJson();
            if (list is json[]) {
                return list;
            }
        }
    return [];
}

public function getBookingsBySalon(string SalonEmail) returns json[] {
    dynamodb:ScanInput scanInput = {
        TableName: "sbs_booking",
        FilterExpression: "SalonEmail = :se",
        ExpressionAttributeValues: {
            ":se": {"S": SalonEmail}
        }
    };
    stream<dynamodb:ScanOutput, error?>|error scanResult = amazonDynamodbClient->scan(scanInput);
    if (scanResult is stream<dynamodb:ScanOutput, error?>) {
        json[]|error list = from var item in scanResult
                            select item.toJson();
        if (list is json[]) {
            return list;
        }
    }
    return [];
}

public function createBooking(Booking Booking) returns record{} | error {
    dynamodb:ItemCreateInput createItemInput = {
        TableName: "sbs_booking",
        Item: {
            "BookingID": {"S": Booking.BookingID.toString()},
            "UserEmail": {"S": Booking.UserEmail},
            "SalonEmail": {"S": Booking.SalonEmail},
            "BookingDate": {"S": Booking.BookingDate},
            "BookingTime": {"S": Booking.BookingTime},
            "BookingService": {"S": Booking.BookingService},
            "BookingStatus": {"S": Booking.BookingStatus}
        }
    };
    dynamodb:ItemDescription createItemResult = check amazonDynamodbClient->createItem(createItemInput);
    io:println("Added item: ", createItemResult);
    return createItemResult;
}   

public function getAllBookings() returns json[] {
    dynamodb:ScanInput scanInput = {TableName: "sbs_booking"};
        stream<dynamodb:ScanOutput, error?>|error scanResult = amazonDynamodbClient->scan(scanInput);
        if (scanResult is stream<dynamodb:ScanOutput, error?>) {
            json[]|error list = from var item in scanResult
                                select item.toJson();
            if (list is json[]) {
                return list;
            }
        }
    return [];
}

public function getBookingsByUser(string UserEmail) returns json[] {
    dynamodb:ScanInput scanInput = {
        TableName: "sbs_booking",
        FilterExpression: "UserEmail = :ue",
        ExpressionAttributeValues: {
            ":ue": {"S": UserEmail}
        }
    };
    stream<dynamodb:ScanOutput, error?>|error scanResult = amazonDynamodbClient->scan(scanInput);
    if (scanResult is stream<dynamodb:ScanOutput, error?>) {
        json[]|error list = from var item in scanResult
                            select item.toJson();
        if (list is json[]) {
            return list;
        }
    }
    return [];
}



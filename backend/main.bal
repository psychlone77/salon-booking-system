import ballerina/io;
import ballerina/http;
import ballerina/persist as _;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
service /users on new http:Listener(9090) {

    resource function post create(@http:Payload User User) returns json|http:InternalServerError {
        record {} response = {};
        record {} | error NewUser = createUser(User);
        if (NewUser is record {}) {
            io:println("Item: ", NewUser);
            return NewUser.toJson();
        } else {
            return response.toJson();

        }

    }

    resource function get all() returns json|http:InternalServerError {
        stream<anydata, error?>|error items = getAllUsers();
        anydata [] itemsArray = [];
        if (items is stream<anydata, error?>) {
            error? e = items.forEach(function (anydata item) {
                itemsArray.push(item);
            });

            if (e is error) {
                return itemsArray.toJson();
            } else {
                return itemsArray.toJson();
            }
            }

    }

    resource function post get(@http:Payload UserID UserID) returns json|http:InternalServerError {
        record {} response = {};
        record {} | error NewUser = getUser(UserID);
        if (NewUser is record {}) {
            io:println("Item: ", NewUser);
            return NewUser.toJson();
        } else {
            return response.toJson();

        }

    }

    resource function put update(@http:Payload User User) returns json|http:InternalServerError {
        record {} response = {};
        record {} | error NewUser = updateUser(User);
        if (NewUser is record {}) {
            io:println("Item: ", NewUser);
            return NewUser.toJson();
        } else {
            return response.toJson();

        }

    }

    resource function delete delete(@http:Payload UserID UserID) returns json|http:InternalServerError {
        record {} response = {};
        record {} | error NewUser = deleteUser(UserID);
        if (NewUser is record {}) {
            io:println("Item: ", NewUser);
            return NewUser.toJson();
        } else {
            return response.toJson();

        }

    }
}
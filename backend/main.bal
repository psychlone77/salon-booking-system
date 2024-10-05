import ballerina/io;
import ballerina/http;
import ballerina/persist as _;

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}


service /users on new http:Listener(9090) {
    resource function post authenticate(@http:Payload UserLogin UserLogin) returns http:Response|http:Unauthorized {
        http:Response response = new();
        UserID UserID = {UserName: UserLogin.UserName, Email: UserLogin.Email};
        record {} | error User = getUser(UserID);
        if (User is record {}) {
            if (User.toJson().Item.Password.S == UserLogin.Password) {
                io:println("Login success");
                response.setJsonPayload({
                    "status" : "Success",
                    "token" : "jwt_token"
                });
                http:Cookie Cookie = new(name = "token", value = "adsfasdf;jk");
                response.addCookie(Cookie);
                response.statusCode = http:STATUS_OK;
                return response;
            } else {
                io:println("Login failed");
                return http:UNAUTHORIZED;
            }
        } else {
            io:println("Login failed");
            return http:UNAUTHORIZED;
        }

    }

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
        (json|error) [] response = [];
        foreach json i in getAllUsers() {
            response.push(i.Item);
        }
        return response.toBalString().toJson();

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
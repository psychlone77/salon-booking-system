import ballerina/io;
import ballerina/http;
import ballerina/crypto;
import ballerina/jwt;
import ballerina/persist as _;


@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}


service /users on new http:Listener(9090) {
    resource function post authenticate(@http:Payload UserLogin UserLogin) returns http:Response|http:Unauthorized {
        http:Response response = new();
        UserID UserID = {Email: UserLogin.Email};
        record {} | error User = getUser(UserID);
        byte[] hash = crypto:hashSha512(UserLogin.Password.toBytes());
        if (User is record {}) {
            if (User.toJson().Item.Password.S == hash.toString()) {
                io:println("Login success");
                jwt:IssuerConfig issuerConfig = {
                    username: UserLogin.Email,
                    issuer: "sbs",
                    audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
                    expTime: 3600
                };
                string|error jwt = jwt:issue(issuerConfig);
                
                if (jwt is string) {
                    response.setHeader("Authorization", "Bearer " + jwt);
                    http:Cookie Cookie = new(name = "token", value = jwt);
                    response.addCookie(Cookie);
                }
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
        byte[] hash = crypto:hashSha512(User.Password.toBytes());
        User.Password = hash.toString();
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
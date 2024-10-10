import ballerina/io;
import ballerina/http;
import ballerina/crypto;
import ballerina/jwt;
import ballerina/uuid;
import ballerina/persist as _;


@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}


service / on new http:Listener(9090) {
    resource function post users/authenticate(@http:Payload UserLogin UserLogin) returns http:Response|http:Unauthorized {
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

    resource function post users(@http:Payload User User) returns json|http:InternalServerError {
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

    resource function get users() returns json|http:InternalServerError {
        (json|error) [] response = [];
        foreach json i in getAllUsers() {
            response.push(i.Item);
        }
        return response.toBalString().toJson();

    }

    resource function post users/id(@http:Payload UserID UserID) returns json|http:InternalServerError {
        record {} response = {};
        record {} | error NewUser = getUser(UserID);
        if (NewUser is record {}) {
            io:println("Item: ", NewUser);
            return NewUser.toJson();
        } else {
            return response.toJson();

        }

    }

    resource function put users(@http:Payload User User) returns json|http:InternalServerError {
        record {} response = {};
        record {} | error NewUser = updateUser(User);
        if (NewUser is record {}) {
            io:println("Item: ", NewUser);
            return NewUser.toJson();
        } else {
            return response.toJson();

        }

    }

    resource function delete users(@http:Payload UserID UserID) returns json|http:InternalServerError {
        record {} response = {};
        record {} | error NewUser = deleteUser(UserID);
        if (NewUser is record {}) {
            io:println("Item: ", NewUser);
            return NewUser.toJson();
        } else {
            return response.toJson();

        }

    }

    resource function get salons() returns json|http:InternalServerError {
        (json|error) [] response = [];
        foreach json i in getAllSalons() {
            response.push(i.Item);
        }
        return response.toBalString().toJson();

    }

    resource function post salons(@http:Payload Salon Salon) returns json|http:InternalServerError {
        record {} response = {};
        byte[] hash = crypto:hashSha512(Salon.Password.toBytes());
        Salon.Password = hash.toString();
        record {} | error NewSalon = createSalon(Salon);
        if (NewSalon is record {}) {
            io:println("Item: ", NewSalon);
            return NewSalon.toJson();
        } else {
            return response.toJson();

        }

    }

    resource function post salons/authenticate(@http:Payload SalonLogin SalonLogin) returns http:Response|http:Unauthorized {
        http:Response response = new();
        SalonID SalonID = {Email: SalonLogin.Email};
        record {} | error Salon = getSalon(SalonID);
        byte[] hash = crypto:hashSha512(SalonLogin.Password.toBytes());
        if (Salon is record {}) {
            if (Salon.toJson().Item.Password.S == hash.toString()) {
                io:println("Login success");
                jwt:IssuerConfig issuerConfig = {
                    username: SalonLogin.Email,
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

    resource function post salons/id(@http:Payload SalonID SalonID) returns json|http:InternalServerError {
        record {} response = {};
        record {} | error NewSalon = getSalon(SalonID);
        if (NewSalon is record {}) {
            io:println("Item: ", NewSalon);
            return NewSalon.toJson();
        } else {
            return response.toJson();

        }

    }

    resource function put salons(@http:Payload Salon Salon) returns json|http:InternalServerError {
        record {} response = {};
        byte[] hash = crypto:hashSha512(Salon.Password.toBytes());
        Salon.Password = hash.toString();
        record {} | error NewSalon = updateSalon(Salon);
        if (NewSalon is record {}) {
            io:println("Item: ", NewSalon);
            return NewSalon.toJson();
        } else {
            io:println("Item: ", NewSalon);
            return response.toJson();

        }

    }

    resource function delete salons(@http:Payload SalonID SalonID) returns json|http:InternalServerError {
        record {} response = {};
        record {} | error NewSalon = deleteSalon(SalonID);
        if (NewSalon is record {}) {
            io:println("Item: ", NewSalon);
            return NewSalon.toJson();
        } else {
            return response.toJson();

        }

    }

    resource function post bookings(@http:Payload Booking Booking) returns json|http:InternalServerError {
        record {} response = {};
        Booking.BookingID = uuid:createType1AsString();
        record {} | error NewBooking = createBooking(Booking);
        if (NewBooking is record {}) {
            io:println("Item: ", NewBooking);
            return NewBooking.toJson();
        } else {
            return response.toJson();

        }

    }

    resource function get bookings() returns json|http:InternalServerError {
        (json|error) [] response = [];
        foreach json i in getAllBookings() {
            response.push(i.Item);
        }
        return response.toBalString().toJson();

    }

    resource function post bookings/salon(@http:Payload BookingIDSalon BookingIDSalon) returns json|http:InternalServerError {
        (json|error) [] response = [];
        foreach json i in getBookingsBySalon(BookingIDSalon.SalonEmail) {
            response.push(i.Item);
        }
        return response.toBalString().toJson();

    }

    resource function post bookings/user(@http:Payload BookingIDUser BookingIDUser) returns json|http:InternalServerError {
        (json|error) [] response = [];
        foreach json i in getBookingsByUser(BookingIDUser.UserEmail) {
            response.push(i.Item);
        }
        return response.toBalString().toJson();

    }
    
    resource function put bookings(@http:Payload Booking Booking) returns json|http:InternalServerError {
        record {} response = {};
        record {} | error NewBooking = updateBooking(Booking);
        if (NewBooking is record {}) {
            io:println("Item: ", NewBooking);
            return NewBooking.toJson();
        } else {
            return response.toJson();

        }

    }

}

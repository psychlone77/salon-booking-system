import ballerina/http;
import ballerina/io;

# A service representing a network-accessible API
# bound to port `9090`.

public function main() {
    // Print a message indicating the server is up
    io:println("Server is up and running on http://localhost:9090");
}
service / on new http:Listener(9090) {

    # A resource for generating greetings
    # + name - name as a string or nil
    # + return - string name with hello message or error
    resource function get greeting(string? name) returns string|error {
        // Send a response back to the caller.
        if name is () {
            return error("name should not be empty!");
        }
        return string `Hello, ${name}`;
    }
}

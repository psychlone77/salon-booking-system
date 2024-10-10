import ballerina/persist as _;


public type User record {|
    string Password;
    string Email;
    string FirstName;
    string LastName;
    string PhoneNumber;
|};

public type UserID record {|
    string Email;
|};

public type UserLogin record {|
    string Email;
    string Password;
|};

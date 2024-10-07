import ballerina/persist as _;


public type User record {|
    string UserName;
    string Password;
    string Email;
    string FirstName;
    string LastName;
    string PhoneNumber;
|};

public type UserID record {|
    string UserName;
    string Email;
|};

public type UserLogin record {|
    string UserName;
    string Email;
    string Password;
|};

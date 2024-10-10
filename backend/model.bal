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

public type Salon record {|
    string Email;
    string Password;
    string SalonName;
    string Altitude;
    string Longtitude;
    string PhoneNumber;
    string Description;
    string Image;
|};

public type SalonID record {|
    string Email;
|};

public type SalonLogin record {|
    string Email;
    string Password;
|};

public type Booking record {|
    string BookingID;
    string UserEmail;
    string SalonEmail;
    string BookingDate;
    string BookingTime;
    string BookingService;
    string BookingStatus;
|};

public type BookingIDSalon record {|
    string SalonEmail;
|};

public type BookingIDUser record {|
    string UserEmail;
|};
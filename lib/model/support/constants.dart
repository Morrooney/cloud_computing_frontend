// general
const int MAX_NOP = 15;

// addresses

// WEB DEBUGGING
const String ADDRESS_STORE_SERVER = "localhost:8081";
const String ADDRESS_AUTHENTICATION_SERVER = "localhost:8080";



// authentication
const String REALM = "bookstore";
const String CLIENT_ID = "springboot-bookstore";
const String CLIENT_SECRET = "6f1867d4-bb84-4935-ad6b-1122a61f637a";
const String REQUEST_LOGIN = "/auth/realms/" + REALM + "/protocol/openid-connect/token";

const String REQUEST_LOGOUT =
    "/auth/realms/" + REALM + "/protocol/openid-connect/logout";

// requests



// responses
const String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS =
    "ERROR_MAIL_USER_ALREADY_EXISTS";

// docent
const String REQUEST_NEW_DOCENT = "/accounting/newDocent";
//student
const String REQUEST_NEW_STUDENT = "/accounting/newStudent";

// messages
const String MESSAGE_CONNECTION_ERROR = "connection_error";


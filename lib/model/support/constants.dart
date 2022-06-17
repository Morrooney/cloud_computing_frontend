// general
const int MAX_NOP = 15;

// addresses

// WEB DEBUGGING
const String ADDRESS_STORE_SERVER = "localhost:8081";
const String ADDRESS_AUTHENTICATION_SERVER = "localhost:8080";



// authentication
const String REALM = "cloudBackend";
const String CLIENT_ID = "springboot-cloudBackend";
const String CLIENT_SECRET = "a70edb84-59a5-43ad-882a-78548ae7947f";
const String REQUEST_LOGIN = "/auth/realms/" + REALM + "/protocol/openid-connect/token";

const String REQUEST_LOGOUT =
    "/auth/realms/" + REALM + "/protocol/openid-connect/logout";

// requests



// responses
const String RESPONSE_ERROR_MAIL_USER_ALREADY_EXISTS =
    "ERROR_MAIL_USER_ALREADY_EXISTS";

// docent
const String REQUEST_NEW_DOCENT = "/accounting/newDocent";
const String REQUEST_SEARCH_DOCENT_BY_EMAIL= "/Docent/showDocent";
const String REQUEST_SHOW_DOCENT_THESES = "/Docent/docentThesis";
//student
const String REQUEST_NEW_STUDENT = "/accounting/newStudent";
const String REQUEST_SEARCH_STUDENT_BY_EMAIL="/Student/showStudent" ;
const String REQUEST_SHOW_STUDENT_THESES = "/Student/studentThesis";

// messages
const String MESSAGE_CONNECTION_ERROR = "connection_error";


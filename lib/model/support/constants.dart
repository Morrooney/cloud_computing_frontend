// general
const int MAX_NOP = 15;

// addresses

// WEB DEBUGGING
const String ADDRESS_STORE_SERVER = "cloudbackend-env.eba-trfkdan4.us-west-1.elasticbeanstalk.com";
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
const String REQUEST_ADD_NEW_THESIS = "/Docent/newThesis";
const String REQUEST_ADD_SUPERVISOR = "/Docent/addSupervisor";
const String REQUEST_SEARCH_DOCENT = "/Docent/searchDocents";
const String REQUEST_ADD_NEW_DOCENT = "/Docent/newDocent";
const String REQUEST_ADD_NEW_STUDENT = "/Docent/newStudent";

//student
const String REQUEST_NEW_STUDENT = "/accounting/newStudent";
const String REQUEST_SEARCH_STUDENT_BY_EMAIL="/Student/showStudent" ;
const String REQUEST_SHOW_STUDENT_THESES = "/Student/studentThesis";
const String REQUEST_SEARCH_STUDENT = "/Student/searchStudents";

//message
const String REQUEST_SHOW_UNREAD_MESSAGE = "/Message/notifyMessage";
const String REQUEST_SHOW_MESSAGES_CONVERSATION = "/Message/showAllMessagesConversation";
const String REQUEST_SEND_MESSAGE = "/Message/send";
//File
const String REQUEST_UPLOAD_FILE = "api/v1/file";
const String REQUEST_DOWNLOAD_FILE = "api/v1/file/download";
//Thesis
const String REQUEST_SHOW_ALL_THESIS_FILES = "/Thesis/files";

// messages
const String MESSAGE_CONNECTION_ERROR = "connection_error";

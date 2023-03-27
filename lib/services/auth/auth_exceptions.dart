//used to make the ui some abstarct and make it some professional styl
//it is used to creat abstarct class and the ui access this abstarct class and use by callign insteady of defning in line  
//insteady of exposing exception on ui it is usefull to create an abstract class that implemnt another abstract class called Exception{}
////login exception
class UserNotFoundAuthException implements Exception{}


class WrongPasswordAuthException implements Exception{}


//signup exception

class WeakPasswordAuthException implements Exception{}

class EmailAlreadyInUseAuthException implements Exception{}

class InvalidEmailAuthException implements Exception{}

// generic exceptions for unknowun exception

class GenericAuthException implements Exception{}

class UserNotLoggedInAuthException implements Exception{}
 
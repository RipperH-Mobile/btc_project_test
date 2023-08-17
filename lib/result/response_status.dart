// ignore_for_file: constant_identifier_names

class ResultCode {
  static const SUCCESS = 0;
  static const VALIDATE = 1;
  static const SHOWPOPPUP = 2;
  static const SHOWDIALOG = 3;
}

enum EventResult {
  WAITING,
  NO_INTERNET,
  TIMEOUT,
  CONNECT_INTERNET,
  SERVICEUNAVAILABLE
}


import 'package:flutter/foundation.dart';

class URL {
  static const String DOMAIN_URL = "api-dev.shopbox.com";
  static const String BASE_URL = "https://" + DOMAIN_URL;
  static const String SERVICE_URL = BASE_URL + "/api/v3/";

  static String loginURL = "authenticate/credentials";
  static String getClientsURL = "clients";
  static String getClientBranches = "branches?";

  static String getURL({required String api}){
      return SERVICE_URL + api;
  }

}

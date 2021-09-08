import 'package:shopbox/data_providers/models/response_model.dart';
import 'package:shopbox/utilites/api_parse_key.dart';
import 'package:shopbox/utilites/parse_helpers.dart';

class User {
 late String userId, firstName , middleName , lastName , accessToken ;
 String? userPhoneNumber , title , code , languageCode;

 User({required this.userId , required this.firstName , required this.middleName ,  required this.lastName , required this.accessToken ,
 this.userPhoneNumber = "" , this.title = "" , this.code = "" , this.languageCode = "en"});

  static User fromJson(Map<String, dynamic> rawServerResponse) {
   var accountInformation = rawServerResponse[ApiParseKeys.account];
   return User(
    userId:  accountInformation[ApiParseKeys.id].toString(),
    lastName: accountInformation[ApiParseKeys.lastName],
    middleName: accountInformation[ApiParseKeys.middleName],
    firstName: accountInformation[ApiParseKeys.firstName],
    title: accountInformation[ApiParseKeys.title],
    languageCode: accountInformation[ApiParseKeys.lang],
    code: accountInformation[ApiParseKeys.code],
    userPhoneNumber: accountInformation[ApiParseKeys.mobile],
    accessToken: rawServerResponse[ApiParseKeys.accessToken],
   );
  }
}
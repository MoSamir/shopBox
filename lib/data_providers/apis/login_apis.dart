import 'package:shopbox/data_providers/models/response_model.dart';
import 'package:shopbox/data_providers/models/user.dart';
import 'package:shopbox/data_providers/urls.dart';
import 'package:shopbox/utilites/network_utilites.dart';

class LoginAPIs{
  static Future<ResponseModel<User>> login(String username , String userPassword) async {
    Map<String,dynamic> loginRequestBody = {
      "username" : username,
      "password" : userPassword
    };
    String loginLink = URL.getURL(api: URL.loginURL);
    ResponseModel loginResponse = await NetworkUtilities.handlePostRequest(methodURL: loginLink,
         requestBody: loginRequestBody,
         acceptJson: true,
         parserFunction: (Map<String,dynamic> rawServerResponse){
            return User.fromJson(rawServerResponse);
         });
    return ResponseModel<User>(
      isSuccess: loginResponse.isSuccess ,
      serverError: loginResponse.serverError,
      responseData: loginResponse.responseData
    );
  }
}
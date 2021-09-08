import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:shopbox/data_providers/models/error_model.dart';
import 'package:shopbox/data_providers/models/response_model.dart';
import 'package:shopbox/data_providers/urls.dart';
import 'package:shopbox/utilites/local_keys.dart';
import 'package:shopbox/utilites/constants.dart';
import 'package:shopbox/utilites/request_interceptor.dart';


class NetworkUtilities {

  static final http.Client client = InterceptedClient.build(interceptors: [RequestInterceptor()]);

  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup(
          URL.DOMAIN_URL)
          .timeout(Duration(seconds: 5), onTimeout: () {
        throw SocketException('');
      });
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
  



  static Future<ResponseModel <dynamic>> handleGetRequest({
    required String methodURL,
    required Function parserFunction}) async {
    ResponseModel  getResponse;
    try {
      var serverResponse = await client.get(Uri.parse(methodURL)).timeout(Duration(seconds: 20),onTimeout: (){
        throw SocketException;
      });
      if (serverResponse.statusCode == 200) {

        getResponse = ResponseModel(
          isSuccess: true,
          responseData: parserFunction(json.decode(serverResponse.body)),
        );
      }
      else {
        getResponse = handleError(serverResponse);
      }
    } on SocketException {
      getResponse = ResponseModel (
        isSuccess: false,
        serverError: Constants.connectionTimeoutException,
      );
    } catch (exception) {
      if(exception == SocketException){
        getResponse = ResponseModel (
          isSuccess: false,
          serverError: Constants.connectionTimeoutException,

        );
      } else {
        getResponse = ResponseModel (
          isSuccess: false,
          serverError: ErrorModel(
            errorMessage: '',
            errorCode: HttpStatus.serviceUnavailable,
          ),
        );
      }
    }

    return getResponse;
  }


  static Future<ResponseModel > handlePostRequest(
      { bool acceptJson = false,
        required String methodURL,
        required Map<String, dynamic> requestBody,
        required Function parserFunction}) async {
    ResponseModel  postResponse;
    try {
      http.Response serverResponse = await client.post(Uri.parse(methodURL),
          body: acceptJson ? json.encode(requestBody) : requestBody);
      if (serverResponse.statusCode < 300 &&   serverResponse.statusCode >= 200 ) {
        postResponse = ResponseModel (
          isSuccess: true,
          responseData : parserFunction(json.decode(serverResponse.body)),
        );
      } else if (serverResponse.statusCode == 201) {
        postResponse = ResponseModel (
          isSuccess: true,

          responseData : parserFunction(json.decode(serverResponse.body)),
        );
      }

      else {
        postResponse = handleError(serverResponse);
      }
    } on SocketException {
      postResponse = ResponseModel (
        isSuccess: false,
        serverError: Constants.connectionTimeoutException,

      );
    } catch (exception) {
      debugPrint("Exception in post => $exception");
      if(exception == SocketException){
        postResponse = ResponseModel (
          isSuccess: false,
          serverError: Constants.connectionTimeoutException,
        );
      } else {
        postResponse = ResponseModel (
          isSuccess: false,
          serverError: ErrorModel(
            errorMessage: '',
            errorCode: HttpStatus.serviceUnavailable,
          ),

        );
      }
    }

    return postResponse;
  }



  static ResponseModel  handleError(http.Response serverResponse) {

    ResponseModel  responseModel ;
    if (serverResponse.statusCode == HttpStatus.unprocessableEntity) {
      List<String> errors = [];
      try {
        (json.decode(serverResponse.body)['errors'] as Map<String, dynamic>)
            .forEach((key, value) {
          if (value is List<String>)
            errors.addAll(value);
          else if (value is List<dynamic>) {
            for (int i = 0; i < value.length; i++)
              errors.add(value[i].toString());
          } else if (value is String) errors.add(value);
        });
      } catch (exception) {
        debugPrint("Exception => $exception");
      }
      responseModel  = ResponseModel (
        isSuccess: false,
        serverError: ErrorModel(
          errorMessage: errors.length > 0
              ? errors.join(',')
              : (LocalKeys.SERVER_UNREACHABLE).tr,
          errorCode: serverResponse.statusCode,
        ),

      );
    }
    else if(serverResponse.statusCode == HttpStatus.internalServerError || serverResponse.statusCode == HttpStatus.notFound){
      responseModel  = ResponseModel (
        isSuccess: false,
        serverError: ErrorModel(
          errorMessage: ('Content unreachable , please try again later'),
          errorCode: serverResponse.statusCode,
        ),

      );
    }
    else {
      String serverError = ('Content unreachable , please try again later');
      try {
        serverError = json.decode(serverResponse.body)['error']['message'] ?? (LocalKeys.SERVER_UNREACHABLE).tr;
        if (serverError.isEmpty) {
          serverError = (LocalKeys.SERVER_UNREACHABLE).tr;
        }
      } catch (exception) {
        print("Exception in parsing Error => $exception");
        serverError = serverResponse.body;
      }
      responseModel  = ResponseModel (
        isSuccess: false,
        serverError: ErrorModel(
          errorMessage: serverError,
          errorCode: serverResponse.statusCode,
        ),

      );
    }
    return responseModel ;
  }
}

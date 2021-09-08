import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:get/get.dart';
import 'package:shopbox/features/login_screen/login_controller.dart';
class RequestInterceptor implements InterceptorContract  {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async{

    data.headers.addAll({
      HttpHeaders.acceptHeader : 'application/json',
      HttpHeaders.contentTypeHeader : 'application/json',
    });

    try {
      if (Get
          .find<LoginController>()
          .loggedInUser != null) {
        data.params.putIfAbsent("accessToken", () =>
        Get.find<LoginController>().loggedInUser!.accessToken);
      }
    } catch(exception){
      print("Exception accured => $exception");
    }



    debugPrint('----------------------REQUEST-----------------------------');
    debugPrint('AT => ${DateTime.now().toString()}');
    debugPrint('URL => ${data.url}');
    debugPrint('PAYLOAD => ${data.body}');
    debugPrint('HEADERS => ${data.headers}');
    debugPrint('---------------------------------------------------');


    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async{


    debugPrint('----------------------RESPONSE -----------------------------');
    debugPrint('AT => ${DateTime.now().toString()}');
    debugPrint('URL => ${data.url}');
    debugPrint('BODY => ${data.body}');
    debugPrint('---------------------------------------------------');

    return data;
  }
}
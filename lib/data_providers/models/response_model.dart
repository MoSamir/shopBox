import 'package:flutter/foundation.dart';

import 'error_model.dart';

class ResponseModel<T> {
  T? responseData ;
  ErrorModel? serverError ;
  bool isSuccess ;
  ResponseModel({required this.isSuccess, this.responseData , this.serverError});
}
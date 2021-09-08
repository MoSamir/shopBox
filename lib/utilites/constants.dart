import 'dart:io';

import 'package:shopbox/data_providers/models/error_model.dart';

class Constants {
  static final ErrorModel connectionTimeoutException = ErrorModel(errorMessage: '' , errorCode: HttpStatus.networkConnectTimeoutError);
}
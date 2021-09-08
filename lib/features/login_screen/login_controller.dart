import 'package:get/get.dart';
import 'package:shopbox/data_providers/apis/login_apis.dart';
import 'package:shopbox/data_providers/models/error_model.dart';
import 'package:shopbox/data_providers/models/response_model.dart';
import 'package:shopbox/data_providers/models/user.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  User? loggedInUser ;

  Future<void> login({required String username ,required String password}) async{
    isLoading(true);
    update();
    ResponseModel<User> loginResponse = await LoginAPIs.login(username,password);
    if(loginResponse.isSuccess){
      loggedInUser = loginResponse.responseData;
      Get.offAndToNamed("/clients");
    }
    isLoading(false);
    update();
    throw loginResponse.serverError! ;
  }
}
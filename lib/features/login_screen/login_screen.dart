import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shopbox/data_providers/models/error_model.dart';
import 'package:shopbox/features/login_screen/login_controller.dart';
import 'package:shopbox/utilites/toast_helper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final GlobalKey<FormState> _loginFormState =  GlobalKey<FormState>();
  final TextEditingController _userEmailTextEditingForm = TextEditingController(text: "rs+2021@shopbox.com") , _userPasswordTextEditingForm = TextEditingController(text: "123456") ;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<LoginController>(
          init: Get.find<LoginController>(),
          builder: (controller) => Center(
            child: ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              child: Form(
                key: _loginFormState,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0 , horizontal: 20),
                      child: TextFormField(
                        controller: _userEmailTextEditingForm,
                        decoration: InputDecoration(
                          hintText: 'username',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0 , horizontal: 20),
                      child: TextFormField(
                        obscureText: true,
                        controller: _userPasswordTextEditingForm,
                        decoration: InputDecoration(
                          hintText: 'password',
                        ),
                      ),
                    ),
                    TextButton(onPressed: () async {
                      try{
                       await controller.login(username: _userEmailTextEditingForm.text, password: _userPasswordTextEditingForm.text);
                      } catch(error){
                        if(error is ErrorModel)
                          ToastHelper.showToast(message: error.errorMessage, isError: true);
                      }
                    }, child: Text('Login')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shopbox/data_providers/models/branch.dart';
import 'package:shopbox/features/branches_screen/branch_card.dart';
import 'package:shopbox/features/branches_screen/branches_controller.dart';
import 'package:shopbox/utilites/toast_helper.dart';
class BranchesScreen extends StatelessWidget {
  const BranchesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BranchesController>(
        init: BranchesController(Get.arguments[0]),
        builder: (controller){
          Widget content = Container();
          if(controller.isLoading.value == false && controller.apiResponse.isSuccess) {
            if(controller.apiResponse.responseData != null && controller.apiResponse.responseData!.isNotEmpty){
              List<Branch> _branchesList = controller.apiResponse.responseData!;
              content =  ListView.builder(
                  itemCount: _branchesList.length,
                  itemBuilder: (context, index) =>
                      BranchCard(branch: _branchesList[index]));
            } else {
              content =  Center(
                child: Text('No Clients yet'),
              );
            }

          }
          else if (controller.isLoading.value == false && !controller.apiResponse.isSuccess){
            WidgetsBinding.instance?.addPostFrameCallback((timestamp) {
              ToastHelper.showToast(message: controller.apiResponse.serverError!.errorMessage, isError: true);
            });
            content = Container();
          }
          return Container(
            child: ModalProgressHUD(
              inAsyncCall: controller.isLoading.value,
              child: content,
            ),
          );
        },
      ),
    );
  }
}

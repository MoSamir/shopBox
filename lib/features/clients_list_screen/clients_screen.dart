import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shopbox/data_providers/models/client.dart';
import 'package:shopbox/features/clients_list_screen/client_card.dart';
import 'package:shopbox/features/clients_list_screen/clients_controller.dart';
import 'package:shopbox/utilites/toast_helper.dart';

class ClientScreen extends StatelessWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ClientsController>(
        init: ClientsController(),
        builder: (controller){
          Widget content = Container();
          if(controller.isLoading.value == false && controller.apiResponse.isSuccess) {
            if(controller.apiResponse.responseData != null && controller.apiResponse.responseData!.isNotEmpty){
              List<Client> _clientsList = controller.apiResponse.responseData!;
              content =  ListView.builder(
                  itemCount: _clientsList.length,
                  itemBuilder: (context, index) =>
                      ClientCard(client: _clientsList[index]));
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

import 'package:get/get.dart';
import 'package:shopbox/data_providers/apis/client_apis.dart';
import 'package:shopbox/data_providers/models/client.dart';
import 'package:shopbox/data_providers/models/error_model.dart';
import 'package:shopbox/data_providers/models/response_model.dart';
import 'package:shopbox/data_providers/models/user.dart';

class ClientsController extends GetxController{
  RxBool isLoading = false.obs;
  late ResponseModel<List<Client>> apiResponse ;
  @override
  void onInit() {
    super.onInit();
    _getClientsList();
  }
  void _getClientsList()  async {
    isLoading(true);
    update();
    apiResponse = await ClientAPIs.getClients();
    isLoading(false);
    update();
  }

}
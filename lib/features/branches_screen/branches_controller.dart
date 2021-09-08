import 'package:get/get.dart';
import 'package:shopbox/data_providers/apis/branch_apis.dart';
import 'package:shopbox/data_providers/models/branch.dart';
import 'package:shopbox/data_providers/models/response_model.dart';

class BranchesController extends GetxController{

final String clientId ;
BranchesController(this.clientId);

  @override
  void onInit() {
    super.onInit();
    _getBranchesList();

  }



  RxBool isLoading = false.obs;
late ResponseModel<List<Branch>> apiResponse ;

void _getBranchesList()  async {

  isLoading(true);
  update();
  apiResponse = await BranchAPIs.getBranches(clientId);
  isLoading(false);
  update();
}


}
import 'package:shopbox/data_providers/models/response_model.dart';
import 'package:shopbox/data_providers/urls.dart';
import 'package:shopbox/utilites/api_parse_key.dart';
import 'package:shopbox/utilites/network_utilites.dart';
import 'package:shopbox/data_providers/models/branch.dart';

class BranchAPIs {

  static Future<ResponseModel<List<Branch>>> getBranches(String clientId) async {
    String apiURL = URL.getURL(api: URL.getClientBranches) + "client=$clientId";
    ResponseModel response = await NetworkUtilities.handleGetRequest(methodURL: apiURL, parserFunction: (serverRawResponse){
      return Branch.fromListJson(serverRawResponse[ApiParseKeys.data]);
    } , );
    return ResponseModel<List<Branch>>(
      isSuccess: response.isSuccess,
      responseData: response.responseData,
      serverError: response.serverError,
    );


  }


}
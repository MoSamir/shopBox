import 'package:shopbox/data_providers/models/client.dart';
import 'package:shopbox/data_providers/models/response_model.dart';
import 'package:shopbox/data_providers/urls.dart';
import 'package:shopbox/utilites/api_parse_key.dart';
import 'package:shopbox/utilites/network_utilites.dart';

class ClientAPIs {
  static Future<ResponseModel<List<Client>>> getClients() async {
    String loginLink = URL.getURL(api: URL.getClientsURL);
    ResponseModel loginResponse = await NetworkUtilities.handleGetRequest(methodURL: loginLink,
        parserFunction: (Map<String,dynamic> rawServerResponse){
          return Client.fromListJson(rawServerResponse[ApiParseKeys.data]);
        });
    return ResponseModel<List<Client>>(
        isSuccess: loginResponse.isSuccess ,
        serverError: loginResponse.serverError,
        responseData: loginResponse.responseData
    );
  }

}
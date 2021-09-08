import 'package:shopbox/utilites/api_parse_key.dart';

class Client {
  String userId , userName , description , phoneNumber ;
  String ? imagePath ,userEmail ;
  bool showImagePath ;
  Client({required this.showImagePath, required this.userId , required this.userName , required this.description , required this.phoneNumber , this.imagePath , this.userEmail});
  
  static List<Client> fromListJson(List<dynamic> clientsJson) {
    List<Client> clientsList = [];
    for(int i = 0 ; i < clientsJson.length ; i++)
      clientsList.add(fromJson(clientsJson[i]));
    return clientsList;
  }

  static Client fromJson(Map<String,dynamic> singleClientMap) {
    return Client(
        showImagePath: singleClientMap[ApiParseKeys.showImage] == 1,
        userId: singleClientMap[ApiParseKeys.id].toString(),
        userName: singleClientMap[ApiParseKeys.clientName], description: singleClientMap[ApiParseKeys.description],
        phoneNumber: singleClientMap[ApiParseKeys.clientPhoneNumber]);
  }

  
  




}
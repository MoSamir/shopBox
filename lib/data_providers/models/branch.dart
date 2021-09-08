import 'package:shopbox/data_providers/models/cash_register.dart';
import 'package:shopbox/utilites/api_parse_key.dart';
class Branch {
  String  branchId ,branchName , branchPhoneNumber ;
  List<CashRegister> cashRegisters ;
  Branch({required this.branchId , required this.cashRegisters ,required this.branchName , required this.branchPhoneNumber});
  static List<Branch> fromListJson(List<dynamic> branchesJson){
    List<Branch> _branches = [];
    for(int i = 0 ; i < branchesJson.length ; i++)
      _branches.add(fromJson(branchesJson[i]));
    return _branches;
  }
  static Branch fromJson(Map<String,dynamic> branchesJson) {
    List<CashRegister> _cashRegisters = CashRegister.fromListJson(branchesJson[ApiParseKeys.cashRegister]);
    return Branch(branchId: branchesJson[ApiParseKeys.id].toString(), cashRegisters: _cashRegisters ,branchName: branchesJson[ApiParseKeys.name], branchPhoneNumber: branchesJson[ApiParseKeys.clientPhoneNumber]);
  }
}


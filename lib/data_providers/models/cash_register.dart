import 'package:shopbox/utilites/api_parse_key.dart';

class CashRegister {
  String id, associatedBranchName, associatedBranchId;
  CashRegister({required this.id, required this.associatedBranchId, required this.associatedBranchName});
  static List<CashRegister> fromListJson(List<dynamic> cashRegistryListJson) {
    List<CashRegister> _cashRegister = [];
    for (int i = 0; i < cashRegistryListJson.length; i++)
      _cashRegister.add(fromJson(cashRegistryListJson[i]));
    return _cashRegister;
  }
  static CashRegister fromJson(Map<String, dynamic> cashRegistryJson) {
    return CashRegister(id: cashRegistryJson[ApiParseKeys.id].toString(), associatedBranchId:  cashRegistryJson[ApiParseKeys.branch].toString(), associatedBranchName: cashRegistryJson[ApiParseKeys.name]);
  }
}
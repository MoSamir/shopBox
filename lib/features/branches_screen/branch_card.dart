import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopbox/data_providers/models/branch.dart';
import 'package:shopbox/data_providers/models/cash_register.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({Key? key , required this.branch}) : super(key: key);

  final Branch branch;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed("/counter");
        },
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(padding: const EdgeInsets.all(8.0) ,
                child: Container(
                  height: 75,
                  width: 75,
                  color: Colors.blue,
                  child: Center(child: Text('${branch.branchPhoneNumber[0]}' , style: TextStyle(fontWeight: FontWeight.bold  , color: Colors.white , fontSize: 20),),),
                ),),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(branch.branchName , style: TextStyle(fontWeight: FontWeight.bold),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(branch.branchPhoneNumber),
                    ),
                    Text('Cash Registers'),
                    SizedBox(height: 4,),
                    if(branch.cashRegisters != null && branch.cashRegisters.isNotEmpty)
                      ListView.separated(
                          shrinkWrap: true, physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index){
                            CashRegister _cashRegister = branch.cashRegisters[index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween
                                ,children: [
                                Text(_cashRegister.id),
                                Text(_cashRegister.associatedBranchName),
                            ],),
                              ),);
                          }, separatorBuilder: (context, index)=> Divider(), itemCount: branch.cashRegisters.length)
                  ],
                ),
              ),







            ],
          ),
        ),
      ),
    );
  }
}

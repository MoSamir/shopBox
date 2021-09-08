import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopbox/data_providers/models/client.dart';

class ClientCard extends StatelessWidget {
  final Client client;
  const ClientCard({Key? key , required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _imagePath = client.imagePath ?? "";
    return GestureDetector(
      onTap: (){
        Get.toNamed("/branches" , arguments: [client.userId.toString()]);
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
                  child: client.showImagePath && _imagePath.isNotEmpty ? ClipRRect(borderRadius: BorderRadius.circular(25), child: Image.network(_imagePath), ) : Center(child: Text('${client.userName[0]}' , style: TextStyle(fontWeight: FontWeight.bold  , color: Colors.white , fontSize: 20),),),
                ),),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(client.userName , style: TextStyle(fontWeight: FontWeight.bold),),
                    Text(client.description),
                    if(client.userEmail != null)
                      Text(client.userEmail!)
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

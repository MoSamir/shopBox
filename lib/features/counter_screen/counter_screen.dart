import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Text("Table 01"),
                  ),
                  Card(
                    child: Text("Add Customer"),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: GridView.builder(
                itemCount: 50,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
            ),
                    itemBuilder: (context, index){
              return Card(
                elevation: 5,
                color: Colors.white,
                child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff00FF00),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),

                          child: Center(child: Container(
                            width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                shape: BoxShape.circle
                              ),
                              child: Center(child: Text("PR" , style: TextStyle(color: Colors.white),))),),
                        ),
                      ),
                      Text("Product name"),
                      Align(alignment: AlignmentDirectional.bottomEnd, child: Text("50 DKK"),)
                    ],
                  ),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}

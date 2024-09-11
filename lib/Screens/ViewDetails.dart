import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Apis/ApiManager.dart';

class ViewDetails extends StatelessWidget {

  static const String routeName="view";
   ViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var id =ModalRoute.of(context)?.settings.arguments as num ;
    return Scaffold(
      body:Column(
        children: [
          FutureBuilder(future: ApiManager.getdetails(id), builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            if(snapshot.hasError){
              return Center(child: Text('Error!',style: TextStyle(
                  color: Colors.red,
                  fontSize: 40,
                  fontWeight: FontWeight.bold
              ),));
            }
            var details =snapshot.data?.productionCompanies??[];
            return Expanded(
              child: ListView.builder(
                itemCount: details.length,
                itemBuilder: (context, index) {
                  return Text(details[index].name??'');
                },),
            );


          },),
        ],
      )
    );
  }
}

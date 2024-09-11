import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Apis/ApiManager.dart';

class ViewDetails extends StatelessWidget {

  static const String routeName="view";
   ViewDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var id =ModalRoute.of(context)?.settings.arguments as dynamic  ;
    return Scaffold(
      backgroundColor: Colors.black,
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
            var title =snapshot.data?.title??"";
            var image=snapshot.data?.posterPath??"";
            var date=snapshot.data?.releaseDate??"";
           return Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
               children: [
                 Container(
                   margin:EdgeInsets.symmetric(
                     vertical: 30
                   ),
                   child: Row(
                     children: [
                       GestureDetector(
                           onTap:(){
                             Navigator.pop(context);
                           },
                           child: Icon(Icons.arrow_back_rounded,color: Colors.white,)),
                       SizedBox(
                         width: 7,
                       ),
                       Text(title,style: TextStyle(
                           color: Colors.white,

                           fontSize: 20,
                           fontWeight: FontWeight.w400
                       ),),
                     ],
                   ),
                 ),
                 Image.network("https://image.tmdb.org/t/p/w500$image",
                 height: 300,width: double.infinity,
                 fit: BoxFit.fill,),
                 Container(
                   margin:EdgeInsets.symmetric(
                     vertical: 10
                   ),
                   child: Text(title,style: TextStyle(
                       color: Colors.white,

                       fontSize: 20,
                       fontWeight: FontWeight.w400
                   ),),
                 ),
                 Text(date,style: TextStyle(
                   color: Colors.grey,
                   fontSize: 16,
                   fontWeight: FontWeight.w400
                 ),),
                 SizedBox(
                   height: 7,
                 ),
                 Row(
                   children: [
                     Image.network("https://image.tmdb.org/t/p/w500$image",
                       height: 200,width: 150,)
                   ],
                 )




               ],
             ),
           );



          },),
        ],
      )
    );
  }
}

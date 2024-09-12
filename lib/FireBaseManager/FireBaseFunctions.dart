import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/movie_card_model.dart';

class FireBaseFunctions{

  static CollectionReference<MovieCardModel>  getmoviescollection(){
    return  FirebaseFirestore.instance.collection('Movie').withConverter<MovieCardModel>
      (fromFirestore: (snapshot, _) {
      return MovieCardModel.fromjson(snapshot.data()!);

    },
        toFirestore: (MovieCardModel, _) {
          return MovieCardModel.tojson();

        }
    );
  }



  static void addmovie(MovieCardModel model ){
   try{

     var collection = getmoviescollection();
     var docref = collection.doc(model.id);

     docref.set(model);
   }catch(e){
     print("Error !!!${e.toString()}");
   }

  }

  static Stream<QuerySnapshot<MovieCardModel>> getmovies(){
    var collection =getmoviescollection();
    return collection.snapshots();


  }




}
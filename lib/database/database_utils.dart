import 'package:chat_c5/model/my_user.dart';
import 'package:chat_c5/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
            fromFirestore: (snapshot, _) => MyUser.fomJson(snapshot.data()!),
            toFirestore: (user, _) => user.toJson());
  }
  static CollectionReference<Room> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        .withConverter<Room>(
            fromFirestore: (snapshot, _) => Room.fomJson(snapshot.data()!),
            toFirestore: (room, _) => room.toJson());
  }

  static Future<void> createDBUser(MyUser user) async {
    return getUsersCollection().doc(user.id).set(user);
  }
  static  Future<MyUser?> readUser(String userId)async{
    var userDocSnapshot = await getUsersCollection()
        .doc(userId)
        .get();
    return userDocSnapshot.data();
  }
  static Future<void> createRoom(String title,String desc,String catId){
   var roomsCollection =  getRoomsCollection();
   var docRef = roomsCollection.doc();
   Room room = Room(id: docRef.id
       , title: title, desc: desc, catId: catId);
   return docRef.set(room);

  }
}

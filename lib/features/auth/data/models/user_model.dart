import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klean/core/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.name,
    required super.email,
    required super.phoneNo,
    required super.uid,
  });

  factory UserModel.fromJson(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel(
      name: doc.data()['name'],
      email: doc.data()['email'],
      phoneNo: doc.data()['phoneNo'],
      uid: doc.data()['uid'],
    );
  }

  Map<String, dynamic> toJson(UserModel userModel) {
    return {
      'name': userModel.name,
      'email': userModel.email,
      'phoneNo': userModel.phoneNo,
      'uid': userModel.uid,
    };
  }
}

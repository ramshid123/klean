import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:klean/core/constants/firestore/firestore_collections.dart';
import 'package:klean/core/error/exception.dart';
import 'package:klean/core/routes/route_names.dart';
import 'package:klean/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserCredential> loginWithGoogle();
  Future registerUser(UserModel user);
  Future<UserModel?> getUser(String uid);
  Future<UserModel?> getCurrentUser();
  Future<String> loginWithPhone(String phoneNo);

  Future updateBio(
      {required String name, String email = '', String phoneNo = ''});

  Future<UserCredential> verifyOtp(
      {required String otp, required String verificationId});
  Future logOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseFirestore firestoreInstance;
  final FirebaseAuth authInstance;

  AuthRemoteDataSourceImpl(
      {required this.firestoreInstance, required this.authInstance});

  @override
  Future<UserCredential> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      return await authInstance.signInWithCredential(credentials);
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future registerUser(UserModel user) async {
    try {
      final newDoc =
          firestoreInstance.collection(FirestoreCollections.users).doc();
      await newDoc.set({
        ...user.toJson(user),
        'docId': newDoc.id,
      });
      final newCartDoc =
          firestoreInstance.collection(FirestoreCollections.carts).doc();

      await newCartDoc.set({
        'uid': user.uid,
        'carts': [],
      });
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future<UserModel?> getUser(String uid) async {
    try {
      final response = await firestoreInstance
          .collection(FirestoreCollections.users)
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();
      return response.docs.isEmpty
          ? null
          : UserModel.fromJson(response.docs.first);
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (authInstance.currentUser == null) {
        return null;
      }

      final response = await firestoreInstance
          .collection(FirestoreCollections.users)
          .where('uid', isEqualTo: authInstance.currentUser!.uid)
          .limit(1)
          .get();
      return response.docs.isEmpty
          ? null
          : UserModel.fromJson(response.docs.first);
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future<String> loginWithPhone(String phoneNo) async {
    try {
      Completer<String> completer = Completer<String>();
      await authInstance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credentials) {
          authInstance.signInWithCredential(credentials);
        },
        verificationFailed: (value) {
          log(value.code);
          logOut();
        },
        codeSent: (verificationId, resendToken) {
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (value) {},
      );
      return await completer.future;
    } catch (e) {
      log(e.toString());
      throw (KustomException(e.toString()));
    }
  }

  @override
  Future logOut() async {
    try {
      await authInstance.signOut();
    } catch (e) {
      throw (KustomException(e.toString()));
    }
  }

  @override
  Future<UserCredential> verifyOtp(
      {required String otp, required String verificationId}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      return await authInstance.signInWithCredential(credential);
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future updateBio(
      {required String name, String email = '', String phoneNo = ''}) async {
    try {
      Map<String, dynamic> data = {};
      data['name'] = name;
      if (email.isNotEmpty) {
        data['email'] = email;
      } else if (phoneNo.isNotEmpty) {
        data['phoneNo'] = phoneNo;
      }

      final uid = authInstance.currentUser!.uid;
      final userDoc = await firestoreInstance
          .collection(FirestoreCollections.users)
          .where('uid', isEqualTo: uid)
          .limit(1)
          .get();

      await userDoc.docs.first.reference.update(data);
    } catch (e) {
      throw KustomException(e.toString());
    }
  }
}

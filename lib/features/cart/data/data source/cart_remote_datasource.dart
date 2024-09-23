import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:klean/core/constants/firestore/firestore_collections.dart';
import 'package:klean/core/error/exception.dart';
import 'package:klean/features/cart/data/models/cart_model.dart';

abstract interface class CartRemoteDatasource {
  Future<CartModel> getOneCart({required String id, required String uid});

  Future<List<CartModel>> getCarts({required String uid});

  Future updateCarts({required String uid, required List<CartModel> carts});
}

class CartRemoteDatasourceImpl implements CartRemoteDatasource {
  final FirebaseFirestore firestoreInstance;

  CartRemoteDatasourceImpl(this.firestoreInstance);

  @override
  Future<CartModel> getOneCart(
      {required String id, required String uid}) async {
    try {
      final karts = await firestoreInstance
          .collection(FirestoreCollections.carts)
          .where('uid', isEqualTo: uid)
          .get();

      Map<String, dynamic> kartJson = karts.docs.first
          .data()['carts']
          .where((kart) => kart['id'] == id)
          .toList()[0];

      return CartModel.fromJson(kartJson);
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future<List<CartModel>> getCarts({required String uid}) async {
    try {
      final response = await firestoreInstance
          .collection(FirestoreCollections.carts)
          .where('uid', isEqualTo: uid)
          .get();

      final List<Map<String, dynamic>> karts =
          List<Map<String, dynamic>>.from(response.docs.first.data()['carts']);

      return karts.map((kart) => CartModel.fromJson(kart)).toList();
    } catch (e) {
      throw KustomException(e.toString());
    }
  }

  @override
  Future updateCarts(
      {required String uid, required List<CartModel> carts}) async {
    try {
      final List<Map<String, dynamic>> cartsJson = [];
      for (var cart in carts) {
        cartsJson.add(cart.toJson());
      }

      final response = await firestoreInstance
          .collection(FirestoreCollections.carts)
          .where('uid', isEqualTo: uid)
          .get();

      response.docs.first.reference.update({
        'carts': cartsJson,
      });
    } catch (e) {
      throw KustomException(e.toString());
    }
  }
}

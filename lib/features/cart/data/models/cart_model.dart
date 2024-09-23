import 'package:klean/core/entity/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel({
    required super.id,
    required super.title,
    required super.rating,
    required super.orders,
    required super.minutes,
    required super.price,
    required super.counts,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      title: json['title'],
      rating: json['rating'],
      orders: json['orders'],
      minutes: json['minutes'],
      price: json['price'],
      counts: json['counts'],
    );
  }

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(
      id: entity.id,
      title: entity.title,
      rating: entity.rating,
      orders: entity.orders,
      minutes: entity.minutes,
      price: entity.price,
      counts: entity.counts,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'rating': rating,
      'orders': orders,
      'minutes': minutes,
      'price': price,
      'counts': counts,
    };
  }
}

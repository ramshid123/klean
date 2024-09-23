import 'package:klean/core/entity/product_entity.dart';

class CartEntity {
  final String id;
  final String title;
  final double rating;
  final int orders;
  final int minutes;
  final double price;
  int counts;

  CartEntity({
    required this.id,
    required this.title,
    required this.rating,
    required this.orders,
    required this.minutes,
    required this.price,
    required this.counts,
  });

  factory CartEntity.fromProduct(ProductEntity product) {
    return CartEntity(
      id: product.id,
      title: product.title,
      rating: product.rating,
      orders: product.orders,
      minutes: product.minutes,
      price: product.price,
      counts: 0,
    );
  }

  CartEntity copyWith({
    String? id,
    String? title,
    double? rating,
    int? orders,
    int? minutes,
    double? price,
    int? counts,
  }) {
    return CartEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      rating: rating ?? this.rating,
      orders: orders ?? this.orders,
      minutes: minutes ?? this.minutes,
      price: price ?? this.price,
      counts: counts ?? this.counts,
    );
  }
}

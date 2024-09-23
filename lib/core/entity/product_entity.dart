import 'package:klean/core/entity/cart_entity.dart';

class ProductEntity {
  final String id;
  final String title;
  final double rating;
  final int orders;
  final int minutes;
  final double price;
  final String imageUrl;

  ProductEntity({
    required this.id,
    required this.title,
    required this.rating,
    required this.orders,
    required this.minutes,
    required this.price,
    required this.imageUrl,
  });
}

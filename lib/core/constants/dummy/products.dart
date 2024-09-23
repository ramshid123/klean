import 'package:flutter/services.dart';
import 'package:klean/core/entity/product_entity.dart';

List<ProductEntity> dummyProducts = _dummyJson
    .map((json) => ProductEntity(
          id: json['id'],
          title: json['title'],
          rating: json['rating'],
          orders: json['orders'],
          minutes: json['minutes'],
          price: json['price'],
          imageUrl: json['imageUrl'],
        ))
    .toList();

final List<Map<String, dynamic>> _dummyJson = [
  {
    "id": "product1",
    "title": "Kitchen Cleaning",
    "rating": 4.5,
    "orders": 45,
    "minutes": 90,
    "price": 699.0,
    "imageUrl": "assets/images/services images/service1.png"
  },
  {
    "id": "product2",
    "title": "Window Cleaning",
    "rating": 4.0,
    "orders": 30,
    "minutes": 40,
    "price": 299.0,
    "imageUrl": "assets/images/services images/service4.png"
  },
  {
    "id": "product3",
    "title": "Carpet Cleaning",
    "rating": 4.7,
    "orders": 52,
    "minutes": 120,
    "price": 899.0,
    "imageUrl": "assets/images/services images/service2.png"
  },
  {
    "id": "product4",
    "title": "Sofa Cleaning",
    "rating": 4.3,
    "orders": 25,
    "minutes": 75,
    "price": 649.0,
    "imageUrl": "assets/images/services images/service3.png"
  },
  {
    "id": "product5",
    "title": "Car Wash",
    "rating": 4.6,
    "orders": 80,
    "minutes": 45,
    "price": 499.0,
    "imageUrl": "assets/images/services images/service5.png"
  },
  {
    "id": "product6",
    "title": "Floor Polishing",
    "rating": 4.4,
    "orders": 19,
    "minutes": 150,
    "price": 999.0,
    "imageUrl": "assets/images/services images/service6.png"
  },
  {
    "id": "product7",
    "title": "Lawn Mowing",
    "rating": 4.2,
    "orders": 12,
    "minutes": 60,
    "price": 349.0,
    "imageUrl": "assets/images/services images/service7.png"
  },
  {
    "id": "product8",
    "title": "Pet Grooming",
    "rating": 4.8,
    "orders": 65,
    "minutes": 90,
    "price": 549.0,
    "imageUrl": "assets/images/services images/service8.png"
  },
  {
    "id": "product9",
    "title": "Air Duct Cleaning",
    "rating": 4.1,
    "orders": 22,
    "minutes": 180,
    "price": 1099.0,
    "imageUrl": "assets/images/services images/service9.png"
  },
  {
    "id": "product10",
    "title": "Curtain Cleaning",
    "rating": 4.0,
    "orders": 14,
    "minutes": 70,
    "price": 449.0,
    "imageUrl": "assets/images/services images/service10.png"
  },
  {
    "id": "product11",
    "title": "Office Cleaning",
    "rating": 4.9,
    "orders": 105,
    "minutes": 240,
    "price": 1599.0,
    "imageUrl": "assets/images/services images/service11.png"
  },
  {
    "id": "product12",
    "title": "Grout Cleaning",
    "rating": 4.2,
    "orders": 34,
    "minutes": 100,
    "price": 799.0,
    "imageUrl": "assets/images/services images/service12.png"
  },
  {
    "id": "product13",
    "title": "Pool Cleaning",
    "rating": 4.5,
    "orders": 56,
    "minutes": 180,
    "price": 1299.0,
    "imageUrl": "assets/images/services images/service13.png"
  },
  {
    "id": "product14",
    "title": "Garden Weeding",
    "rating": 4.3,
    "orders": 40,
    "minutes": 90,
    "price": 599.0,
    "imageUrl": "assets/images/services images/service14.png"
  },
  {
    "id": "product15",
    "title": "Pest Control",
    "rating": 4.7,
    "orders": 76,
    "minutes": 60,
    "price": 899.0,
    "imageUrl": "assets/images/services images/service15.png"
  },
  {
    "id": "product16",
    "title": "Laundry Service",
    "rating": 4.6,
    "orders": 48,
    "minutes": 120,
    "price": 799.0,
    "imageUrl": "assets/images/services images/service16.png"
  },
  {
    "id": "product17",
    "title": "Pressure Washing",
    "rating": 4.8,
    "orders": 69,
    "minutes": 150,
    "price": 999.0,
    "imageUrl": "assets/images/services images/service17.png"
  },
  {
    "id": "product18",
    "title": "Roof Cleaning",
    "rating": 4.5,
    "orders": 38,
    "minutes": 210,
    "price": 1499.0,
    "imageUrl": "assets/images/services images/service18.png"
  },
  {
    "id": "product19",
    "title": "Mattress Cleaning",
    "rating": 4.3,
    "orders": 18,
    "minutes": 50,
    "price": 499.0,
    "imageUrl": "assets/images/services images/service19.png"
  },
  {
    "id": "product20",
    "title": "Trash Removal",
    "rating": 4.6,
    "orders": 85,
    "minutes": 120,
    "price": 699.0,
    "imageUrl": "assets/images/services images/service21.png"
  },
  {
    "id": "product21",
    "title": "Dryer Vent Cleaning",
    "rating": 4.7,
    "orders": 31,
    "minutes": 60,
    "price": 399.0,
    "imageUrl": "assets/images/services images/service20.png"
  }
];

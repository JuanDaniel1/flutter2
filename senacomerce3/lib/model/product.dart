import 'dart:convert';

import 'package:hive/hive.dart';

import 'tag.dart';

part 'product.g.dart';

List<Product> popularProductListFromJson(String val) =>
    List<Product>.from(json.decode(val)['data']
        .map((val) => Product.popularProductFromJson(val))
    );

List<Product> productListFromJson(String val) =>
    List<Product>.from(json.decode(val)['data']
        .map((val) => Product.productFromJson(val))
    );

@HiveType(typeId: 3)
class Product {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String images;
  @HiveField(4)
  final double price;
  List<dynamic>selected=[];
  final String medida;



  

  Product(
      {required this.id,
        required this.name,
        required this.description,
        required this.images,
        required this.price,
        required this.medida,

        });

  factory Product.popularProductFromJson(Map<String, dynamic> data) => Product(
      id: data['id'],
      name: data['attributes']['product']['data']['attributes']['name'],
      description: data['attributes']['product']['data']['attributes']
      ['description'],
      images: data['attributes']['product']['data']['attributes']
      ['images'],
      price: data['attributes']['product']['data']['attributes']
      ['price'],
      medida: data['attributes']['product']['data']['attributes']
      ['medida'],
    
  );

  factory Product.productFromJson(Map<String, dynamic> data) => Product(
      id: data['id'],
      name: data['attributes']['name'],
      description: data['attributes']['description'],
      images: data['attributes']['images'],
      price: data['attributes']['price'],
      medida: data['attributes']['medida'],
  );
  factory Product.carrito(Map<String, dynamic> data) => Product(
    id: data['id'],
    name: data['attributes']['name'],
    description: data['attributes']['description'],
    images: data['attributes']['images'],
    price: data['attributes']['price'],
    medida: data['attributes']['medida'],

  );



}
@HiveType(typeId: 3)
class Carrito {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String images;
  @HiveField(4)
  final double price;
  @HiveField(5)
  int qty;

  Carrito(
      {required this.id,
        required this.name,
        required this.description,
        required this.images,
        required this.price,
        required this.qty
      });
}
class Popular{
  final int id;


  Popular({
    required this.id,

  });
}

class Selected{
  final List<String>select;

  Selected({
    required this.select
});
}

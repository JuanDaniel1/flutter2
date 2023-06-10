import '../model/product.dart';

class ShoppingCart {
  List<Product> products = [];

  void addProduct(Product product) {
    products.add(product);
  }
}

import 'package:scoped_model/scoped_model.dart';
import '../models/Product.dart';

class ProductsModel extends Model {
  final List<Product> _products = [];

  List<Product> get products {
    return List.from(_products);
  }

  void addProduct(Product newProduct) {
    this._products.add(newProduct);
  }

  void deleteProduct(int index) {
    this._products.removeAt(index);
  }

  void updateProduct(int index, Product newData) {
    this._products[index] = newData;
  }
}

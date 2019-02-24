import 'package:scoped_model/scoped_model.dart';
import '../models/Product.dart';

class ProductsModel extends Model {
  final List<Product> _products = [];
  int _selectedProductIndex; 
  bool _isFavoriteMode = false;

  List<Product> get products {
    return List.from(_products);
  }

  List<Product> get displayedProducts {
    if(_isFavoriteMode){
      return List.from(_products.where((Product product) => product.isFavorite).toList());
    }
    return List.from(_products);
  }

  bool get favoriteMode {
    return this._isFavoriteMode;
  }

  void addProduct(Product newProduct) {
    this._products.add(newProduct);
    this._selectedProductIndex = null;
  }

  void deleteProduct(int index) {
    this._products.removeAt(index);
    this._selectedProductIndex = null;
  }

  void updateProduct(Product newData) {
    this._products[this._selectedProductIndex] = newData;
    this._selectedProductIndex = null;
  }

  void selectProduct(int index){
    assert(index <= this._products.length);
    assert(index >= 0 );
    assert(this._products != null);
    this._selectedProductIndex = index;
  }

  Product getSelectedProduct(){
    if(this._selectedProductIndex != null){
      return products[this._selectedProductIndex];
    }
    return null;
  }

  int getProductCount(){
    return this._products.length;
  }

  int getSelectedProductIndex(){
    return this._selectedProductIndex;
  }

  Product getProduct(int index){
    if(index <= this._products.length){
      return this._products[index];
    }else{
      return null;
    }
  }

  void toggleProductFavorite(int index){
    this.selectProduct(index);
    Product selectedProduct = this.getSelectedProduct();
    bool newIsFavoriteStatus = !(this._products[this._selectedProductIndex].isFavorite);
    final Product updatedProduct =Product(title: selectedProduct.title, price: selectedProduct.price, desc: selectedProduct.desc, isFavorite: newIsFavoriteStatus );
    this.updateProduct(updatedProduct);
    notifyListeners();
  }

  void toggleDisplayMode(){
    this._isFavoriteMode = !this._isFavoriteMode;
    notifyListeners();
  }

}

import 'package:scoped_model/scoped_model.dart';

import './Products.dart';
import './user.dart';
import './connected-products.dart';

class MainModel extends Model with ConnectedProducts, UserModel, ProductsModel{


}
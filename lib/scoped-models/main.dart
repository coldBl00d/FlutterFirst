import 'package:scoped_model/scoped_model.dart';

import './Products.dart';
import './user.dart';

class MainModel extends Model with UserModel, ProductsModel{


}
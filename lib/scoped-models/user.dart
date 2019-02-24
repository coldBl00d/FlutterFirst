import 'package:course/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

import './connected-products.dart';
mixin UserModel on ConnectedProducts {

  void login(String email, String password){
    authenticatedUser = User('jdifhendlci', email, password);
  }

}
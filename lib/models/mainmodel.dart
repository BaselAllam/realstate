import 'package:scoped_model/scoped_model.dart';
import 'package:seniorsteps/models/product/productmodel.dart';
import 'package:seniorsteps/models/user/usermodel.dart';



class MainModel extends Model with UserModel, ProductModel{}
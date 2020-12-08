import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';



mixin UserModel on Model{

  bool _isUserLoading = false;
  bool get isUserLoading => _isUserLoading;


  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<bool> userSignUp(String email, String password, String name, String gender, String dateOfBirth) async {
    
    _isUserLoading = true;
    notifyListeners();

    AuthResult _result = await auth.createUserWithEmailAndPassword(email: email, password: password);

    if(_result.user.uid != null){
      final Map<String, dynamic> _user = {
        'email' : email,
        'name' : name,
        'gender' : gender,
        'dateOfBirth' : dateOfBirth,
        'userId' : _result.user.uid
      };
      Firestore.instance.collection('users').add(_user);
      _isUserLoading = false;
      notifyListeners();
      return true;
    }else{
      _isUserLoading = false;
      notifyListeners();
      return false;
    }

  }


}
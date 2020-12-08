import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:io';


mixin ProductModel on Model{


  bool _isProductLoading = false;
  bool get isProductLoading => _isProductLoading;


  final FirebaseStorage _storage = FirebaseStorage(storageBucket: 'gs://senior2-b1005.appspot.com');


  Future<bool> addProduct(String location, String adsType, String propertyType, double price, double area, File image) async {

    _isProductLoading = true;
    notifyListeners();

    String _imageName = 'itemImage/${DateTime.now().toString()}';

    StorageTaskSnapshot _uploadTask = await _storage.ref().child(_imageName).putFile(image).onComplete;

    String _imageUrl = await _uploadTask.ref.getDownloadURL();

    final Map<String, dynamic> _product = {
      'lcoation' : location,
      'adsType' : adsType,
      'propertyType' : propertyType,
      'price' : price,
      'area' : area,
      'image' : _imageUrl
    };

    Firestore.instance.collection('products').add(_product);

    _isProductLoading = false;
    notifyListeners();
    return true;
  }
}
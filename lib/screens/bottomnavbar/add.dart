import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:seniorsteps/models/mainmodel.dart';
import 'package:seniorsteps/widgets/loading.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {

final TextEditingController locationController = TextEditingController();
final TextEditingController priceController = TextEditingController();
final TextEditingController areaController = TextEditingController();

GlobalKey<FormState> locationKey = GlobalKey<FormState>();
GlobalKey<FormState> priceKey = GlobalKey<FormState>();
GlobalKey<FormState> areaKey = GlobalKey<FormState>();

final _formKey = GlobalKey<FormState>();

String adsType = 'None';

String propertyType = 'None';

File imagePicked;

List<File> pickedImage = [];

Position position;

bool isMapLoading = true;

List<Marker> allMarkers = [];

@override
void initState() {
  searchLocation();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Add ADS',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
                  child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Column(
                children: [
                  InkWell(
      onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context){
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                    content: Text(
                      'choose destination',
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    actions: [
                      FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.grey,
                        child: Text(
                          'Camera',
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        onPressed: () {
                          picImage(ImageSource.camera);
                        },
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.grey,
                        child: Text(
                          'Gallery',
                          style: TextStyle(color: Colors.white, fontSize: 15.0),
                        ),
                        onPressed: () {
                          picImage(ImageSource.gallery);
                        }
                      ),
                    ],
                  );
            }
          );
      },
      child: Container(
          margin: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          height:MediaQuery.of(context).size.width/4, 
          width: MediaQuery.of(context).size.width/4,
          child: ClipOval(
            child: imagePicked == null ? Icon(Icons.add_a_photo, color: Colors.grey, size: 35.0) : Image.file(imagePicked, fit: BoxFit.fill,),
          ),
      ),
    ),
                ],
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height/5,
              //   child: pickedImage.length < 1 ? pickContainer(null) : Row(
              //     children: [
              //       pickContainer(pickedImage.length < 1 ? null : pickedImage[0]),
              //       pickContainer(pickedImage.length < 2 ? null : pickedImage[1]),
              //       pickContainer(pickedImage.length < 3 ? null : pickedImage[2]),
              //     ],
              //   ),
              // ),
              field('location', Icons.location_on, TextInputType.text, locationController, locationKey),
              // Container(
              //   height: MediaQuery.of(context).size.height/3,
              //   child: isMapLoading == true ? Center(child: Loading()) : map()
              // ),
              field('price', Icons.attach_money, TextInputType.number, priceController, priceKey),
              field('area meters', Icons.space_bar, TextInputType.number, areaController, areaKey),
              item(
                'Ads Type',
                adsType,
                PopupMenuButton(
                  icon: Icon(Icons.arrow_drop_down, color: Colors.grey, size: 20.0),
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<dynamic>>[
                      PopupMenuItem(
                        child: Text('For Rent'),
                        value: 'For Rent',
                      ),
                      PopupMenuItem(
                        child: Text('For Sale'),
                        value: 'For Sale',
                      ),
                    ];
                  },
                  onSelected: (value) {
                    setState(() {
                      adsType = value;
                    });
                  },
                ),
              ),
              item(
                'Property Type',
                propertyType,
                PopupMenuButton(
                  icon: Icon(Icons.arrow_drop_down, color: Colors.grey, size: 20.0),
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<dynamic>>[
                      PopupMenuItem(
                        child: Text('Apartment'),
                        value: 'Apartment',
                      ),
                      PopupMenuItem(
                        child: Text('Villa'),
                        value: 'Villa',
                      ),
                      PopupMenuItem(
                        child: Text('Retails'),
                        value: 'Retils',
                      ),
                      PopupMenuItem(
                        child: Text('Office'),
                        value: 'Office',
                      ),
                      PopupMenuItem(
                        child: Text('Agriculture'),
                        value: 'Agriculture',
                      ),
                      PopupMenuItem(
                        child: Text('Chalet'),
                        value: 'Chalet',
                      ),
                    ];
                  },
                  onSelected: (value) {
                    setState(() {
                      propertyType = value;
                    });
                  },
                ),
              ),
              Column(
                children: [
                  ScopedModelDescendant<MainModel>(
                    builder: (context, child, MainModel model){
                      return FlatButton(
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      child: model.isProductLoading == true ? Center(child: Loading()) : Text(
                        'Add Item',
                        style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if(propertyType == 'None'){
                          return Scaffold.of(context).showSnackBar(snack('plase select property type!')); 
                        }else if(adsType == 'None'){
                          return Scaffold.of(context).showSnackBar(snack('plase select ads type!')); 
                        }else if(!_formKey.currentState.validate()){
                          return Scaffold.of(context).showSnackBar(snack('plase complete fields!'));
                        }else{
                          bool _valid = await model.addProduct(locationController.text, adsType, propertyType, double.parse(priceController.text), double.parse(areaController.text), imagePicked);
                          if(_valid == true){
                            return Scaffold.of(context).showSnackBar(snack('your ads added succesfully'));
                          }else{
                            return Scaffold.of(context).showSnackBar(snack('some thing went wrong try again'));
                          }
                        }
                      },
                    );
                    }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  snack(String fieldName) {
    return SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0),)),
      backgroundColor: Colors.red,
      content: Text(
        fieldName,
        style: TextStyle(color: Colors.white, fontSize: 15.0),
      ),
      duration: Duration(seconds: 5),
    );
  }
  field(String label, IconData icon, TextInputType type, TextEditingController controller, Key key) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
        key: key,
        validator: (value) {
          if(value.isEmpty){
            return 'this field is Requried';
          }
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.red, width: 0.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey, width: 0.5),
          ),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
          prefixIcon: Icon(icon, color: Colors.grey, size: 20.0),
        ),
        keyboardType: type,
        textInputAction: TextInputAction.done,
        controller: controller,
        onFieldSubmitted: (value){
          // if(label == 'location'){
          //   searchLocation();
          // }else{
          //   return null;
          // }
        },
      ),
    );
  }
  item(String title, String subtitle, Widget trailing) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: ListTile(
        title: Text(
            title,
            style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
          ),
        subtitle: Text(
            subtitle,
            style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.normal),
          ),
        trailing: trailing,
      ),
    );
  }
 picImage(ImageSource source) async {
    var _pickedImage = await ImagePicker.pickImage(source: source);
    setState(() {
      imagePicked = _pickedImage;
      pickedImage.add(imagePicked);
    });
  }
  pickContainer(String image) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              content: Text(
                'choose destination',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
              actions: [
                FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  color: Colors.grey,
                  child: Text(
                    'Camera',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  onPressed: () {
                    picImage(ImageSource.camera);
                  },
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  color: Colors.grey,
                  child: Text(
                    'Gallery',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                  onPressed: () {
                    picImage(ImageSource.gallery);
                  }
                ),
              ],
            );
          }
        );
      },
      child: Container(
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width/4,
        child: ClipOval(
          child: image == null ? Icon(Icons.add_a_photo, color: Colors.grey, size: 35.0) : Image.file(imagePicked, fit: BoxFit.fill,),
        ),
      ),
    );
  }
  map() {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 12
      ),
      myLocationButtonEnabled: true,
      myLocationEnabled: true,
      mapType: MapType.normal,
      markers: Set.from(allMarkers),
    );
  }
  searchLocation() async {

    setState(() {
      isMapLoading = true;
    });

    bool _locationService = await Geolocator().isLocationServiceEnabled();

    if(_locationService == false){
      setState(() {
        isMapLoading = false;
      });
      return showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(15.0)),
            title: Text(
              'Attention',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            content: Text(
              'Kindly Note\nLocation Service is Disabled, please enable it',
              style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.normal),
            ),
            actions: [
              FlatButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                child: Text(
                  'Enable It',
                  style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                onPressed: () {}
              ),
              FlatButton(
                color: Colors.grey,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
                onPressed: () {}
              ),
            ],
          );
        }
      );
    }else if(locationController.text.isEmpty){
      var _current = await Geolocator().getCurrentPosition();
      setState(() {
        position = _current;
        isMapLoading = false;
      });
    }else{
      List<Placemark> _placeMark = await Geolocator().placemarkFromAddress(locationController.text);
      Marker _newMarker = Marker(
        markerId: MarkerId(_placeMark[0].name),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: _placeMark[0].name),
      );
      allMarkers.add(_newMarker);
      setState(() {
        position = _placeMark[0].position;
        isMapLoading = false;
      });
    }
  }
}
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:seniorsteps/models/mainmodel.dart';
import 'package:seniorsteps/models/user/googleauth.dart';
import 'package:seniorsteps/screens/bottomnavbar/bottomnavbar.dart';
import 'package:seniorsteps/widgets/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> with TickerProviderStateMixin {

TabController tabController;

@override
void initState() {
  tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Welcome!',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        bottom: PreferredSize(
          preferredSize: Size(0.0, 30.0),
          child: TabBar(
            tabs: [
              Text('Sign In'), Text('Register')
            ],
            controller: tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              border: Border.all(color: Colors.black, width: 0.5)
            ),
            labelStyle: TextStyle(color: Colors.black, fontSize: 15.0),
            unselectedLabelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        child: TabBarView(
          controller: tabController,
          children: [
            SignIn(),
            Register()
          ],
        ),
      ),
    );
  }
}



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

bool pressed = true;

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController resetEmailController = TextEditingController();

GlobalKey<FormState> emailKey = GlobalKey<FormState>();
GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
GlobalKey<FormState> resetEmailKey = GlobalKey<FormState>();

final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            field('email', Icons.email, TextInputType.emailAddress, emailController, emailKey),
            field('password', Icons.lock, TextInputType.text, passwordController, passwordKey),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: Text(
                          'Reset Password?!',
                          style: TextStyle(color: Colors.grey, fontSize: 15.0),
                        ),
                        content: field('email', Icons.email, TextInputType.emailAddress, resetEmailController, resetEmailKey),
                        actions: [
                          FlatButton(
                            color: Colors.grey,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            color: Colors.teal,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            child: Text(
                              'Send Link',
                              style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {},
                          ),
                        ],
                      );
                    }
                  );
                },
                  child: Text(
                  'Forgot Password?!',
                  style: TextStyle(color: Colors.grey, fontSize: 15.0),
                ),
              ),
            ),
            Column(
              children: [
                FlatButton(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      SharedPreferences user = await SharedPreferences.getInstance();
                      user.setString('email', emailController.text);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return BottomNavBar();}));
                    }else{
                      Scaffold.of(context).showSnackBar(snack('some fields required!')); 
                    }
                  },
                ),
                Google()
              ],
            ),
          ],
        ),
      ),
    );
  }
  snack(String fieldName) {
    return SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0),)),
      backgroundColor: Colors.red,
      content: Text(
        '$fieldName Fields Required!',
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
          suffixIcon: label == 'password' ? IconButton(
            icon: Icon(Icons.remove_red_eye),
            color: Colors.grey,
            iconSize: 20.0,
            onPressed: () {
              setState(() {
                pressed = !pressed;
              });
            },
          ) : null
        ),
        keyboardType: type,
        textInputAction: TextInputAction.done,
        obscureText: label == 'password' ? pressed : false,
        controller: controller,
      ),
    );
  }
}



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

bool pressed = true;

final TextEditingController emailController = TextEditingController();
final TextEditingController nameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

GlobalKey<FormState> emailKey = GlobalKey<FormState>();
GlobalKey<FormState> nameKey = GlobalKey<FormState>();
GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

final _formKey = GlobalKey<FormState>();

String gender = 'None';

DateTime date = DateTime(1990);

bool check = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            field('email', Icons.email, TextInputType.emailAddress, emailController, emailKey),
            field('full name', Icons.account_circle, TextInputType.text, nameController, nameKey),
            field('password', Icons.lock, TextInputType.text, passwordController, passwordKey),
            item(
              'Gender',
              gender,
              PopupMenuButton(
                icon: Icon(Icons.arrow_drop_down, color: Colors.grey, size: 20.0),
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<dynamic>>[
                    PopupMenuItem(
                      child: Text('Male'),
                      value: 'Male',
                    ),
                    PopupMenuItem(
                      child: Text('FeMale'),
                      value: 'FeMale',
                    ),
                  ];
                },
                onSelected: (value) {
                  setState(() {
                    gender = value;
                  });
                },
              ),
              null
            ),
            item(
              'Date of Birth',
              date.toString().substring(0, 10),
              Icon(Icons.date_range, color: Colors.grey, size: 20.0),
              () async {
                var _selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1970),
                      lastDate: DateTime.now()
                );
                setState(() {
                  date = _selectedDate;
                });
              }
            ),
            item(
              'Terms & Conditions',
              'read our terms & conditions',
              Checkbox(
                value: check,
                activeColor: Colors.grey[100],
                checkColor: Colors.black,
                hoverColor: Colors.white,
                onChanged: (value){
                  setState(() {
                    check = value;
                  });
                },
              ),
              () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  builder: (BuildContext context){
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      child: ListTile(
                        title: Text(
                          'Read Carfeully',
                          style: TextStyle(color: Colors.teal, fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '1- ofhldskfdskfjdsjf\n2- ousdufhdslffds\n3-sldfjndslfndslfndslnsfl\n1- ofhldskfdskfjdsjf\n2- ousdufhdslffds\n3-sldfjndslfndslfndslnsfl',
                          style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(Icons.notification_important, color: Colors.red, size:20.0),
                      ),
                    );
                  }
                );
              }
            ),
            Column(
              children: [
                ScopedModelDescendant<MainModel>(
                  builder: (context, child, MainModel model){
                    return FlatButton(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                      child: model.isUserLoading == true ? Center(child: Loading()) : Text(
                        'Register',
                        style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        if(_formKey.currentState.validate()){
                          bool _valid = await model.userSignUp(emailController.text, passwordController.text, nameController.text, gender, date.toString().substring(0,10));
                          SharedPreferences user = await SharedPreferences.getInstance();
                          user.setString('email', emailController.text);
                          if(_valid == true){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return BottomNavBar();}));
                          }else{
                            Scaffold.of(context).showSnackBar(snack('error sign up try again!')); 
                          }
                        }else{
                          Scaffold.of(context).showSnackBar(snack('some fields required!')); 
                        }
                      },
                    );
                  }
                ),
                Google()
              ],
            ),
          ],
        ),
      ),
    );
  }
  item(String title, String subtitle, Widget trailing, Function onTap) {
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
        onTap: onTap
      ),
    );
  }
  snack(String fieldName) {
    return SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0),)),
      backgroundColor: Colors.red,
      content: Text(
        '$fieldName Fields Required!',
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
          suffixIcon: label == 'password' ? IconButton(
            icon: Icon(Icons.remove_red_eye),
            color: Colors.grey,
            iconSize: 20.0,
            onPressed: () {
              setState(() {
                pressed = !pressed;
              });
            },
          ) : null
        ),
        keyboardType: type,
        textInputAction: TextInputAction.done,
        obscureText: label == 'password' ? pressed : false,
        controller: controller,
      ),
    );
  }
}



class Google extends StatefulWidget {
  @override
  _GoogleState createState() => _GoogleState();
}

class _GoogleState extends State<Google> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Text(
        'Google',
        style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    onPressed: () {
      googleAuth().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return BottomNavBar();})));
    },
    );
  }
}
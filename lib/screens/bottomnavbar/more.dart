import 'package:flutter/material.dart';



class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {

List<IconData> icons = [
  Icons.settings, Icons.info, Icons.phone
];

List title = [
  'Setting', 'About Us', 'Contact Us'
];

List subTitle = [
  'Edit your Data', 'Know more about us', 'Get help'
];

List screens = [
  'setting', 'aboutUs', 'contactUs'
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'More',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          separatorBuilder: (context, index){
            return Divider(color: Colors.grey, height: 10.0,);
          },
          itemCount: title.length,
          itemBuilder: (context, index){
            return ListTile(
                leading: Icon(icons[index], color: Colors.black, size: 20.0),
                title: Text(
                  title[index],
                  style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
                ),
                subtitle: Text(
                  subTitle[index],
                  style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight:  FontWeight.normal),
                ),
                trailing: Icon(Icons.navigate_next, color: Colors.grey, size: 20.0),
                onTap: () {
                  Navigator.pushNamed(context, screens[index]);
                },
              );
          },
        ),
      ),
    );
  }
}
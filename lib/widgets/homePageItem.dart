import 'package:flutter/material.dart';




class HomePageItem extends StatefulWidget {

final String image;
final String name;

HomePageItem(this.image, this.name);

  @override
  _HomePageItemState createState() => _HomePageItemState();
}

class _HomePageItemState extends State<HomePageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/2.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          Container(
            height: 100.0,
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.fill
              ),
            ),
          ),
          Text(
            widget.name,
            style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
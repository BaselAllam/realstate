import 'package:flutter/material.dart';
import 'package:seniorsteps/widgets/rating.dart';



class Item extends StatefulWidget {

final String name;
final String image;
final String className;

Item(this.name, this.image, this.className);


  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {

bool pressed;

checkClass() {
  if(widget.className == 'saved'){
    setState(() {
      pressed = true;
    });
  }else{
    setState(() {
      pressed = false;
    });
  }
}


@override
void initState() {
  checkClass();
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.9),
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/pp.png'),
            ),
            title: Text(
              'Adam Malek',
              style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              'Netherland, Amesterdam',
              style: TextStyle(color: Colors.grey, fontSize: 13.0, fontWeight: FontWeight.bold),
            ),
            trailing: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.teal[100],
                borderRadius: BorderRadius.circular(15.9),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'For Sale',
                  style: TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height/2.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.fill
              )
            ),
          ),
          ListTile(
            title: Text(
              '20K\$ - Negotinal - 550 M2 - ${widget.name}',
              style: TextStyle(color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.normal),
            ),
            trailing: widget.className == 'active' ? IconButton(
              icon: Icon(Icons.more_vert),
              color: pressed == false ? Colors.grey : Colors.teal,
              iconSize: 20.0,
              onPressed: () {}
            ) : IconButton(
              icon: Icon(Icons.bookmark),
              color: pressed == false ? Colors.grey : Colors.teal,
              iconSize: 20.0,
              onPressed: () {
                setState(() {
                  pressed = !pressed;
                });
              },
            ),
            subtitle: RatingBar(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.teal,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
        ],
      ),
    );
  }
}
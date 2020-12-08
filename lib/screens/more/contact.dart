import 'package:flutter/material.dart';



class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

List gotMsg = ['Hi', 'How Are you', 'my name is bassel'];

List sendMsg = ['hi'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Contact Us',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight:  FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Colors.black, size: 20.0),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: gotMsg.length,
                itemBuilder: (context, index){
                  return Column(
                    children: [
                      msg(gotMsg[index], false),
                      msg(sendMsg[index], true)
                    ],
                  );
                },
              ),
            ),
            SafeArea(
              bottom: true,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
                child: ListTile(
                  title: Text('Write your message', style: TextStyle(color: Colors.grey, fontSize: 15.0,)),
                  trailing: IconButton(
                    icon: Icon(Icons.send),
                    color: Colors.grey,
                    iconSize: 20.0,
                    onPressed: () {
                      setState(() {
                        sendMsg.add('message');
                      });
                    }
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  msg(String message, bool gotOrSend) {
    return Align(
      alignment: gotOrSend == true ? Alignment.centerRight : Alignment.centerLeft,
      child: ListTile(
        leading: Image.asset('assets/pp.png'),
        title: Text(
          message,
          style: TextStyle(color: Colors.black, fontSize: 20.0)
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';



class ReceivedMessagesWidget extends StatelessWidget {
  final int i;
  final String txt;
  const ReceivedMessagesWidget({
    Key key,
    this.txt,
    @required this.i,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: <Widget>[
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Colors.cyan,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                child: Text(
                  txt,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)
                      
                ),
              ),
            ],
          ),
          SizedBox(width: 15),
          
        ],
      ),
    );
  }
}
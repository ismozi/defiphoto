import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'pageCommentaire.dart';
import 'fadeRoute.dart';

class listViewWidget extends StatefulWidget {
  final int nbItem;
  final List<String> txt;
   int d;

  listViewWidget({this.nbItem, this.txt}) {
    txt.length = nbItem;
    d=1;
  }

  @override
  State<StatefulWidget> createState() => listViewWidgetState();
}

class listViewWidgetState extends State<listViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 4800,
      child: ListView.builder(
          itemCount: widget.nbItem,
          itemExtent: 150,
          padding: const EdgeInsets.all(7.0),
          itemBuilder: (context, position) {
            return Card(
              color:Colors.grey[850],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      topLeft: Radius.circular(15)),
                  side: BorderSide(width: 0.5, color: Colors.grey)),
              child: ListTile(
                title: Text(
                  widget.txt[position],
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (context) =>
                          (pageCommentaire(txt: widget.txt[position]))));
                },
              ),
            );
          }),
    );
  }
}

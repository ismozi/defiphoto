import 'package:flutter/material.dart';

class listViewWidget extends StatefulWidget {
  
  final int nbItem;
  final List<String> txt;
  

  listViewWidget({
    this.nbItem,
    this.txt,
    
  }){
    txt.length = nbItem;  
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
              child: ListTile(
                title: Text(
                  widget.txt[position],
                  
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                      
          
                ),
                
                onTap: () => {},
              ),
            );
          }),
    );
  
  
  }
  }


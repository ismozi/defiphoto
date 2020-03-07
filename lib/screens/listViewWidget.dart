import 'package:flutter/material.dart';

class listViewWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.0,
      child: ListView.builder(
          itemCount: 3,
          itemExtent: 150,
          padding: const EdgeInsets.all(7.0),
          itemBuilder: (context, position) {
            return Card(
              child: ListTile(
                title: Text(
                  'Question \noui',
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

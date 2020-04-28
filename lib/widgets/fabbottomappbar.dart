import 'package:flutter/material.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.text});
  String text;
}

class FABBottomAppBar extends StatefulWidget {
  FABBottomAppBar(
      {this.items,
      this.centerItemText,
      this.height: 60.0,
      this.iconSize: 24.0,
      this.backgroundColor,
      this.color,
      this.selectedColor,
      this.notchedShape,
      this.onTabSelected,
      this.role,
      this.questionEleve}) {
    assert(this.items.length == 6);
  }
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;
  final String role;
  final bool questionEleve;

  @override
  State<StatefulWidget> createState() => FABBottomAppBarState();
}

class FABBottomAppBarState extends State<FABBottomAppBar> {
  int _selectedIndex = 0;

  _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });
    widget.role == 'S' || widget.questionEleve == true
        ? null
        : items.insert(items.length >> 1, _buildMiddleTabItem());

// comment test pour la branchhe
    return BottomAppBar(
        child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xff141a24), Color(0xFF2b3444)])),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
    ));
  }

  Widget _buildMiddleTabItem() {
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: widget.iconSize),
            Text(
              widget.centerItemText ?? "QUESTION",
              style: TextStyle(
                  color: widget.color, fontFamily: 'Arboria', fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _selectedIndex == index
                    ? ClipOval(child:Material(
                        color: Colors.blueGrey,
                        child: SizedBox(width: 35, height: 35,child:Center(child:Text(
                          widget.centerItemText ?? item.text,
                          style: TextStyle(
                              color: color,
                              fontSize: _selectedIndex == index ? 25 : 25,
                              fontFamily: 'Arboria'),
                        )))))
                    : Text(
                        widget.centerItemText ?? item.text,
                        style: TextStyle(
                            color: color,
                            fontSize: _selectedIndex == index ? 32 : 25,
                            fontFamily: 'Arboria'),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

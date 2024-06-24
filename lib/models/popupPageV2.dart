

import 'package:flutter/material.dart';

class PopupLayout extends ModalRoute {
  double top;
  double bottom;
  double left;
  double right;
  Color bgColor;
  final Widget child;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor =>
      bgColor == null ? Colors.black.withOpacity(0.5) : bgColor;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => false;

  PopupLayout(
      {Key key,
        this.bgColor,
        @required this.child,
        this.top,
        this.bottom,
        this.left,
        this.right});

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    if (top == null) this.top = 10;
    if (bottom == null) this.bottom = 20;
    if (left == null) this.left = 20;
    if (right == null) this.right = 20;

    return GestureDetector(
      onTap: () {
        // call this method here to hide soft keyboard
        //  SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      child: Material(
        // This makes sure that text and other content follows the material style
        type: MaterialType.transparency,
        //type: MaterialType.canvas,
        // make sure that the overlay content is not cut off
        child: SafeArea(
          bottom: true,
          child: _buildOverlayContent(context),
        ),
      ),
    );
  }

  //the dynamic content pass by parameter
  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: this.bottom,
          left: this.left,
          right: this.right,
          top: this.top),
      child: child,
    );
  }

//
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {

    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );

  }
}

class PopupContent extends StatefulWidget {
  final Widget content;

  PopupContent({this.content, Key key}) : super(key: key);

  @override
  _PopupContentState createState() => _PopupContentState();
}

class _PopupContentState extends State<PopupContent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        child: widget.content,
        // TODO OU METTRE UNE DECORATION DU CONTAINER  decoration: BoxDecoration(),
      ),
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
}

class PopupPage {
  double top = 100;
  double right = 45;
  double left = 45;
  double bottom = 100;

  final Widget widget;
  BuildContext context;
  String title;
  BuildContext popupContext;

  PopupPage.defaut(this.widget, this.context, this.title, {this.popupContext});

  PopupPage.custom(this.widget,
      {this.top, this.left, this.bottom, this.right, this.context, this.title});

  void showPopup() {
    Navigator.push(
        context,
        PopupLayout(
          top: top,
          bottom: bottom,
          right: right,
          left: left,
          child: PopupContent(
            content: SafeArea(
              top: true,
              bottom: true,
              child: Scaffold(
                body: widget,
                appBar: AppBar(
                  title: Text(title),
                ),
              ),
            ),
          ),
        ));
  }
}
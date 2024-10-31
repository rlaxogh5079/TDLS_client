import 'dart:ui';

import 'package:flutter/material.dart';

void createDialog(
    dynamic context, String title, Widget content, Widget actions) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return _DynamicDialog(
            actions: actions,
            title: title,
            content: content,
          );
        },
      );
    },
  );
}

// ignore: must_be_immutable
class _DynamicDialog extends StatefulWidget {
  var title;
  var content;
  var actions;

  _DynamicDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.actions})
      : super(key: key);
  @override
  __DynamicDialogState createState() => __DynamicDialogState();
}

class __DynamicDialogState extends State<_DynamicDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(widget.title),
          ],
        ),
        content: Container(child: widget.content),
        actions: [widget.actions],
      ),
    );
  }
}

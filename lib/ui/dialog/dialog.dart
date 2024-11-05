import 'dart:ui';

import 'package:flutter/material.dart';

void createDialog(dynamic context, String title, Widget content) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return _DynamicDialog(
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

  _DynamicDialog({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);
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
        actions: [
          TextButton(
            child: const Text("닫기"),
            onPressed: () async {
              Navigator.pop(context);
              try {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              } catch (e) {
                return;
              }
              return;
            },
          ),
        ],
      ),
    );
  }
}

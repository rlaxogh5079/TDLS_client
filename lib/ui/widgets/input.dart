import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';

class TDLSInput extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final GlobalKey<FormState> formKey;
  final bool isPassword;
  final FilledButton? button;
  final bool isCheck;
  final Null Function()? onChanged;
  final String? errorText;

  const TDLSInput({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.formKey,
    this.errorText,
    this.button,
    this.isPassword = false,
    this.onChanged,
    this.isCheck = false,
  });

  @override
  _TDLSInputState createState() => _TDLSInputState();
}

class _TDLSInputState extends State<TDLSInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      onChanged: widget.onChanged,
      child: Column(
        children: [
          SizedBox(
            width: 100.w,
            height: 9.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80.w,
                  height: 8.h,
                  padding: EdgeInsets.fromLTRB(4.w, 0, 2.w, 0),
                  decoration: BoxDecoration(
                    color: Colors.grey[900],
                    border: Border.all(
                      color: widget.controller.text.isEmpty
                          ? Colors.grey
                          : Colors.white,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: widget.controller,
                          obscureText: widget.isPassword,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: widget.labelText,
                            hintText: widget.hintText,
                            floatingLabelStyle: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      if (widget.button != null)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                          ),
                          child: SizedBox(
                            width: 12.h,
                            child: widget.button,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            widget.errorText ?? '',
            style: TextStyle(
              color: Colors.red,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}

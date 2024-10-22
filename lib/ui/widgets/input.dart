import 'package:client/utils/form_checker.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TDLSInput extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final GlobalKey<FormState> formKey;
  final bool isPassword;
  final String? Function(String) validator;

  const TDLSInput({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.formKey,
    required this.validator,
    this.isPassword = false,
  });

  @override
  _TDLSInputState createState() => _TDLSInputState();
}

class _TDLSInputState extends State<TDLSInput> {
  String? _errorText;

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
      child: Column(
        children: [
          SizedBox(
            width: 100.w,
            height: 8.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 80.w,
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _errorText = validateID(value);
                      });
                    },
                    controller: widget.controller,
                    obscureText: widget.isPassword,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: widget.controller.text.isEmpty
                              ? Colors.grey
                              : Colors.white,
                          width: 1.0,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                      iconColor: Colors.grey[500],
                      labelText: widget.labelText,
                      floatingLabelStyle: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                      hintText: widget.hintText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            _errorText ?? '',
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

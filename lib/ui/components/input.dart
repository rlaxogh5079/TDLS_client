import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TDLSInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final GlobalKey<FormState> formKey;
  final bool isPassword;

  const TDLSInput({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.formKey,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SizedBox(
        width: 100.w,
        height: 10.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80.w,
              child: TextFormField(
                controller: controller,
                obscureText: isPassword,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color:
                          controller.text.isEmpty ? Colors.grey : Colors.white,
                      width: 1.0,
                    ),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                  iconColor: Colors.grey[500],
                  labelText: labelText,
                  floatingLabelStyle: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                  ),
                  hintText: hintText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

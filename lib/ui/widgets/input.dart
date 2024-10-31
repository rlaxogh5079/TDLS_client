import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';

class TDLSInput extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final GlobalKey<FormState> formKey;
  final bool isPassword;
  final String? Function(String) validator;
  final bool isButtonRequired;
  final String? buttonText;
  final bool? isCheck;
  final Future<Null> Function()? onPressed;
  final Null Function()? onChanged;

  const TDLSInput({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.formKey,
    required this.validator,
    this.isPassword = false,
    this.isButtonRequired = false,
    this.buttonText,
    this.onPressed,
    this.onChanged,
    this.isCheck,
  });

  @override
  _TDLSInputState createState() => _TDLSInputState();
}

class _TDLSInputState extends State<TDLSInput> {
  String? _errorText;

  @override
  void initState() {
    super.initState();
    if (widget.isButtonRequired) {
      assert(widget.isCheck != null, "Button의 isCheck옵션은 필수 입니다!");
      assert(widget.onPressed != null, "Button의 onPressed 메소드는 필수로 정의되어야 합니다!");
    }
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
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          onChanged: (value) {
                            setState(() {
                              _errorText = widget.validator(value);
                            });
                          },
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
                      if (widget.isButtonRequired)
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                          ),
                          child: FilledButton(
                            onPressed: widget.isCheck!
                                ? null
                                : () async {
                                    widget.onPressed!();
                                  },
                            style: FilledButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              disabledBackgroundColor: const Color(0x888B87FF),
                            ),
                            child: Text(
                              widget.buttonText ?? "중복 확인",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                              ),
                            ),
                          ),
                        ),
                    ],
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

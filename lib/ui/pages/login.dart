import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:client/ui/widgets/input.dart';
import 'package:client/ui/pages/register.dart';
import 'package:flutter/material.dart';

class TDLSLoginPage extends StatefulWidget {
  const TDLSLoginPage({super.key});

  @override
  State<TDLSLoginPage> createState() => _TDLSLoginPageState();
}

class _TDLSLoginPageState extends State<TDLSLoginPage> {
  final _userIDTextFormKey = GlobalKey<FormState>();
  final _userPasswordTextFormKey = GlobalKey<FormState>();
  late TextEditingController _userIDController;
  late TextEditingController _userPasswordController;

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _userIDController = TextEditingController();
    _userPasswordController = TextEditingController();

    _userIDController.addListener(_updateButtonState);
    _userPasswordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _userIDController.text.isNotEmpty &&
          _userPasswordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _userIDController.dispose();
    _userPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15.h),
              SizedBox(
                width: 80.w,
                height: 10.h,
                child: Text(
                  "로그인",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                  ),
                ),
              ),
              TDLSInput(
                controller: _userIDController,
                labelText: "아이디",
                hintText: "아이디를 입력하세요",
                formKey: _userIDTextFormKey,
              ),
              TDLSInput(
                controller: _userPasswordController,
                labelText: "비밀번호",
                hintText: "비밀번호를 입력하세요",
                formKey: _userPasswordTextFormKey,
                isPassword: true,
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 80.w,
                height: 5.h,
                child: FilledButton(
                  onPressed: _isButtonEnabled ? () {} : null,
                  style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                    disabledBackgroundColor: const Color(0x888B87FF),
                  ),
                  child: Text(
                    "로그인",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 80.w,
                height: 10.h,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        indent: 20.0,
                        endIndent: 10.0,
                        thickness: 2,
                      ),
                    ),
                    Text(
                      "또는",
                    ),
                    Expanded(
                      child: Divider(
                        indent: 10.0,
                        endIndent: 20.0,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 80.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("계정이 없으신가요?"),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      child: const Text(
                        "계정 만들기",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TDLSRegisterPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

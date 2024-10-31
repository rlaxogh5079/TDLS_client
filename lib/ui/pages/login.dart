import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:client/utils/secure_storage.dart';
import 'package:client/utils/model/response.dart';
import 'package:client/utils/form_checker.dart';
import 'package:client/ui/pages/register.dart';
import 'package:client/ui/widgets/input.dart';
import 'package:client/ui/dialog/dialog.dart';
import 'package:client/utils/api/user.dart';
import 'package:client/ui/pages/home.dart';
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
          _userPasswordController.text.isNotEmpty &&
          validateID(_userIDController.text) == null &&
          validatePassword(_userPasswordController.text) == null;
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
                validator: validateID,
              ),
              TDLSInput(
                controller: _userPasswordController,
                labelText: "비밀번호",
                hintText: "비밀번호를 입력하세요",
                formKey: _userPasswordTextFormKey,
                isPassword: true,
                validator: validatePassword,
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 80.w,
                height: 5.h,
                child: FilledButton(
                  onPressed: _isButtonEnabled
                      ? () async {
                          ResponseWithAccessToken result = await login(
                              _userIDController.text,
                              _userPasswordController.text);
                          String resultTitle = "";
                          String resultContent = "";
                          String token = "";
                          bool success = false;
                          switch (result.statusCode) {
                            case 200:
                              success = true;
                              resultTitle = "로그인 성공";
                              resultContent = result.message;
                              token = result.accessToken ?? "";
                              break;
                            case 401:
                              resultTitle = "로그인 실패";
                              resultContent = result.message;
                              break;
                            case 500:
                              resultTitle = "서버 내부 오류";
                              resultContent = result.message;
                              break;
                          }
                          if (success) {
                            await SecureStorage()
                                .storage
                                .write(key: "auto_login", value: "true");
                            await SecureStorage()
                                .storage
                                .write(key: "access_token", value: token);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TDLSHomePage(),
                              ),
                            );
                          } else {
                            createDialog(
                              context,
                              resultTitle,
                              Text(resultContent),
                              TextButton(
                                child: const Text("닫기"),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  try {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                  } catch (e) {
                                    return;
                                  }
                                  return;
                                },
                              ),
                              null,
                              false,
                            );
                          }
                        }
                      : null,
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

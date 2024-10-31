import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:client/ui/pages/register_second.dart';
import 'package:client/utils/model/response.dart';
import 'package:client/utils/form_checker.dart';
import 'package:client/ui/widgets/input.dart';
import 'package:client/ui/dialog/dialog.dart';
import 'package:client/utils/api/user.dart';
import 'package:client/ui/pages/login.dart';
import 'package:flutter/material.dart';

class TDLSRegisterPage extends StatefulWidget {
  const TDLSRegisterPage({super.key});

  @override
  State<TDLSRegisterPage> createState() => _TDLSRegisterPageState();
}

class _TDLSRegisterPageState extends State<TDLSRegisterPage> {
  final _userIDTextFormKey = GlobalKey<FormState>();
  final _userPasswordTextFormKey = GlobalKey<FormState>();
  final _userPasswordConfirmKey = GlobalKey<FormState>();
  late TextEditingController _userIDController;
  late TextEditingController _userPasswordController;
  late TextEditingController _userPasswordConfirmController;
  late bool checkDuplicateID = false;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _userIDController = TextEditingController();
    _userPasswordController = TextEditingController();
    _userPasswordConfirmController = TextEditingController();

    _userIDController.addListener(_updateButtonState);
    _userPasswordController.addListener(_updateButtonState);
    _userPasswordConfirmController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _userIDController.text.isNotEmpty &&
          _userPasswordController.text.isNotEmpty &&
          _userPasswordConfirmController.text.isNotEmpty &&
          validateID(_userIDController.text) == null &&
          validatePassword(_userPasswordController.text) == null &&
          validatePasswordConfirm(_userPasswordController.text,
                  _userPasswordConfirmController.text) ==
              null &&
          checkDuplicateID;
    });
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
              SizedBox(height: 10.h),
              SizedBox(
                width: 80.w,
                height: 10.h,
                child: Text(
                  "회원가입",
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
                isButtonRequired: true,
                isCheck: checkDuplicateID,
                onChanged: () {
                  setState(() {
                    checkDuplicateID = false;
                  });
                },
                onPressed: () async {
                  GeneralResponse result =
                      await checkDuplicate("user_id", _userIDController.text);
                  String resultTitle = "";
                  String resultContent = "";
                  switch (result.statusCode) {
                    case 200:
                      setState(() {
                        checkDuplicateID = true;
                      });
                      resultTitle = "축하합니다!";
                      resultContent = result.message;
                      break;
                    case 409:
                      resultTitle = "중복된 아이디";
                      resultContent = result.message;
                      break;
                    case 422:
                      resultTitle = "클라이언트 오류";
                      resultContent = result.message;
                      break;
                    case 500:
                      resultTitle = "서버 내부 오류";
                      resultContent = result.message;
                      break;
                  }
                  createDialog(
                    context,
                    resultTitle,
                    Text(resultContent),
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
                  );
                },
              ),
              TDLSInput(
                controller: _userPasswordController,
                labelText: "비밀번호",
                hintText: "비밀번호를 입력하세요",
                formKey: _userPasswordTextFormKey,
                isPassword: true,
                validator: validatePassword,
              ),
              TDLSInput(
                controller: _userPasswordConfirmController,
                labelText: "비밀번호 재입력",
                hintText: "비밀번호를 다시 입력하세요",
                formKey: _userPasswordConfirmKey,
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TDLSRegisterSecondPage(),
                            ),
                          );
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
                    "다음 (1/2)",
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
                    const Text("계정이 이미 있으신가요?"),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      child: const Text(
                        "로그인하기",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TDLSLoginPage(),
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

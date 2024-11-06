import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:client/utils/model/response.dart';
import 'package:client/utils/form_checker.dart';
import 'package:client/ui/widgets/input.dart';
import 'package:client/ui/dialog/dialog.dart';
import 'package:client/utils/api/user.dart';
import 'package:client/ui/pages/login.dart';
import 'package:flutter/material.dart';

class TDLSRegisterSecondPage extends StatefulWidget {
  final String userID;
  final String password;
  const TDLSRegisterSecondPage({
    super.key,
    required this.userID,
    required this.password,
  });

  @override
  State<TDLSRegisterSecondPage> createState() => _TDLSRegisterSecondPage();
}

class _TDLSRegisterSecondPage extends State<TDLSRegisterSecondPage> {
  final _userNicknameTextFormKey = GlobalKey<FormState>();
  final _userEmailTextFormKey = GlobalKey<FormState>();
  final _emailVerifyTextFormKey = GlobalKey<FormState>();
  late TextEditingController _userNicknameController;
  late TextEditingController _userEmailController;
  late TextEditingController _emailVerifyController;
  bool checkDuplicateNickname = false;
  bool checkDuplicateEmail = false;
  bool verifiedEmail = false;
  bool _isButtonEnabled = false;
  bool isRequestEmail = false;

  @override
  void initState() {
    super.initState();
    _userNicknameController = TextEditingController();
    _userEmailController = TextEditingController();
    _emailVerifyController = TextEditingController();

    _userNicknameController.addListener(_updateButtonState);
    _userEmailController.addListener(_updateButtonState);
    _emailVerifyController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _userNicknameController.text.isNotEmpty &&
          _userEmailController.text.isNotEmpty &&
          _emailVerifyController.text.isNotEmpty &&
          validateNickname(_userNicknameController.text) == null &&
          validateEmail(_userEmailController.text) == null &&
          checkDuplicateNickname &&
          checkDuplicateEmail &&
          verifiedEmail;
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
                controller: _userNicknameController,
                labelText: "닉네임",
                hintText: "닉네임을 입력하세요",
                formKey: _userNicknameTextFormKey,
                validator: validateNickname,
                button: FilledButton(
                  onPressed: checkDuplicateNickname == false
                      ? () async {
                          GeneralResponse result = await checkDuplicate(
                              "nickname", _userNicknameController.text);
                          String resultTitle = "";
                          String resultContent = "";
                          switch (result.statusCode) {
                            case 200:
                              setState(() {
                                checkDuplicateNickname = true;
                              });
                              resultTitle = "축하합니다!";
                              resultContent = result.message;
                              break;
                            case 409:
                              resultTitle = "중복된 닉네임";
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
                          );
                        }
                      : null,
                  style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    disabledBackgroundColor: const Color(0x888B87FF),
                  ),
                  child: Text(
                    "중복 확인",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
                isCheck: checkDuplicateNickname,
                onChanged: () {
                  setState(() {
                    checkDuplicateNickname = false;
                  });
                },
              ),
              TDLSInput(
                controller: _userEmailController,
                labelText: "이메일",
                hintText: "이메일을 입력하세요",
                formKey: _userEmailTextFormKey,
                validator: validateEmail,
                isCheck: checkDuplicateEmail,
                button: FilledButton(
                  onPressed: isRequestEmail == false
                      ? () async {
                          setState(() {
                            isRequestEmail = true;
                          });
                          GeneralResponse result = await checkDuplicate(
                            "email",
                            _userEmailController.text,
                          );
                          String resultTitle = "";
                          String resultContent = "";
                          if (result.statusCode != 200) {
                            switch (result.statusCode) {
                              case 409:
                                resultTitle = "중복된 이메일";
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
                          } else {
                            checkDuplicateEmail = true;
                            GeneralResponse result = await sendEmailRequest(
                                _userEmailController.text);
                            switch (result.statusCode) {
                              case 200:
                                setState(() {
                                  checkDuplicateNickname = true;
                                });
                                resultTitle = "메일 전송 성공!";
                                resultContent = result.message;
                                break;
                              case 500:
                                resultTitle = "서버 내부 오류";
                                resultContent = result.message;
                                break;
                            }
                          }
                          createDialog(
                            context,
                            resultTitle,
                            Text(resultContent),
                          );
                        }
                      : null,
                  style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    disabledBackgroundColor: const Color(0x888B87FF),
                  ),
                  child: Text(
                    checkDuplicateEmail ? "재요청" : "인증 요청",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
              TDLSInput(
                controller: _emailVerifyController,
                labelText: "인증번호",
                hintText: "인증번호를 입력하세요",
                formKey: _emailVerifyTextFormKey,
                isCheck: verifiedEmail,
                button: FilledButton(
                  onPressed: isRequestEmail && !verifiedEmail
                      ? () async {
                          GeneralResponse result = await verifyEmail(
                              _userEmailController.text,
                              _emailVerifyController.text);

                          String resultTitle = "";
                          String resultContent = "";
                          switch (result.statusCode) {
                            case 200:
                              setState(() {
                                verifiedEmail = true;
                              });
                              resultTitle = "인증 완료";
                              resultContent = result.message;
                              break;
                            case 401:
                              resultTitle = "잘못된 인증 코드";
                              resultContent = result.message;
                              break;
                            case 408:
                              resultTitle = "시간 초과";
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
                          if (!verifiedEmail) {
                            setState(() {
                              isRequestEmail = false;
                            });
                          }
                          createDialog(
                            context,
                            resultTitle,
                            Text(resultContent),
                          );
                        }
                      : null,
                  style: FilledButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    disabledBackgroundColor: const Color(0x888B87FF),
                  ),
                  child: Text(
                    "중복 확인",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              SizedBox(
                width: 80.w,
                height: 5.h,
                child: FilledButton(
                  onPressed: _isButtonEnabled
                      ? () async {
                          GeneralResponse result = await register(
                              widget.userID,
                              widget.password,
                              _userNicknameController.text,
                              _userEmailController.text);

                          String resultTitle = "";
                          String resultContent = "";
                          switch (result.statusCode) {
                            case 200:
                              resultTitle = "회원가입 완료";
                              resultContent = result.message;
                              break;
                            case 409:
                              resultTitle = "중복된 정보";
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
                          if (!verifiedEmail) {
                            setState(() {
                              isRequestEmail = false;
                            });
                          }
                          createDialog(
                            context,
                            resultTitle,
                            Text(resultContent),
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
                    "회원가입",
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

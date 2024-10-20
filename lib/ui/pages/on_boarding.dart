import 'package:introduction_screen/introduction_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:client/ui/pages/login.dart';
import 'package:flutter/material.dart';

class TDLSOnBoardingPage extends StatefulWidget {
  const TDLSOnBoardingPage({super.key});

  @override
  State<TDLSOnBoardingPage> createState() => _TDLSOnBoardingPageState();
}

class _TDLSOnBoardingPageState extends State<TDLSOnBoardingPage> {
  final _introKey = GlobalKey<IntroductionScreenState>();
  bool _skipState = true;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: Center(
        child: IntroductionScreen(
          key: _introKey,
          onChange: (value) {
            index = value;
            if (value == 2) {
              _skipState = false;
            } else {
              _skipState = true;
            }
            setState(() {});
          },
          controlsMargin: EdgeInsets.fromLTRB(0, 0, 0, 30.h),
          globalHeader: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
                child: SizedBox(
                  width: 20.w,
                  child: TextButton(
                    onPressed: () {
                      _introKey.currentState!.skipToEnd();
                    },
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(0),
                        ),
                      ),
                    ),
                    child: SizedBox(
                      width: 100.w,
                      child: Text(
                        _skipState ? "건너뛰기" : "",
                        style: TextStyle(color: Colors.grey, fontSize: 15.sp),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          globalFooter: SizedBox(
            width: 90.w,
            height: 10.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    _introKey.currentState?.previous();
                  },
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(0),
                      ),
                    ),
                  ),
                  child: const Text(
                    "이전",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                index != 2
                    ? FilledButton(
                        onPressed: () {
                          _introKey.currentState?.next();
                        },
                        style: FilledButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "다음",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    : FilledButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const TDLSLoginPage(),
                            ),
                          );
                        },
                        style: FilledButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(0),
                            ),
                          ),
                        ),
                        child: const Text(
                          "시작하기",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
              ],
            ),
          ),
          pages: [
            PageViewModel(
              title: "",
              bodyWidget: getBodyWidget(
                './assets/images/intro1.png',
                '업무를 관리하세요',
                '당신의 업무를 무료로 쉽게 관리할 수 있습니다.',
              ),
            ),
            PageViewModel(
              title: "",
              bodyWidget: getBodyWidget(
                './assets/images/intro2.png',
                '매일 업무를 추가하세요',
                '개인 또는 동료들과 함께 매일 업무를 추가시키고 관리할 수 있습니다.',
              ),
            ),
            PageViewModel(
              title: "",
              bodyWidget: getBodyWidget(
                './assets/images/intro3.png',
                '업무를 분류하세요',
                '개인 또는 동료들과 함께 업무를 카테고리 별로 구분시키고 관리할 수 있습니다.',
              ),
            ),
          ],
          showDoneButton: false,
          showNextButton: false,
          showBackButton: false,
          dotsDecorator: DotsDecorator(
            color: Colors.grey,
            size: const Size(30, 5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            activeSize: const Size(30, 5),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            activeColor: Colors.white,
          ),
          curve: Curves.bounceOut,
        ),
      ),
    );
  }

  Column getBodyWidget(String imagePath, String title, String content) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: 40.h,
        ),
        SizedBox(height: 12.h),
        Text(
          title,
          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 3.h),
        Text(
          content,
          style: TextStyle(fontSize: 17.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

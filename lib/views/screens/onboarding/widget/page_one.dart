import 'package:flutter/material.dart';
import 'package:devseeker_app/views/common/exports.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: width,
          height: height,
          color: Color(kDarkPurple.value),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: height * 0.62,
                  child: Image.asset('assets/images/page1.png')),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  ReusableText(
                    text: 'Find your dream job',
                    style: appStyle(28, Color(kLight.value), FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      'We will help you find your dream job according to your skills and experience',
                      textAlign: TextAlign.center,
                      style:
                          appStyle(14, Color(kLight.value), FontWeight.normal),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:devseeker_app/views/common/exports.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: width,
          height: height,
          color: Color(kDarkBlue.value),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: height * 0.6,
                child: Image.asset('assets/images/page2.png'),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    'Stable yourself \n With Your Abilities',
                    textAlign: TextAlign.center,
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

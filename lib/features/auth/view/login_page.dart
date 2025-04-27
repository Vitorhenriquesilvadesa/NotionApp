import 'dart:ui';

import 'package:brill_app/core/network/session_manager.dart';
import 'package:brill_app/features/auth/view/auth_page_background.dart';
import 'package:brill_app/features/auth/view/gradient_button.dart';
import 'package:brill_app/features/auth/view/password_field.dart';
import 'package:brill_app/features/auth/view/register_page.dart';
import 'package:brill_app/features/editor/view/editor/editor_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final sessionManager = SessionManager();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: AuthPageBackground(
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: width / 4.0 > 300 ? width / 4.0 : 300,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withAlpha(80),
                      Colors.black.withAlpha(40),
                      Colors.black.withAlpha(150),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                      Text(
                        "Keep it all together and you'll be fine",
                        style: TextStyle(fontFamily: 'Montserrat'),
                      ),
                      SizedBox(height: 40),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(60),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration.collapsed(
                            hintText: 'Email',
                            hintStyle: TextStyle(fontFamily: 'Montserrat'),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(60),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: PasswordField(controller: passwordController),
                      ),
                      SizedBox(height: 40),
                      GradientButton(onPress: onSignIn),
                      SizedBox(height: 15),
                      Container(height: 2, color: Colors.white.withAlpha(100)),
                      SizedBox(height: 15),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(
                            255,
                            23,
                            23,
                            23,
                          ).withAlpha(200),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.github),
                            SizedBox(width: 10),
                            Text(
                              "Sign in with Github",
                              style: TextStyle(fontFamily: 'Montserrat'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Text(
                              "New in Brill? Register ",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                              ),
                            ),

                            GestureDetector(
                              onTap:
                                  () => Get.to(
                                    () => RegisterPage(),
                                    transition: Transition.noTransition,
                                    duration: Duration(seconds: 1),
                                  ),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,

                                child: Text(
                                  "now",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 14,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "!",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSignIn() async {
    final status = await sessionManager.login(
      email: emailController.text,
      password: passwordController.text,
    );

    if (status.isSuccess) {
      Get.to(
        NoteEditorPage(),
        transition: Transition.fadeIn,
        duration: Duration(seconds: 1),
      );
    }
  }
}

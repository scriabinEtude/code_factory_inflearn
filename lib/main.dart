import 'package:code_factory_inflearn/common/component/custom_text_form_field.dart';
import 'package:code_factory_inflearn/common/layout/default_layout.dart';
import 'package:code_factory_inflearn/user/view/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const _App(),
  );
}

class _App extends StatelessWidget {
  const _App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      debugShowCheckedModeBanner: false,
      home: const DefaultLayout(
        child: LoginScreen(),
      ),
    );
  }
}

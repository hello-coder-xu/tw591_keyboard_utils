import 'package:flutter/material.dart';
import 'package:tw591_keyboard_utils/tw591_keyboard_utils_platform_interface.dart';
import 'package:tw591_keyboard_utils/keyboard_listener.dart' as tw;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  tw.KeyboardListener keyboardListener = tw.KeyboardListener();

  double tempHeight = 0;

  @override
  void initState() {
    Tw591KeyboardUtilsPlatform.instance.addKeyboardChanged(tw.KeyboardListener(
      willHideKeyboard: () {
        print('软键盘 关闭');
        tempHeight = 0;
        setState(() {});
      },
      willShowKeyboard: (height) {
        print('软键盘 打开 height=$height');
        tempHeight = height;
        setState(() {});
      },
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const Expanded(
              child: Text('我是flutter'),
            ),
            const TextField(
              decoration: InputDecoration(hintText: '请输入内容'),
            ),
            Container(height: tempHeight),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tw591_keyboard_utils/listener/tw591_keyboard_listener.dart';

import 'package:tw591_keyboard_utils/tw591_keyboard_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double tempHeight = 0;

  late Tw591KeyboardListener tw591keyboardListener;

  @override
  void initState() {
    tw591keyboardListener = Tw591KeyboardListener(
      willHideKeyboard: () {
       debugPrint('软键盘 关闭');
        tempHeight = 0;
        setState(() {});
      },
      willShowKeyboard: (height) {
        debugPrint('软键盘 打开 height=$height');
        tempHeight = height;
        setState(() {});
      },
    );
    Tw591KeyboardUtils.instance.registerChanged(tw591keyboardListener);
    super.initState();
  }

  @override
  void dispose() {
    Tw591KeyboardUtils.instance.unRegisterChanged(tw591keyboardListener);
    super.dispose();
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
            Expanded(
              child: Center(child: Text('我是flutter\n 高度$tempHeight')),
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

class Tw591KeyboardListener {
  Tw591KeyboardListener({
    this.willShowKeyboard,
    this.willHideKeyboard,
  });

  final Function(double height)? willShowKeyboard;

  final Function? willHideKeyboard;
}

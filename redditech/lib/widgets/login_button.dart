import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton(this._function, this._image, this._text, {Key? key})
      : super(key: key);

  final void Function() _function;
  final String _image;
  final String _text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _function,
      style: TextButton.styleFrom(
        elevation: 1.0,
        primary: const Color(0x11FF5760),
        padding: const EdgeInsets.all(20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
        shadowColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Colors.red,
                  offset: Offset(0, 0),
                  blurRadius: 2.0,
                )
              ],
              image: DecorationImage(
                image: AssetImage(_image),
              ),
            ),
          ),
          buildButtonText(context, _text)
        ],
      ),
    );
  }

  Widget buildButtonText(BuildContext context, String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        letterSpacing: 1.5,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'OpenSans',
      ),
    );
  }
}

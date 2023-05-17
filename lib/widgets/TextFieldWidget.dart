import 'package:flutter/material.dart';

import '../pages/LoginPage.dart';
import '../pages/SingnupPage.dart';

class CallTextField extends StatefulWidget {
  const CallTextField({
    Key? key,
    this.controller,
    this.text,
    this.isPassword,
    this.icon,
    this.borderWidth,
  }) : super(key: key);
  final TextEditingController? controller;
  final bool? isPassword;
  final IconData? icon;
  final String? text;
  final double? borderWidth;
  @override
  State<CallTextField> createState() => _CallTextFieldState();
}

class _CallTextFieldState extends State<CallTextField> {
  bool _isButtonPressed = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: (widget.isPassword ?? false) ? _isButtonPressed : false,
      enableSuggestions: !(widget.isPassword ?? false),
      autocorrect: !(widget.isPassword ?? false),
      cursorColor: const Color.fromRGBO(21, 48, 132, 1),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.none,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
          color: const Color.fromRGBO(27, 63, 171, 1),
        ),
        suffixIcon: (widget.isPassword ?? false)
            ? IconButton(
                icon: Icon(
                  !_isButtonPressed ? Icons.visibility : Icons.visibility_off,
                  size: 28,
                ),
                onPressed: () {
                  setState(() {
                    _isButtonPressed = !_isButtonPressed;
                  });
                },
              )
            : null,
        hintText: widget.text,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            width: widget.borderWidth ?? 0,
            style: BorderStyle.none,
          ),
        ),
      ),
      keyboardType: (widget.isPassword ?? false)
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    );
  }
}

Container button(BuildContext context, bool isLogIn, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.height,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    child: ElevatedButton(
      onPressed: onTap(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.indigo;
          }
          return const Color.fromRGBO(21, 48, 132, 1);
        }),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      child: Text(
        isLogIn ? 'Log In' : 'Sign Up',
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 2,
          fontSize: 17,
        ),
      ),
    ),
  );
}

Row goToSignUP(BuildContext context, bool islog) {
  final txt = islog ? 'Don\'t Have Account?' : 'Already Have Account?';
  final signInUp = islog ? ' Sign Up' : ' Log In';
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        txt,
        style: const TextStyle(
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                if (islog) {
                  return const SignUp();
                } else {
                  return const SignIn();
                }
              },
            ),
          );
        },
        child: Text(
          signInUp,
          style: const TextStyle(
            color: Color.fromRGBO(21, 48, 132, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ],
  );
}

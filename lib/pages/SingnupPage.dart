import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/color_config.dart';
import '../model/user.dart';
import '../provider/base_provider.dart';
import '../widgets/TextFieldWidget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

TextEditingController _userName = TextEditingController();
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              setColor('#214ED3'),
              setColor('4169E1'),
              setColor('#6988E7'),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CallTextField(
                text: 'Enter Your Name',
                isPassword: false,
                icon: Icons.person,
                controller: _userName,
              ),
              const SizedBox(
                height: 20,
              ),
              CallTextField(
                text: 'Enter Your Name',
                isPassword: false,
                icon: Icons.mail,
                controller: _emailController,
              ),
              const SizedBox(
                height: 20,
              ),
              CallTextField(
                text: 'Enter Your Password',
                isPassword: true,
                icon: Icons.key,
                controller: _passwordController,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.height,
                height: 50,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: ElevatedButton(
                  onPressed: () async {
                    final user = UserDetail(
                      userName: _userName.text,
                      password: _passwordController.text,
                      email: _emailController.text,
                    );
                    await context.read<BaseProvider>().signUp(user);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
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
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              goToSignUP(context, false),
            ],
          ),
        ),
      ),
    );
  }
}

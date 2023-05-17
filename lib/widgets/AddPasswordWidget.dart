import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/appCredential.dart';
import '../provider/base_provider.dart';
import 'TextFieldWidget.dart';

class AddPasswordWidget extends StatelessWidget {
  const AddPasswordWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController appName = TextEditingController();
    TextEditingController userName = TextEditingController();
    TextEditingController password = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              title: Row(
                children: <Widget>[
                  Icon(
                    Icons.lock,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Add Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  )
                ],
              ),
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      CallTextField(
                        controller: appName,
                        icon: Icons.app_blocking_outlined,
                        text: 'App Name',
                        borderWidth: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CallTextField(
                        controller: userName,
                        icon: Icons.person_outline_sharp,
                        text: 'User Name',
                        borderWidth: 3,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CallTextField(
                        controller: password,
                        borderWidth: 3,
                        text: 'Password',
                        icon: Icons.key,
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    MaterialButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'cancel',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        final credential = AppCredential(
                          appName: appName.text,
                          userName: userName.text,
                          password: password.text,
                        );
                        await context
                            .read<BaseProvider>()
                            .addPassword(credential);
                      },
                      child: Text(
                        'save',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        );
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/appCredential.dart';
import '../provider/base_provider.dart';
import '../widgets/TextFieldWidget.dart';

snackBarMessage(String? message, BuildContext? context) {
  if (message == null || context == null) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

Future dialog(
  BuildContext context, {
  bool? isUpdate,
  AppCredential? credential,
}) {
  TextEditingController appName = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  return showDialog(
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
              (isUpdate ?? false) ? 'Update Password' : 'Add Password',
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
                  controller: appName..text = credential?.appName ?? '',
                  icon: Icons.app_blocking_outlined,
                  text: 'App Name',
                  borderWidth: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
                CallTextField(
                  controller: userName..text = credential?.userName ?? '',
                  icon: Icons.person_outline_sharp,
                  text: 'User Name',
                  borderWidth: 3,
                ),
                const SizedBox(
                  height: 10,
                ),
                CallTextField(
                  controller: password..text = credential?.password ?? '',
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
                  (isUpdate ?? false)
                      ? await context
                          .read<BaseProvider>()
                          .updateCredential(credential)
                      : await context
                          .read<BaseProvider>()
                          .addPassword(credential);
                },
                child: Text(
                  (isUpdate ?? false) ? 'update' : 'save',
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
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/color_config.dart';
import 'helpers/helpers.dart';
import 'helpers/local_auth.dart';
import 'provider/base_provider.dart';
import 'route_generator.dart';

GlobalKey<NavigatorState>? scaffoldKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final String? currentUser = await getCurrentUser();
  final bool? isAuthenticated;
  if (currentUser != null) {
    isAuthenticated = await LocalAuth.local.authenticate();
  }
  runApp(MyApp(currentUser: currentUser));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.currentUser});
  final String? currentUser;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaseProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: scaffoldKey,
        initialRoute: (currentUser != null) ? '/home' : '/login',
        onGenerateRoute: RouteGenerator.generateRoute,
        title: 'Password Saver',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: getMaterialColor(
              const Color.fromRGBO(21, 48, 132, 1),
            ),
            accentColor: const Color.fromRGBO(21, 48, 132, 1),
          ),
        ),
      ),
    );
  }
}

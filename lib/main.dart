import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/color_config.dart';
import 'provider/base_provider.dart';
import 'route_generator.dart';

GlobalKey<NavigatorState>? scaffoldKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaseProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: scaffoldKey,
        initialRoute: '/login',
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

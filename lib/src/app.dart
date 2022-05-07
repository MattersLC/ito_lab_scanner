import 'package:flutter/material.dart';
import 'package:ito_lab_scanner/src/screens/forgot_paswword_page.dart';
import 'package:ito_lab_scanner/src/screens/home_page.dart';
import 'package:ito_lab_scanner/src/screens/login_page.dart';
import 'package:ito_lab_scanner/src/screens/register_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ITO SCANNER',
      initialRoute: '/',
      theme: ThemeData(
          brightness: Brightness.light,
          //primaryColor: Colors.blue,
          primaryColor: const Color(0xFF01325E),
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
      /*onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case '/':
              return LoginPage();
            case '/home':
              break;
            case 'register':
              return RegisterPage();
            case '/forgotPassword':
              return ForgotPasswordPage();
          }
          throw (context) {};
        });
      },*/
      routes: {
        '/': (BuildContext context) => const LoginPage(),
        '/register': (BuildContext context) => const RegisterPage(),
        '/forgotPassword': (BuildContext context) => const ForgotPasswordPage(),
        '/homePage': (BuildContext context) => const HomePage(),
      },
    );
  }
}

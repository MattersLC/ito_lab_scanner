import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  late FocusNode userFocus;
  late FocusNode passFocus;

  final _formKey = GlobalKey<FormState>();
  late String _user;
  //String _name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 60),
            decoration: const BoxDecoration(color: Color(0xFF01325E)),
            child: Image.asset(
              'assets/images/ito_escudo.png',
              height: 200,
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -20),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 260,
                    bottom: 20,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                      vertical: 20,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.person),
                              hintText: 'Ejemplo: 21160001',
                              labelText: 'Usuario:',
                            ),
                            onSaved: (value) {
                              _user = value!;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu usuario.';
                              } else if (value.contains('@') ||
                                  value.contains('{')) {
                                return 'No uses el caracácter @.';
                              }
                              return null;
                            },
                            focusNode: userFocus,
                            onEditingComplete: () =>
                                _requestFocus(context, passFocus),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Contraseña:'),
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu contraseña.';
                              }
                              return null;
                            },
                            focusNode: passFocus,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            style: _elevatedButtonStyle(context),
                            //color: Theme.of(context).primaryColor,
                            onPressed: () => _login(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text('Iniciar sesión'),
                                if (_loading)
                                  Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text('¿No tienes cuenta?'),
                                  TextButton(
                                      onPressed: () {
                                        _showRegister(context);
                                      },
                                      child: Text(
                                        'Registrate',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      _showForgotPassPage(context);
                                    },
                                    child: Text(
                                      '¿Olvidaste tu contraseña?',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  ButtonStyle _elevatedButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  void _login(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
    }
    Navigator.of(context).pushNamed('/homePage');
  }

  void _showRegister(BuildContext context) {
    Navigator.of(context).pushNamed('/register');
  }

  void _showForgotPassPage(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/forgotPassword',
    );
  }

  _requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  void initState() {
    super.initState();
    userFocus = FocusNode();
    passFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    userFocus.dispose();
    passFocus.dispose();
  }
}

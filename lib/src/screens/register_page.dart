import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _loading = false;

  late FocusNode userFocus;
  late FocusNode emailFocus;
  late FocusNode passFocus;
  late FocusNode confirmPassFocus;

  late String passValue = '';

  final _formKey = GlobalKey<FormState>();

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
            offset: const Offset(0, 10),
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 260, bottom: 20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
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
                            onSaved: (value) {},
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
                                _requestFocus(context, emailFocus),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(Icons.alternate_email),
                              hintText: 'Ejemplo: 21160001@itoaxaca.edu.mx',
                              labelText: 'Correo electrónico institucional:',
                            ),
                            onSaved: (value) {},
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu correo';
                              } else if (!value.contains('@itoaxaca.edu.mx')) {
                                return 'Debes introducir tu correo institucional.';
                              }
                              return null;
                            },
                            focusNode: emailFocus,
                            onEditingComplete: () =>
                                _requestFocus(context, passFocus),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Contraseña:'),
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            onSaved: (value) {
                              passValue = value!;
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu contraseña.';
                              }
                              return null;
                            },
                            focusNode: passFocus,
                            onEditingComplete: () =>
                                _requestFocus(context, confirmPassFocus),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Confirma tu contraseña:'),
                            obscureText: true,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu contraseña.';
                              } else if (value != passValue) {
                                //print(passValue);
                                return 'Las contraseñas deben coincidir.';
                              } else if (value == passValue) {
                                AutovalidateMode.disabled;
                                return null;
                              }
                              return null;
                            },
                            focusNode: confirmPassFocus,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: _elevatedButtonStyle(context),
                            //color: Theme.of(context).primaryColor,
                            onPressed: () => _register(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const Text('Regístrate'),
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
                            height: 20,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text('¿Ya tienes cuenta?'),
                                  TextButton(
                                    onPressed: () {
                                      _showLogin(context);
                                    },
                                    child: Text(
                                      'Inicia sesión',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  )
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

  void _register(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
    }
  }

  void _showLogin(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/',
    );
  }

  _requestFocus(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  void initState() {
    super.initState();
    userFocus = FocusNode();
    emailFocus = FocusNode();
    passFocus = FocusNode();
    confirmPassFocus = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    userFocus.dispose();
    emailFocus.dispose();
    passFocus.dispose();
    confirmPassFocus.dispose();
  }
}

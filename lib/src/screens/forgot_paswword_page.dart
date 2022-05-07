import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;
  //String _email = '';

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
            offset: const Offset(0, -70),
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
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text('Proporciónanos tu correo para poder')
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Text('enviarte un código de verificación')
                                ],
                              ),
                            ],
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
                                const Text('Recuperar contraseña'),
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
                                  const Text('Volver a'),
                                  TextButton(
                                    onPressed: () {
                                      _showLogin(context);
                                    },
                                    child: Text(
                                      'Iniciar sesión',
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
  }

  void _showLogin(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/',
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _scanBarcode = 'Unknown';
  String _manuallyAdded = 'Unknown';
  String _selectedTag = 'Unknown';
  final List<String> _controlNumbers = [];
  bool isValidAlert = false;
  bool isValidScaffold = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      _selectedTag = 'scanner';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ITO SCANNER',
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/tecnm_logo.jpg', fit: BoxFit.cover),
          backgroundColor: const Color(0xFF01325E),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 45, bottom: 45),
                      child: Text(
                        'Escáner de credencial',
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 400,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              'Agrega los números de control',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    FloatingActionButton(
                                      heroTag: 'manually',
                                      onPressed: () => _displayDialog(context),
                                      backgroundColor: const Color(0xFF01325E),
                                      child: const Icon(Icons.back_hand),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Manualmente',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    FloatingActionButton(
                                      heroTag: 'scanner',
                                      onPressed: () => scanBarcodeNormal(),
                                      backgroundColor: const Color(0xFF01325E),
                                      child: const Icon(Icons.qr_code_scanner),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Escáner',
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                SizedBox(
                  width: 400,
                  height: 250,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                        vertical: 20,
                      ),
                      child: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              'Números de control',
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              height: 138,
                              child: Scrollbar(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  //child: _saveColumnWithCtrlNmbrs(),
                                  child: _saveColumn(_selectedTag),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      style: _elevatedButtonStyle(context),
                      onPressed: () {},
                      child: const Text('Generar pase de lista'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _displayDialog(BuildContext context) async {
    _selectedTag = 'manually';
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: const Text('Escribe el número de control'),
              content: _containerAlert(setState),
            );
          });
        });
  }

  Widget _containerAlert(StateSetter setState) {
    return Container(
      width: 120,
      height: 150,
      margin: const EdgeInsets.all(35),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              onChanged: (text) {
                setState(() {
                  if (text.length > 7) {
                    isValidAlert = true;
                    _manuallyAdded = text;
                  } else {
                    isValidAlert = false;
                  }
                });
              },
              decoration: const InputDecoration(labelText: 'Ejemplo: 21160001'),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: _elevatedButtonStyle(context),
              onPressed: _verifyColumnMA,
              child: const Text("Agregar"),
            )
          ],
        ),
      ),
    );
  }

  void _verifyColumnMA() {
    _selectedTag = 'manually';
    if (isValidAlert) {
      _saveColumnManually();
    } else {
      null;
    }
  }

  Column? _saveColumnManually() {
    if (_manuallyAdded == 'Unknown') {
      return null;
    } else {
      _controlNumbers.add(_manuallyAdded);

      return Column(
        children: <Widget>[
          for (var s in _controlNumbers)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Icon(CupertinoIcons.barcode),
                ),
                const Text(
                  '  ',
                ),
                Text(s),
              ],
            ),
        ],
      );
    }
  }

  Column? _saveColumnWithCtrlNmbrs() {
    if (_scanBarcode == 'Unknown') {
      return null;
    } else {
      if (_scanBarcode != '-1') {
        _controlNumbers.add(_scanBarcode);
      }
      return Column(
        children: <Widget>[
          for (var s in _controlNumbers)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Transform.translate(
                  offset: const Offset(0, -5),
                  child: const Icon(CupertinoIcons.barcode),
                ),
                const Text(
                  '  ',
                ),
                Text(s),
              ],
            ),
        ],
      );
    }
  }

  Column? _saveColumn(String value) {
    if (value == 'Unknown') {
      return null;
    } else if (value == 'scanner') {
      return _saveColumnWithCtrlNmbrs();
    } else if (value == 'manually') {
      return _saveColumnManually();
    } else {
      return null;
    }
  }

  ButtonStyle _elevatedButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
      primary: Theme.of(context).primaryColor,
      padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }
}

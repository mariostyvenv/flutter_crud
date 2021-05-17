import 'package:crud_rapido/src/classes/Employed.dart';
import 'package:crud_rapido/src/models/EmployedModel.dart';
import 'package:crud_rapido/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Employed employed = ModalRoute.of(context).settings.arguments;
    GlobalKey<FormState> _keyForm = GlobalKey<FormState>();

    String names, lastnames, cellphone, email, password;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
      ),
      body: SingleChildScrollView(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          margin: EdgeInsets.all(20),
          elevation: 10,
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: _keyForm,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'Empleado',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue:
                            employed?.names != null ? employed.names : '',
                        validator: (String value) {
                          if (value.length <= 5) {
                            return 'Debe ingresar almenos 5 caracteres';
                          }
                        },
                        onSaved: (value) {
                          names = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Nombres',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: employed?.lastnames != null
                            ? employed.lastnames
                            : '',
                        validator: (String value) {
                          if (value.length <= 5) {
                            return 'Debe ingresar almenos 5 caracteres';
                          }
                        },
                        onSaved: (value) {
                          lastnames = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Apellidos',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue: employed?.cellphone != null
                            ? employed.cellphone
                            : '',
                        validator: (String value) {
                          if (value.length != 10) {
                            return 'Debe tener solo 10 caracteres';
                          }
                        },
                        onSaved: (value) {
                          cellphone = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Celular',
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue:
                            employed?.email != null ? employed.email : '',
                        validator: (value) {
                          String emailRegex =
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
                          if (!RegExp(emailRegex).hasMatch(value)) {
                            return 'Correo incorrecto';
                          }
                        },
                        onSaved: (value) {
                          email = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Correo',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      TextFormField(
                        initialValue:
                            employed?.password != null ? employed.password : '',
                        obscureText: true,
                        onSaved: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Clave',
                          prefixIcon: Icon(
                            Icons.security,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    child: Text('Guardar'),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_keyForm.currentState.validate()) {
                        _keyForm.currentState.save();

                        if (employed == null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => FutureBuilder(
                              future: EmployedModel.insert(
                                Employed(
                                  names: names,
                                  lastnames: lastnames,
                                  email: email,
                                  cellphone: cellphone,
                                  password: password,
                                ),
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  Future.delayed(Duration(seconds: 3),
                                      () async {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  });

                                  return AlertDialog(
                                    content: Text('Insertado correctamente'),
                                  );
                                } else {
                                  return AlertDialog(
                                    content: Text('Cargando...'),
                                  );
                                }
                              },
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => FutureBuilder(
                              future: EmployedModel.update(
                                Employed(
                                  id: employed.id,
                                  names: names,
                                  lastnames: lastnames,
                                  email: email,
                                  cellphone: cellphone,
                                  password: password,
                                ),
                              ),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  Future.delayed(
                                    Duration(seconds: 3),
                                    () async {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  );

                                  return AlertDialog(
                                    content: Text('Actualizado correctamente'),
                                  );
                                } else {
                                  return AlertDialog(
                                    content: Text('Cargando...'),
                                  );
                                }
                              },
                            ),
                          );
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:crud_rapido/src/classes/Employed.dart';
import 'package:crud_rapido/src/models/EmployedModel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<List<Employed>> employes;

  @override
  void initState() {
    super.initState();
    employes = EmployedModel.obtener();
  }

  Future refreshList() async{
    setState(() {
      employes = EmployedModel.obtener();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: _listadoComponentes(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        onPressed: () {
          Navigator.pushNamed(context, 'detail');
        },
      ),
    );
  }

  Widget _listadoComponentes() {
    return RefreshIndicator(
      onRefresh: refreshList,
      child: FutureBuilder(
        future: employes,
        initialData: [],
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int key) {
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    EmployedModel.delete(snapshot.data.asMap()[key].id);
                  },
                  child: ListTile(
                    title: Text(
                      snapshot.data.asMap()[key].names,
                    ),
                    subtitle: Text(
                      snapshot.data.asMap()[key].email,
                    ),
                    leading: Icon(
                      Icons.person,
                      color: Colors.blue,
                      size: 40,
                    ),
                    trailing: Icon(
                      Icons.arrow_right,
                      color: Colors.blue,
                      size: 40,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, 'detail',
                          arguments: snapshot.data.asMap()[key]);
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

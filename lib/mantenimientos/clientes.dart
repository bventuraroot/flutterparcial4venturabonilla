import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutterparcial4venturabonilla/menu/drawer_menu.dart';

class Clientes extends StatefulWidget {
  const Clientes({super.key});

  @override
  State<Clientes> createState() => _ClientesState();
}

class _ClientesState extends State<Clientes> {
  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _fechanacimientoController =
      TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _sexoController = TextEditingController();
  final TextEditingController _usuarioController = TextEditingController();

  final CollectionReference _clientes =
      FirebaseFirestore.instance.collection('clientes');
  //Ingresar clientes
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _cedulaController,
                  decoration: const InputDecoration(labelText: 'Cedula'),
                ),
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(
                    labelText: 'Apellido',
                  ),
                ),
                TextField(
                    controller: _fechanacimientoController,
                    decoration:
                        const InputDecoration(labelText: 'Fecha Nacimiento'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime(
                              1990), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        print(
                            pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                        String formattedDate = DateFormat('yyyy-MM-dd').format(
                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                        print(
                            formattedDate); //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need

                        setState(() {
                          _fechanacimientoController.text =
                              formattedDate; //set foratted date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    }),
                TextField(
                  controller: _sexoController,
                  decoration: const InputDecoration(
                    labelText: 'Sexo',
                  ),
                ),
                TextField(
                  controller: _tipoController,
                  decoration: const InputDecoration(
                    labelText: 'Tipo',
                  ),
                ),
                TextField(
                  controller: _usuarioController,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Crear'),
                  onPressed: () async {
                    final int? cedula = int.tryParse(_cedulaController.text);
                    final String nombre = _nombreController.text;
                    final String apellido = _apellidoController.text;
                    final String fecha_nacimiento =
                        _fechanacimientoController.text;
                    final String sexo = _sexoController.text;
                    final String tipo = _tipoController.text;
                    final String usuario = _usuarioController.text;
                    if (cedula != null) {
                      await _clientes.add({
                        "cedula": cedula,
                        "nombre": nombre,
                        "apellido": apellido,
                        "fecha_nacimiento": fecha_nacimiento,
                        "sexo": sexo,
                        "tipo": tipo,
                        "usuario": usuario
                      });
                      _cedulaController.text = '';
                      _nombreController.text = '';
                      _apellidoController.text = '';
                      _fechanacimientoController.text = '';
                      _sexoController.text = '';
                      _tipoController.text = '';
                      _usuarioController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

//actualizar clientes

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _cedulaController.text = documentSnapshot['cedula'].toString();
      _nombreController.text = documentSnapshot['nombre'].toString();
      _apellidoController.text = documentSnapshot['apellido'].toString();
      _fechanacimientoController.text =
          documentSnapshot['fecha_nacimiento'].toString();
      _sexoController.text = documentSnapshot['sexo'].toString();
      _tipoController.text = documentSnapshot['tipo'].toString();
      _usuarioController.text = documentSnapshot['usuario'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  controller: _cedulaController,
                  decoration: const InputDecoration(labelText: 'Cedula'),
                ),
                TextField(
                  controller: _nombreController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(
                    labelText: 'Apellido',
                  ),
                ),
                TextField(
                    controller: _fechanacimientoController,
                    decoration:
                        const InputDecoration(labelText: 'Fecha Nacimiento'),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime(
                              1990), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        print(
                            pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                        String formattedDate = DateFormat('yyyy-MM-dd').format(
                            pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                        print(
                            formattedDate); //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need

                        setState(() {
                          _fechanacimientoController.text =
                              formattedDate; //set foratted date to TextField value.
                        });
                      } else {
                        print("Date is not selected");
                      }
                    }),
                TextField(
                  controller: _sexoController,
                  decoration: const InputDecoration(
                    labelText: 'Sexo',
                  ),
                ),
                TextField(
                  controller: _tipoController,
                  decoration: const InputDecoration(
                    labelText: 'Tipo',
                  ),
                ),
                TextField(
                  controller: _usuarioController,
                  decoration: const InputDecoration(
                    labelText: 'Usuario',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Actualizar'),
                  onPressed: () async {
                    final double? cedula =
                        double.tryParse(_cedulaController.text);
                    final String nombre = _nombreController.text;
                    final String apellido = _apellidoController.text;
                    final String fecha_nacimiento =
                        _fechanacimientoController.text;
                    final String sexo = _sexoController.text;
                    final String tipo = _tipoController.text;
                    final String usuario = _usuarioController.text;
                    if (cedula != null) {
                      await _clientes.doc(documentSnapshot!.id).update({
                        "cedula": cedula,
                        "nombre": nombre,
                        "apellido": apellido,
                        "fecha_nacimiento": fecha_nacimiento,
                        "sexo": sexo,
                        "tipo": tipo,
                        "usuario": usuario
                      });
                      _cedulaController.text = '';
                      _nombreController.text = '';
                      _apellidoController.text = '';
                      _fechanacimientoController.text = '';
                      _sexoController.text = '';
                      _tipoController.text = '';
                      _usuarioController.text = '';
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'El Cliente fue actualizado correctamente')));
                    }
                  },
                )
              ],
            ),
          );
        });
  }

//borrar clientes
  Future<void> _delete(String clientesId) async {
    await _clientes.doc(clientesId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('El Cliente fue eliminado correctamente')));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: const Center(
            child: Text("Parcial N4 Ventura y Bonilla"),
          ),
        ),
        body: StreamBuilder(
          stream: _clientes.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['cedula'].toString()),
                      subtitle: Text(documentSnapshot['nombre'].toString() +
                          ' ' +
                          documentSnapshot['apellido'].toString()),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _update(documentSnapshot)),
                            IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _delete(documentSnapshot.id)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        // agregar clientes
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}

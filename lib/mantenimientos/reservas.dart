import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Reservas extends StatefulWidget {
  const Reservas({super.key});

  @override
  State<Reservas> createState() => _ReservasState();
}

class _ReservasState extends State<Reservas> {
  final TextEditingController _idReservaController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();

  final CollectionReference _reservas =
      FirebaseFirestore.instance.collection('reservas');
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
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _idReservaController,
                  decoration: const InputDecoration(labelText: 'Id Reserva'),
                ),
                TextField(
                  controller: _estadoController,
                  decoration: const InputDecoration(
                    labelText: 'Estado',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Crear'),
                  onPressed: () async {
                    final String idReserva = _idReservaController.text;
                    final String estado = _estadoController.text;
                    if (idReserva != null) {
                      await _reservas.add({
                        "idReserva": idReserva,
                        "estado": estado,
                      });
                      _idReservaController.text = '';
                      _estadoController.text = '';
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
      _idReservaController.text = documentSnapshot['idReserva'].toString();
      _estadoController.text = documentSnapshot['estado'].toString();
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
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _idReservaController,
                  decoration: const InputDecoration(labelText: 'Cedula'),
                ),
                TextField(
                  controller: _estadoController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Actualizar'),
                  onPressed: () async {
                    final String idReserva = _idReservaController.text;
                    final String estado = _estadoController.text;
                    if (idReserva != null) {
                      await _reservas.doc(documentSnapshot!.id).update({
                        "idReserva": idReserva,
                        "estado": estado,
                      });
                      _idReservaController.text = '';
                      _estadoController.text = '';
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text('La Reserva fue eliminada correctamente')));
                    }
                  },
                )
              ],
            ),
          );
        });
  }

//borrar clientes
  Future<void> _delete(String reservasId) async {
    await _reservas.doc(reservasId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('La Reserva fue eliminada correctamente')));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("Parcial N4 Ventura y Bonilla"),
          ),
        ),
        body: StreamBuilder(
          stream: _reservas.snapshots(),
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
                      title: Text(documentSnapshot['idReserva'].toString()),
                      subtitle: Text(documentSnapshot['estado'].toString()),
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

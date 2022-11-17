import 'package:flutter/material.dart';
import 'package:flutterparcial4venturabonilla/mantenimientos/clientes.dart';
import 'package:flutterparcial4venturabonilla/mantenimientos/reservas.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Parcial N4',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Clientes'),
            onTap: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Clientes()))
            },
          ),
          ListTile(
            leading: Icon(Icons.data_exploration),
            title: Text('Reservas'),
            onTap: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Reservas()))
            },
          )
        ],
      ),
    );
  }
}

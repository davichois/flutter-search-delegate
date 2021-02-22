import 'package:flutter/material.dart';
import 'package:search_country/models/country_model.dart';

import 'package:search_country/utils/search_country.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Country paisSeleccionado;
  List<Country> historial = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (paisSeleccionado != null) Text(paisSeleccionado.name),
            MaterialButton(
              child: Text(
                'Buscar',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.blue,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () async {
                final pais = await showSearch(
                  context: context,
                  delegate: CountrySearchDelegate('Buscar pais', historial),
                );
                setState(() {
                  paisSeleccionado = pais;
                  historial.insert(0, pais);
                });
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_country/models/country_model.dart';

import 'package:search_country/services/country_service.dart';

class CountrySearchDelegate extends SearchDelegate<Country> {
  @override
  final String searchFieldLabel;
  final List<Country> historial;

  CountrySearchDelegate(this.searchFieldLabel, this.historial);

  //La accion que quieres hacer
  // query es la caja
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () => this.query = "",
      )
    ];
  }

  //El boton de retroseso
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
      ),
      onPressed: () => this.close(context, null),
    );
  }

  //Resultados de la busqueda
  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().length == 0) {
      return Text('');
    }

    final countryService = new CountryServices();

    return FutureBuilder(
      future: countryService.getCountryByName(name: query),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return _showCountries(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 4,
            ),
          );
        }
      },
    );
  }

  //Mostrar algun historial
  @override
  Widget buildSuggestions(BuildContext context) {
    return _showCountries(this.historial);
  }

  Widget _showCountries(List countries) {
    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, i) {
        final pais = countries[i];
        return ListTile(
          leading: (pais.flag != null)
              ? SvgPicture.network(
                  pais.flag,
                  width: 40,
                )
              : '',
          title: Text(pais.name),
          subtitle: Text(pais.capital),
          trailing: Text(pais.alpha3Code),
          onTap: () {
            this.close(context, pais);
          },
        );
      },
    );
  }
}

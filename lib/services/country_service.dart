import 'package:dio/dio.dart';
import 'package:search_country/models/country_model.dart';

class CountryServices {
  final _dio = new Dio();

  Future getCountryByName({String name}) async {
    try {
      final url = 'https://restcountries.eu/rest/v2/name/$name';
      final resp = await _dio.get(url);

      final countries = new Countries.fromJsonList(resp.data);
      return countries.items;
    } catch (e) {
      return [];
    }
  }
}

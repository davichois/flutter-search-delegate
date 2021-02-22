class Countries {
  List<Country> items = new List();

  Countries();

  Countries.fromJsonList(List jsonList) {
    if (jsonList == null) {
      return;
    }
    for (var item in jsonList) {
      final pelicula = new Country.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Country {
  String name;
  String alpha3Code;
  String capital;
  String flag;

  Country({this.name, this.alpha3Code, this.capital, this.flag});

  Country.fromJsonMap(Map<String, dynamic> json) {
    name = json['name'];
    alpha3Code = json['alpha3Code'];
    capital = json['capital'];
    flag = json['flag'];
  }

  @override
  String toString() {
    return 'Instance of country: $name';
  }
}

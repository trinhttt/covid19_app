class Country {
  String country;

  Country({required this.country});

  static List<Country> countries(List snapshot) {
    return snapshot.map((data) {
      return Country(country: data['Country'] as String);
    }).toList();
  }
}

class DetailCountry extends Country {
  final int deaths;
  final int recovered;
  final int active;
  final int confirmed;

  DetailCountry({required this.deaths,
    required this.recovered,
    required this.active,
    required this.confirmed,
    required String country})
      : super(country: country);

  factory DetailCountry.fromJson(dynamic json) {
    return DetailCountry(
        country: json['Country'] as String,
        active: json['Active'] as int,
        recovered: json['Recovered'] as int,
        confirmed: json['Confirmed'] as int,
        deaths: json['Deaths'] as int);
  }

  // static List<CountryInfo> countryInfoListFromSnapshot(List snapshot) {
  //   return snapshot.map((e) {
  //     return CountryInfo.fromJson(snapshot);
  //   }).toList();
  // }
}

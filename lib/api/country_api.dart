import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/country_info.dart';
import 'package:intl/intl.dart';

class CountryApi {
  static Future<List<Country>> getCountryList() async {
    var url = Uri.https('api.covid19api.com', '/countries');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return Country.countries(data);
    }
    return [];
  }

  static Future<DetailCountry?> getYesterdayCountryInfo(
      String countryName) async {
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));
    String formattedYesterday = DateFormat('yyyy-MM-dd').format(yesterday);
    var url = Uri.https('api.covid19api.com',
        'https://api.covid19api.com/live/country/${countryName}/status/confirmed/date/${formattedYesterday}');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return DetailCountry.fromJson(data);
    }
    return null;
  }
}

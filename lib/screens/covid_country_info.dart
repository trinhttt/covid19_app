import 'package:covid19_app/api/country_api.dart';
import 'package:covid19_app/models/country_info.dart';
import 'package:flutter/material.dart';

class CountryInfo extends StatefulWidget {
  @override
  _CountryInfoState createState() => _CountryInfoState();
}

class _CountryInfoState extends State<CountryInfo> {
  String? _chosenValue;
  List<String> _countries = [];
  var _isLoadingDropdown = true;
  var _isLoadingFigure = false;
  DetailCountry? _countryInfo;

  @override
  void initState() {
    super.initState();
    getCountries().then((_) => getCountryInfoList());
  }

  Future<void> getCountries() async {
    final countryList = await CountryApi.getCountryList();
    _countries = countryList.map((country) => country.country).toList();
    print(_countries);
    setState(() {
      _chosenValue = _countries.first;
      _isLoadingDropdown = !_isLoadingDropdown;
    });
  }

  Future<void> getCountryInfoList() async {
    if (_chosenValue == null) return;
    _countryInfo = await CountryApi.getYesterdayCountryInfo(_chosenValue!);
    setState(() {
      _isLoadingFigure = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Image.asset('assets/banner1.jpg'),
          _buildDropdowView(),
          _buildTitleView('Case Update', 'Newest update'),
          _buildCovidFiguresView(),
          _buildTitleView('Spread of Virus', 'Newest update')
        ],
      )),
    );
  }

  Widget _buildDropdowView() {
    return Stack(children: [
      Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey)),
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(15),

            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                  menuMaxHeight: 400,
                  value: _chosenValue,
                  underline: SizedBox(),
                  focusColor: Colors.red,
                  style: TextStyle(color: Colors.black),
                  isExpanded: true,
                  items: _countries.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Please choose a country",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  onChanged: (value) async {
                    setState(() {
                      _chosenValue = value ?? "Viet Nam";
                      getCountryInfoList();
                      _isLoadingFigure = true;
                    });
                  }),
            ),
          ),
        ]
      ),
      if (_isLoadingDropdown)
        Positioned.fill(
            child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        ))
    ]);
  }

  Widget _buildTitleView(String title, String? subTitle) {
    return Padding(
        padding: EdgeInsets.only(left: 15, top: 5, right: 5),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                if (subTitle != null)
                  Text(subTitle,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 12))
              ],
            ),
            Spacer(),
            TextButton(
                onPressed: () {
                  print('View all tapped');
                },
                child: Text('See details', style: TextStyle(fontSize: 12)))
          ],
        ));
  }

  Widget _buildCovidFiguresView() {
    return Container(
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Stack(children: [
          Row(
            children: [
              Expanded(
                child: _buildFigureColumn('assets/Infected.png',
                    _countryInfo?.confirmed ?? 0, 'Infected', Colors.orange),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: _buildFigureColumn('assets/Deaths.png',
                      _countryInfo?.deaths ?? 0, 'Deaths', Colors.red)),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: _buildFigureColumn('assets/Recovered.png',
                    _countryInfo?.recovered ?? 0, 'Recovered', Colors.green),
              ),
            ],
          ),
          if (_isLoadingFigure)
            Positioned.fill(
                child: Align(
                    alignment: Alignment.center,//default
                    child: CircularProgressIndicator())),
        ]));
  }

  Widget _buildFigureColumn(
      String imageName, int number, String text, Color color) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageName,
            width: 23,
            height: 23,
          ),
          SizedBox(height: 10),
          FittedBox(
              fit: BoxFit.contain,
              child: Text(number.toString(),
                  style: TextStyle(color: color, fontSize: 20))),
          SizedBox(height: 10),
          Text(text, style: TextStyle(color: Colors.grey, fontSize: 13)),
        ],
      ),
    );
  }
}

class AutoSizeText {}

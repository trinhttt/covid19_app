import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryInfo extends StatefulWidget {
  @override
  _CountryInfoState createState() => _CountryInfoState();
}

class _CountryInfoState extends State<CountryInfo> {
  String? _chosenValue;

  @override
  void initState() {
    super.initState();
  }

  // getData() async {
  //   String myUrl = "https://api.covid19api.com/countries";
  //   var req = await http.get(myUrl);
  //   var infos = json.decode(req.body);
  //   print(infos);
  // }

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
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey)),
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
            value: _chosenValue,
            underline: SizedBox(),
            //elevation: 5,
            style: TextStyle(color: Colors.black),
            items: <String>['Viet nam', 'Japan']
                .map<DropdownMenuItem<String>>((String value) {
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
            onChanged: (value) {
              setState(() {
                _chosenValue = value;
              });
            }),
      ),
    );
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
        child: Row(
          children: [
            _buildFigureColumn(
                'assets/Infected.png', 1000, 'Infected', Colors.orange),
            Spacer(),
            _buildFigureColumn('assets/Deaths.png', 1000, 'Deaths', Colors.red),
            Spacer(),
            _buildFigureColumn(
                'assets/Recovered.png', 1000, 'Recovered', Colors.green),
          ],
        ));
  }

  Widget _buildFigureColumn(
      String imageName, int number, String text, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imageName,
          width: 23,
          height: 23,
        ),
        SizedBox(height: 10),
        Text(number.toString(), style: TextStyle(color: color, fontSize: 40)),
        SizedBox(height: 10),
        Text(text, style: TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }
}

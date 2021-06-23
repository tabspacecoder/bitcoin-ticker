import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';


  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownitems = [];
    for (String curr in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(curr),
        value: (curr),
      );
      dropdownitems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownitems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> dropdownitems = [];
    for (String curr in currenciesList) {
      var newItem = Text(curr);
      dropdownitems.add(newItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
        print(selectedIndex);
      },
      children: dropdownitems,
    );
  }
  bool wait = false;
  Map<String, String> coinValues={};


  void getData() async {
    wait = true;
    try {
      var data = await CoinData().GetCoinValue(selectedCurrency);
      wait = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  newCard(
                    selectedCurrency: selectedCurrency,
                    selectedCrypto: 'BTC',
                    value: wait ? '?' : coinValues['BTC'],
                  ),
                  newCard(
                    selectedCurrency: selectedCurrency,
                    selectedCrypto: 'ETH',
                    value: wait ? '?' : coinValues['ETH'],
                  ),
                  newCard(
                    selectedCurrency: selectedCurrency,
                    selectedCrypto: 'LTC',
                    value: wait ? '?' : coinValues['LTC'],
                  ),
                ],
              )),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}

class newCard extends StatelessWidget {
  const newCard({
    Key key,
    @required this.selectedCurrency,
    @required this.selectedCrypto,
    @required this.value,
  }) : super(key: key);

  final String selectedCurrency;
  final String selectedCrypto;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $selectedCrypto = $value $selectedCurrency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

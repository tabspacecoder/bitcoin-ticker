import 'package:http/http.dart' as http;
import 'dart:convert';
const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
// String apikey = "0863C487-C724-4BA0-B953-1DD64849F5E8";
// String apikey ="939EAD76-158E-40B4-9A5F-3D9D24C42539";
String apikey="94AC419D-8C22-4F24-B740-AAD1D2A5357F";
String apiUrl="https://rest.coinapi.io/v1/exchangerate/";
class CoinData {

  Future GetCoinValue(String Money) async {
    String toProcess(String c){
      return "$apiUrl$c/$Money?apikey=$apikey";
    }
    String link="";
    var url;
    var decodedData;
    Map<String,String> pricelist={};
       link =toProcess(cryptoList[0]);
       url = Uri.parse(link);
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        decodedData=jsonDecode(response.body);
        double am;
        am=decodedData['rate'];
        pricelist[cryptoList[0]]=am.toStringAsFixed(0);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    link =toProcess(cryptoList[1]);
    url = Uri.parse(link);
    http.Response response1 = await http.get(url);
    if (response1.statusCode == 200) {
      decodedData=jsonDecode(response1.body);
      double am;
      am=decodedData['rate'];
      pricelist[cryptoList[1]]=am.toStringAsFixed(0);
    } else {
      print(response1.statusCode);
      throw 'Problem with the get request';
    }
    link =toProcess(cryptoList[2]);
    url = Uri.parse(link);
    http.Response response2 = await http.get(url);
    if (response2.statusCode == 200) {
      decodedData=jsonDecode(response2.body);
      double am;
      am=decodedData['rate'];
      pricelist[cryptoList[2]]=am.toStringAsFixed(0);
    } else {
      print(response2.statusCode);
      throw 'Problem with the get request';
    }
      print(pricelist);
      return pricelist;

  }
  // Future GetCoinValue(String Money) async {
  //   String toProcess(String c){
  //     return "$apiUrl$c/$Money?apikey=$apikey";
  //   }
  //   Map<String,String> pricelist={};
  //   for(int i=0;i<cryptoList.length;i++){
  //     String link =toProcess(cryptoList[i]);
  //     var url = Uri.parse(link);
  //     http.Response response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       var decodedData=jsonDecode(response.body);
  //       double am;
  //       am=decodedData['rate'];
  //       pricelist[cryptoList[i]]=am.toStringAsFixed(0);
  //     } else {
  //       print(response.statusCode);
  //       throw 'Problem with the get request';
  //     }
  //     print(pricelist);
  //     return pricelist;
  //   }
  // }
}

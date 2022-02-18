
import 'dart:convert';

import 'package:netzary/model/milkiyat_Model.dart';
import 'package:http/http.dart' as http;

class NetworkProvider{
  Future<MilkiyatModel> fetchList() async{
    final response = await http.get(Uri.parse("https://milkiyat.bangalore2.com/api/home/"),);

    if(response.statusCode == 200){
      return MilkiyatModel.fromJson(jsonDecode(response.body));
    }
    else
    {
      print(response.statusCode);
      return MilkiyatModel.fromJson({});
    }
  }
}

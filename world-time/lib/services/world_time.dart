import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String time;
  String url;
  String flag;
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offsetH = data['utc_offset'].substring(2, 3);
      String offsetM = data['utc_offset'].substring(4, 6);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetH)));
      now = now.add(Duration(minutes: int.parse(offsetM)));

      isDaytime = now.hour >= 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e){
      print('error  - $e');
      time = 'Could not fetch data';
    }
  }

}


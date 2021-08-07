import 'dart:convert';

import 'package:http/http.dart' as http;

class BotService {
  Future<String> getResponse(String msg) async {
    BotMsg msgClass = BotMsg(msg: msg);
    final response = await http.post(
      Uri.parse("http://159.89.1.175/api/talk"),
      body: jsonEncode(msgClass),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    Map<String, dynamic> parsedJson = jsonDecode(response.body);

    BotMsg result = BotMsg.fromJson(parsedJson);

    return result.msg;
  }
}

class BotMsg {
  String msg;
  BotMsg({this.msg = ''});

  Map<String, dynamic> toJson() {
    return {"user_input": this.msg};
  }

  factory BotMsg.fromJson(Map<String, dynamic> json) {
    return BotMsg(
      msg: json["msg"],
    );
  }
}

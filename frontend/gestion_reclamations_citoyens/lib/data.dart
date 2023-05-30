// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
    Data({
        required this.username,
        required this.password,
        required this.dbname,
    });

    String username;
    String password;
    String dbname;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        username: json["username"],
        password: json["password"],
        dbname: json["dbname"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "dbname": dbname,
    };
}
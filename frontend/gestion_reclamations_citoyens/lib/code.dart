// To parse this JSON data, do
//
//     final data = dataFromJson(jsonString);

import 'dart:convert';

Code codeFromJson(String str) => Code.fromJson(json.decode(str));

String codeToJson(Code code) => json.encode(code.toJson());

class Code {
   Code({
        required this.code,
        
    });

    String code;
    

    factory Code.fromJson(Map<String, dynamic> json) =>Code(
        code: json["code"],
       
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        
    };
}
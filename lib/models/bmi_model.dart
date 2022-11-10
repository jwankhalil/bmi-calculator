import 'dart:convert';



class BmiModel {
  int age;
  String gender;
  String dateTime;
  String bmi;
  String resultText;
  BmiModel({
    required this.gender,
    required this.dateTime,
    this.age = 25,
    required this.bmi,
    required this.resultText,
  });

  factory BmiModel.fromJson(dynamic json) {
    return BmiModel(
      gender: json["gender"] ?? "",
      dateTime: json["dateTime"] ?? "",
      age: json["age"] ?? "",
      bmi: json["bmi"] ?? "",
      resultText: json["resultText"] ?? "",
    );
  }
  // static List<BmiModel> bmidata(List bmiList){

  //   return bmiList.map((e) {
  //     return BmiModel.fromJson(e);
  //   }).toList();
  // }

  static Map<String, dynamic> toMap(BmiModel data) => {
        'gender': data.gender,
        'dateTime': data.dateTime,
        'age': data.age,
        'bmi': data.bmi,
        'resultText': data.resultText,
      };


  static String encode(List<BmiModel> bmiMedels) => json.encode(
        bmiMedels.map<Map<String, dynamic>>((e) => BmiModel.toMap(e)).toList(),
      );

  static List<BmiModel> decode(String m) =>
      (json.decode(m) as List<dynamic>)
          .map<BmiModel>((item) => BmiModel.fromJson(item))
          .toList();
}

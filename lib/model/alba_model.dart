class AlbaModel {
  int? id;
  String albaPlace;
  String albaDays;
  DateTime startDate;
  DateTime startTime;
  DateTime endTime;
  String albaPay;
  String breakTime;
  int holidayPay;

  AlbaModel(
      {this.id,
      required this.albaPlace,
      required this.albaDays,
      required this.startDate,
      required this.startTime,
      required this.endTime,
      required this.albaPay,
      required this.breakTime,
      required this.holidayPay});

  Map<String, dynamic> toMap() {
    return {
      AlbaDbInfo.id: id,
      AlbaDbInfo.albaPlace: albaPlace,
      AlbaDbInfo.albaDays: albaDays,
      AlbaDbInfo.startDate: startDate.toIso8601String(),
      AlbaDbInfo.startTime: startTime.toIso8601String(),
      AlbaDbInfo.endTime: endTime.toIso8601String(),
      AlbaDbInfo.albaPay: albaPay,
      AlbaDbInfo.breakTime: breakTime,
      AlbaDbInfo.holidayPay: holidayPay,
    };
  }

  factory AlbaModel.fromJson(Map<String, dynamic> json) {
    return AlbaModel(
      id: json[AlbaDbInfo.id] as int,
      albaPlace: json[AlbaDbInfo.albaPlace] as String,
      albaDays: json[AlbaDbInfo.albaDays] as String,
      startDate: DateTime.parse(json[AlbaDbInfo.startDate] as String),
      startTime: DateTime.parse(json[AlbaDbInfo.startTime] as String),
      endTime: DateTime.parse(json[AlbaDbInfo.endTime] as String),
      albaPay: json[AlbaDbInfo.albaPay] as String,
      breakTime: json[AlbaDbInfo.breakTime] as String,
      holidayPay: json[AlbaDbInfo.holidayPay] as int,
    );
  }

  AlbaModel clone({
    int? id,
    String? albaPlace,
    String? albaDays,
    DateTime? startDate,
    DateTime? startTime,
    DateTime? endTime,
    String? albaPay,
    String? breakTime,
    int? holidayPay,
  }) {
    return AlbaModel(
      id: id ?? this.id,
      albaPlace: albaPlace ?? this.albaPlace,
      albaDays: albaDays ?? this.albaDays,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      albaPay: albaPay ?? this.albaPay,
      breakTime: breakTime ?? this.breakTime,
      holidayPay: holidayPay ?? this.holidayPay,
    );
  }

  // albaDays를 String으로 변환
  set albaDayList(List<String> days) {
    albaDays = days.join(',');
  }

  // albaDays를 String에서 List<DateTime>으로 변환
  List<String> get albaDayList => albaDays.split(',');
}

class AlbaDbInfo {
  static String table = 'almoney';
  static String id = 'id';
  static String albaPlace = 'albaPlace';
  static String albaDays = 'albaDays';
  static String startDate = 'startDate';
  static String startTime = 'startTime';
  static String endTime = 'endTime';
  static String albaPay = 'albaPay';
  static String breakTime = 'breakTime';
  static String holidayPay = 'holidayPay';
}

class AlbaModel {
  int? id;
  String albaPlace;
  String albaDays;
  DateTime startDate;
  DateTime startTime;
  DateTime endTime;
  int hourlyRate;

  AlbaModel({
    this.id,
    required this.albaPlace,
    required this.albaDays,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    required this.hourlyRate,
  });

  Map<String, dynamic> toMap() {
    return {
      AlbaDbInfo.id: id,
      AlbaDbInfo.albaPlace: albaPlace,
      AlbaDbInfo.albaDays: albaDays,
      AlbaDbInfo.startDate: startDate.toIso8601String(),
      AlbaDbInfo.startTime: startTime.toIso8601String(),
      AlbaDbInfo.endTime: endTime.toIso8601String(),
      AlbaDbInfo.hourlyRate: hourlyRate,
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
        hourlyRate: json[AlbaDbInfo.hourlyRate] as int);
  }

  AlbaModel clone(
      {int? id,
      String? albaPlace,
      String? albaDays,
      DateTime? startDate,
      DateTime? startTime,
      DateTime? endTime,
      int? hourlyRate}) {
    return AlbaModel(
      id: id ?? this.id,
      albaPlace: albaPlace ?? this.albaPlace,
      albaDays: albaDays ?? this.albaDays,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      hourlyRate: hourlyRate ?? this.hourlyRate,
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
  static String hourlyRate = 'hourlyRate';
}

class AttendModel {
  int? id;
  int attendId;
  DateTime attendDate;

  AttendModel({
    this.id,
    required this.attendId,
    required this.attendDate,
  });

  Map<String, dynamic> toMap() {
    return {
      AttendDbInfo.id: id,
      AttendDbInfo.attendId: attendId,
      AttendDbInfo.attendDate: attendDate.toIso8601String(),
    };
  }

  factory AttendModel.fromJson(Map<String, dynamic> json) {
    return AttendModel(
      id: json[AttendDbInfo.id] as int,
      attendId: json[AttendDbInfo.attendId] as int,
      attendDate: DateTime.parse(json[AttendDbInfo.attendDate] as String),
    );
  }

  AttendModel clone({
    int? id,
    int? attendanceId,
    DateTime? attendDate,
  }) {
    return AttendModel(
      id: id ?? this.id,
      attendId: attendId ?? attendId,
      attendDate: attendDate ?? this.attendDate,
    );
  }

  // // albaDays를 String으로 변환
  // set albaDayList(List<String> days) {
  //   albaDays = days.join(',');
  // }

  // // albaDays를 String에서 List<DateTime>으로 변환
  // List<String> get albaDayList => albaDays.split(',');
}

class AttendDbInfo {
  static String table = 'attend';
  static String id = 'id';
  static String attendId = 'attendId';
  static String attendDate = 'attendDate';
}

class TimeWork {
  int id;
  int idHospital;
  Map<String, DayTime> times;
  int enable;
  String note;

  TimeWork({
    required this.id,
    required this.idHospital,
    required this.times,
    required this.enable,
    required this.note,
  });

  factory TimeWork.fromJson(Map<String, dynamic> json) {
    return TimeWork(
      id: json['id'],
      idHospital: json['id_hospital'],
      times: Map<String, DayTime>.from(json['times'].map((k, v) => MapEntry(k, DayTime.fromJson(v)))),
      enable: json['enable'],
      note: json['note'] ?? '',
    );
  }
}

class DayTime {
  final TimeRange night;
  final bool enable;
  final TimeRange? morning;
  final TimeRange afternoon;

  DayTime({
    required this.night,
    required this.enable,
    required this.morning,
    required this.afternoon,
  });

  factory DayTime.fromJson(Map<String, dynamic> json) {
    return DayTime(
      night: TimeRange.fromJson(json['night']),
      enable: json['enable'],
      morning: TimeRange.fromJson(json['morning']),
      afternoon: TimeRange.fromJson(json['afternoon']),
    );
  }
}

class TimeRange {
  final List<String> time;
  final bool enable;

  TimeRange({
    required this.time,
    required this.enable,
  });

  factory TimeRange.fromJson(Map<String, dynamic> json) {
    return TimeRange(
      time: List<String>.from(json['time']) ?? [],
      enable: json['enable'],
    );
  }
}
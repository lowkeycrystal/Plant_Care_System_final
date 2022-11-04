class Temp {
  final String time;
  final int temp;
  Temp(
    this.time,
    this.temp,
  );

  Temp.fromMap(Map<String, dynamic> map)
      : assert(map['time'] != null),
        assert(map['temp'] != null),
        time = map['time'],
        temp = map['temp'];

  @override
  String toString() => "Record<$time:$temp:>";
}

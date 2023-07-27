class RealtimeModel {
  final String temperature;
  final String humidity;
  final String fire;
  final String smoke;
  final String motor;
  final String led;
  final String dateTime;

  RealtimeModel(
      {required this.dateTime,
      required this.temperature,
      required this.humidity,
      required this.fire,
      required this.smoke,
      required this.motor,
      required this.led});

  factory RealtimeModel.fromJson(Map<String, dynamic> json) {
    final temperature = json['temperature'] ?? '0';
    final humidity = json['humidity'] ?? '0';
    final fire = json['fire'] ?? '0';
    final smoke = json['smoke'] ?? '0';
    final motor = json['motor'] ?? '0';
    final led = json['led'] ?? '0';
    final dateTime = json['dateTime'] ?? DateTime.now.toString();

    return RealtimeModel(
        dateTime: dateTime,
        temperature: temperature,
        humidity: humidity,
        fire: fire,
        smoke: smoke,
        motor: motor,
        led: led);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temperature'] = temperature;
    data['humidity'] = humidity;
    data['fire'] = fire;
    data['smoke'] = smoke;
    data['motor'] = motor;
    data['led'] = led;
    data['dateTime'] = dateTime;
    return data;
  }
}

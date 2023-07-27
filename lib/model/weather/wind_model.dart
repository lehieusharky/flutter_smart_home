class WindModel {
final double speed;
final int deg;

  WindModel({required this.speed, required this.deg});

  factory WindModel.fromJson(Map<String, dynamic> json) {
    final speed = json['speed'] ?? 0;
    final deg = json['deg'] ?? 0;
    return WindModel(speed: speed, deg: deg);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    return data;
  }
}
class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  factory Weather.fromJson(Map<String, dynamic> json) {
    final id = json['id'] ?? '';
    final main = json['main']?? '';
    final description = json['description']?? '';
    final icon = json['icon']?? '';

    return Weather(id: id, main: main, description: description, icon: icon);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

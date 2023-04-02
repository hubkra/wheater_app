class TemperatureInfo {
  final double temperature;

  TemperatureInfo({required this.temperature});

  factory TemperatureInfo.fromJSON(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return TemperatureInfo(temperature: temperature);
  }
}

class WeahterInfo {
  final String description;
  final String icon;
  final String main;

  WeahterInfo(
      {required this.description, required this.icon, required this.main});

  factory WeahterInfo.fromJSON(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    final main = json['main'];
    return WeahterInfo(description: description, icon: icon, main: main);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeahterInfo weahterInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weahterInfo.icon}@2x.png';
  }

  WeatherResponse(
      {required this.cityName,
      required this.tempInfo,
      required this.weahterInfo});

  factory WeatherResponse.fromJSON(Map<String, dynamic> json) {
    final cityName = json['name'] ?? '';
    final tempInfoJson = json['main'] ?? {};
    final tempInfo = TemperatureInfo.fromJSON(tempInfoJson);

    final weatherInfoJson =
        json['weather'] != null && json['weather'].isNotEmpty
            ? json['weather'][0]
            : {};
    final weatherInfo = WeahterInfo.fromJSON(weatherInfoJson);
    return WeatherResponse(
        cityName: cityName, tempInfo: tempInfo, weahterInfo: weatherInfo);
  }
}

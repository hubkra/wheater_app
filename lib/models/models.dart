class TemperatureInfo {
  final double temperature;
  final int pressure;
  final double feelsLike;

  TemperatureInfo(
      {required this.temperature,
      required this.pressure,
      required this.feelsLike});

  factory TemperatureInfo.fromJSON(Map<String, dynamic> json) {
    final temperature = json['temp'];
    final pressure = json['pressure'];
    final feelsLike = json['feels_like'];
    return TemperatureInfo(
        temperature: temperature, pressure: pressure, feelsLike: feelsLike);
  }
}

class WindInfo {
  final double windSpeed;

  WindInfo({required this.windSpeed});

  factory WindInfo.fromJSON(Map<String, dynamic> json) {
    final windSpeed = json['speed'];
    return WindInfo(windSpeed: windSpeed);
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
  final WindInfo windInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weahterInfo.icon}@2x.png';
  }

  WeatherResponse(
      {required this.cityName,
      required this.tempInfo,
      required this.weahterInfo,
      required this.windInfo});

  factory WeatherResponse.fromJSON(Map<String, dynamic> json) {
    final cityName = json['name'] ?? '';
    final tempInfoJson = json['main'] ?? {};
    final tempInfo = TemperatureInfo.fromJSON(tempInfoJson);
    final windInfoJson = json['wind'] ?? {};
    final windInfo = WindInfo.fromJSON(windInfoJson);

    final weatherInfoJson =
        json['weather'] != null && json['weather'].isNotEmpty
            ? json['weather'][0]
            : {};
    final weatherInfo = WeahterInfo.fromJSON(weatherInfoJson);
    return WeatherResponse(
        cityName: cityName,
        tempInfo: tempInfo,
        weahterInfo: weatherInfo,
        windInfo: windInfo);
  }
}

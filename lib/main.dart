import 'package:flutter/material.dart';
import 'package:wheater_app/models/models.dart';
import 'package:wheater_app/widgets/slider_dot.dart';
import './services/data_service.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wheater_app/widgets/single_weather.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedCityIndex = 0;
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  int _currentPage = 0;
  String bgImg = 'assets/night.jpg';

  List<WeatherResponse> _weatherResponses = [];

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _downloadWeather();
  }

  @override
  Widget build(BuildContext context) {
    if (_weatherResponses[_currentPage].weahterInfo.main == 'Clear') {
      bgImg = 'assets/sunny.jpg';
    } else if (_weatherResponses[_currentPage].weahterInfo.main == 'Rain') {
      bgImg = 'assets/rainy.jpg';
    } else if (_weatherResponses[_currentPage].weahterInfo.main == 'Clouds') {
      bgImg = 'assets/cloudy.jpeg';
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () => print("Menu clicked"),
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              bgImg,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.black38),
            ),
            Container(
                margin: EdgeInsets.only(top: 120, left: 15),
                child: Row(
                  children: [
                    for (int i = 0; i < _weatherResponses.length; i++)
                      if (i == _currentPage)
                        SliderDot(true)
                      else
                        SliderDot(false)
                  ],
                )),
            PageView.builder(
              scrollDirection: Axis.horizontal,
              onPageChanged: _onPageChanged,
              itemCount: _weatherResponses.length,
              itemBuilder: (ctx, i) => SingleWeather(
                weatherResponse: _weatherResponses[i],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadWeather() async {
    List<String> cities = ['Cracow', 'Warsaw', 'Moscow', 'New York'];
    for (String city in cities) {
      final response = await _dataService.getWeather(city);
      setState(() {
        _weatherResponses.add(response);
      });
    }
  }
}

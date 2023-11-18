import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_v2/bloc/weather_bloc_bloc.dart';
import 'package:flutter_weather_v2/reuseable_card.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Image getWeatherIcon(int code) {
    switch (code) {
      case > 200 && <= 300:
        return Image.asset('asset/1.png');
      case > 200 && <= 300:
        return Image.asset('asset/2.png');
      case > 300 && <= 400:
        return Image.asset('asset/3.png');
      case > 500 && <= 600:
        return Image.asset('asset/4.png');
      case > 600 && <= 700:
        return Image.asset('asset/5.png');
      case > 700 && <= 800:
        return Image.asset('asset/6.png');
      case > 800:
        return Image.asset('asset/7.png');
      case > 800 && <= 804:
        return Image.asset('asset/8.png');

        break;
      default:
        return Image.asset('assets/7.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        // foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Align(
              alignment: const AlignmentDirectional(3, 0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.deepPurple),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-3, -0.3),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFF673AB7)),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, -1.2),
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xFFFFAB40)),
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent)),
            ),
            BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
              if (state is WeatherBlocSucess) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${state.weather.areaName}",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                        const Text(
                          "Good Morning",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        getWeatherIcon(state.weather.weatherConditionCode!),
                        Center(
                          child: Text(
                            "${state.weather.temperature!.celsius!.round()}ºC",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 55,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Center(
                          child: Text(
                            state.weather.weatherMain!,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            DateFormat('EEEE dd •')
                                .add_jm()
                                .format(state.weather.date!),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyCard(
                                image: 'assets/11.png',
                                time: DateFormat()
                                    .add_jm()
                                    .format(state.weather.sunrise!),
                                daytime: "Sunset"),
                            const SizedBox(
                              width: 0,
                            ),
                            MyCard(
                                image: 'assets/12.png',
                                time: DateFormat()
                                    .add_jm()
                                    .format(state.weather.sunset!),
                                daytime: "Sunset"),
                          ],
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyCard(
                                image: 'assets/13.png',
                                time:
                                    '${state.weather.tempMax!.celsius!.round()}℃',
                                daytime: "Temp Max"),
                            const SizedBox(
                              width: 10,
                            ),
                            MyCard(
                                image: 'assets/14.png',
                                time:
                                    '${state.weather.tempMin!.celsius!.round()}℃',
                                daytime: "Temp Min"),
                          ],
                        )
                      ]),
                );
              } else {
                return Container();
              }
            })
          ]),
        ),
      ),
    );
  }
}

// lib/views/widgets/current_weather_card.dart

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'dart:ui'; // Needed for FontFeature
import 'package:weatherly/models/weather_data_model.dart';

class CurrentWeatherCard extends StatefulWidget {
  // ✅ ADDED: weatherData parameter to accept live data
  final WeatherData weatherData;
  const CurrentWeatherCard({super.key, required this.weatherData});

  @override
  State<CurrentWeatherCard> createState() => _CurrentWeatherCardState();
}

class _CurrentWeatherCardState extends State<CurrentWeatherCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: Card(
        color: Colors.grey[900],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CURRENT WEATHER",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    // ✅ DYNAMIC: Show current time
                    TimeOfDay.now().format(context),
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.white24,
                thickness: 0.5,
                height: 32,
                indent: 8,
                endIndent: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        // ✅ DYNAMIC: Show weather icon from API
                        Image.network(
                          'https://openweathermap.org/img/wn/${widget.weatherData.icon}@4x.png',
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ✅ DYNAMIC: Show temperature
                                Text(
                                  "${widget.weatherData.temperature.round()}°",
                                  style: const TextStyle(
                                    fontSize: 72,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(top: 8.0, left: 2.0),
                                  child: Text(
                                    "F",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // ✅ DYNAMIC: Show "feels like" temperature
                        RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'sans-serif',
                            ),
                            children: [
                              const TextSpan(text: "RealFeel"),
                              const TextSpan(
                                text: "®",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFeatures: [FontFeature.superscripts()],
                                ),
                              ),
                              TextSpan(text: " ${widget.weatherData.feelsLike.round()}°"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (_isExpanded) _buildExpandedDetails(),
              const Divider(
                color: Colors.white24,
                thickness: 0.5,
                height: 32,
                indent: 8,
                endIndent: 8,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isExpanded
                          ? "CLOSE CURRENT CONDITIONS"
                          : "MORE CURRENT CONDITIONS",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      _isExpanded
                          ? PhosphorIcons.caretUp()
                          : PhosphorIcons.caretDown(),
                      color: Colors.white.withOpacity(0.8),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandedDetails() {
    return Column(
      children: [
        const SizedBox(height: 10),
        // ✅ DYNAMIC: Show all details from the API
        _buildDetailRow("Wind", "${widget.weatherData.windSpeed.toStringAsFixed(1)} mph"),
        _buildDetailRow("Humidity", "${widget.weatherData.humidity}%"),
        _buildDetailRow("Description", widget.weatherData.description),
        // You can add more details here if the API provides them
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:crypto_lab/model/time_interval.dart';

/// The TimeIntervalService provides functionalites that can be used on the model [TimeInterval].
class TimeIntervalService {
  /// TimeIntervalService-Singleton
  static final TimeIntervalService _instance = TimeIntervalService._internal();

  factory TimeIntervalService() => _instance;

  TimeIntervalService._internal();

  /// Returns a TimeInterval by a given [timeIntervalName].
  ///
  /// Throws an [Exception] if no appropriate TimeInterval can be found.
  TimeInterval getTimeIntervalByName(String timeIntervalName) {
    for (TimeInterval timeInterval in TimeInterval.values) {
      if (timeInterval.name == timeIntervalName) {
        return timeInterval;
      }
    }
    throw Exception("Dies ist keine gültige Zeitspanne!");
  }

  /// Returns a list of strings containing all name-values of the TimeInterval-enum.
  List<String> getAllTimeIntervalNames() {
    List<String> listOfTimeIntervalNames = [];
    for (TimeInterval timeInterval in TimeInterval.values) {
      listOfTimeIntervalNames.add(timeInterval.name);
    }
    return listOfTimeIntervalNames;
  }
}

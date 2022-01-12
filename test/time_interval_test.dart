import 'package:crypto_lab/controller/time_interval_service.dart';
import 'package:crypto_lab/model/time_interval.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GIVEN a name of a time interval WHEN getting a time interval THEN a correct time interval is returned', () {
    // ARRANGE
    String testTimeIntervalName = "30d";

    // ACT
    TimeInterval testTimeInterval = TimeIntervalService().getTimeIntervalByName(testTimeIntervalName);

    // ASSERT
    expect(testTimeInterval, TimeInterval.thirtyDays);
  });

  test('WHEN getting all time interval names THEN all possible time interval names are returned', () {
    // ARRANGE
    List<TimeInterval> timeIntervals = [
      TimeInterval.oneDay,
      TimeInterval.sevenDays,
      TimeInterval.fourteenDays,
      TimeInterval.thirtyDays,
      TimeInterval.ninetyDays,
      TimeInterval.oneHundredEightyDays,
      TimeInterval.oneYear,
      TimeInterval.maximum
    ];
    List<String> timeIntervalsNames = [];

    // ACT
    List<String> testTimeIntervalsNames = TimeIntervalService().getAllTimeIntervalNames();

    // ASSERT
    for(TimeInterval timeInterval in timeIntervals) {
      timeIntervalsNames.add(timeInterval.name);
    }
    expect(testTimeIntervalsNames, timeIntervalsNames);
  });
}

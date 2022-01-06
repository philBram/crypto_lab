enum TimeInterval {
  oneDay,
  sevenDays,
  fourteenDays,
  thirtyDays,
  ninetyDays,
  oneHundredEightyDays,
  oneYear,
  maximum,
}

extension TimeIntervalExtension on TimeInterval {
  String get name {
    switch (this) {
      case TimeInterval.oneDay:
        return "24h";
      case TimeInterval.sevenDays:
        return "7d";
      case TimeInterval.fourteenDays:
        return "14d";
      case TimeInterval.thirtyDays:
        return "30d";
      case TimeInterval.ninetyDays:
        return "90d";
      case TimeInterval.oneHundredEightyDays:
        return "180d";
      case TimeInterval.oneYear:
        return "1y";
      case TimeInterval.maximum:
        return "Max";
      default:
        return "1y";
    }
  }

  String get dayValue {
    switch (this) {
      case TimeInterval.oneDay:
        return "1";
      case TimeInterval.sevenDays:
        return "7";
      case TimeInterval.fourteenDays:
        return "14";
      case TimeInterval.thirtyDays:
        return "30";
      case TimeInterval.ninetyDays:
        return "90";
      case TimeInterval.oneHundredEightyDays:
        return "180";
      case TimeInterval.oneYear:
        return "365";
      case TimeInterval.maximum:
        return "max";
      default:
        return "365";
    }
  }
}
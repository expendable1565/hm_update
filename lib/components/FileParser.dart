import 'package:path/path.dart';
import 'package:smart_health_monitor/l10n/app_localizations.dart';

class FileParser {
  static String encode(String input) {
    return input.replaceAll(":", "_").replaceAll(".", "?");
  }

  static String decode(String input) {
    return input
        .replaceAll("_", ":")
        .replaceAll("?", ".")
        .replaceAll(".m4a", "");
  }

  static String toDisplayString(String input, AppLocalizations localization) {
    var nameMappings = {
      "FrontLungs": localization.frontLungs,
      "BackLungs": localization.backLungs,
    };

    var baseName = basename(input);
    var split = baseName.split("-");
    var name = split[0];

    split.removeAt(0);
    var date = split
        .join("-")
        .replaceAll(".m4a", "")
        .replaceAll("?", ".")
        .replaceAll("_", ":");
    var dateObject = DateTime.tryParse(date);

    if (dateObject == null) {
      return "";
    }

    for (var key in nameMappings.keys) {
      var translation = nameMappings[key]!;
      name = name.replaceAll(key, translation);
    }

    return "(${dateObject.day}/${dateObject.month}/${dateObject.year}) $name";
  }
}

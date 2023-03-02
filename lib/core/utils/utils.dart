import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

 OsUser osDeviceApp = OsUser.mobile;


final _logger = Logger(
    level: kReleaseMode ? Level.warning : Level.debug, printer: _LogPrinter());

Logger get logger => _logger;

enum ModeChart {day ,month, year}

Map<String, ModeChart> get mapModeChart => {"Day": ModeChart.day,"Month": ModeChart.month, "Year": ModeChart.year};

enum ModeTime {sec ,minute, hour}

Map<String, ModeTime> get mapModeTime => {"Second": ModeTime.sec,"Minute": ModeTime.minute, "Hour": ModeTime.hour};

enum ModelChart {line ,spline, column, bar, splineArea}

Map<String, ModelChart> get mapModelChart => {"line": ModelChart.line,"spline":
ModelChart.spline,  "bar": ModelChart.bar,"column": ModelChart.column, "splineArea": ModelChart.splineArea};



//typedef DeviceTypeAndSubtype = Tuple<int,int>;

String roomPicture(int type) => _roomPictures[type] ?? "room.jpg";

Map<int, String> _roomPictures = {
  0: "kitchen.jpg",
  1: "livingroom.jpg",
  2: "room.jpg"
};


const DEFAULT_HOST = "bagvand.ir";
// const DEFAULT_HOST = "192.168.101.154";
int? get DEFAULT_PORT => null; // = 8801;
const String DEFAULT_PROTOCOL = "https";
String get HOST_URL => "$DEFAULT_PROTOCOL://$DEFAULT_HOST/$DEFAULT_APIS_PREFIX/";
String get HOST_URL_HOME_AMN => "$DEFAULT_PROTOCOL://$DEFAULT_HOST/";
const String DEFAULT_METHOD_CHANNEL = "channels/default";
const String DEFAULT_APIS_PREFIX = "api/v1";
const String DEFAULT_APIS_PREFIX_HOME_AMN = "api/v1";
const GEO_LOCATION_REG_EX = r"^-?\d+(\.\d+)?,-?\d+(\.\d+)?";
var sizeForMobileStatusBar = kIsWeb?0.0:Platform.isAndroid?17.0:0.0;

String convertToHttps(String image) {
 var res = image.replaceAll("http://", "https://");
 logger.d(res);
 return res;
}

extension MaUtils<K, V> on Map<K, V> {
  K? keyOf(V v) {
    try {
      return entries.firstWhere((e) => e.value == v).key;
    } catch (e) {
      return null;
    }
  }
}

class _LogPrinter extends PrettyPrinter {
  @override
  List<String> log(LogEvent event) {
    if (event.level == Level.error ||
        event.level == Level.warning ||
        event.level == Level.wtf) {
      // Sentry.captureException(event.error, stackTrace: event.stackTrace);
    }
    if (event.level.index == Level.info.index) {
      // Sentry.captureMessage(event.message);
    }
    return super.
    log(event);
  }
}

removeNulls(Map? map) {
  map?.removeWhere((key, value) => value == null);
}

extension MapUtils on Map {
  void removeNullEntries() => removeNulls(this);
}

enum OsUser {web, mobile, linux}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static bool isBig(BuildContext context) {
    // var isBig = context.isLargeTablet;
    Orientation big = MediaQuery.of(context).orientation;
    return Orientation.landscape == big;
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

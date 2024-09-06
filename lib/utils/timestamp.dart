import 'package:intl/intl.dart';

String formatTimestamp(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp).toLocal();
  DateTime now = DateTime.now();

  if (dateTime.year == now.year && dateTime.month == now.month && dateTime.day == now.day) {
    return DateFormat('hh:mm a').format(dateTime);
  } else {
    return DateFormat('MMM dd, hh:mm a').format(dateTime);
  }
}

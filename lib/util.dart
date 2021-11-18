import 'package:intl/intl.dart';

String getDate(DateTime dateTime) {
  return DateFormat('EEE h:mm a, dd/MM/yyyy').format(dateTime);
}

enum EditMode { ADD, REMOVE, UPDATE }

enum TodoScreen { collection, taskList }
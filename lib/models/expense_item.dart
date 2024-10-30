import 'package:uuid/uuid.dart';

class ExpenseItem {
  static final Uuid _uuid = Uuid();

  final String id;
  String name;
  String amount;
  final DateTime dateTime;

  ExpenseItem({
    required this.name,
    required this.amount,
    required this.dateTime,
  }) : id = _uuid.v4();
}
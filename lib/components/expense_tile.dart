import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final void Function(BuildContext)? deleteTapped;
  final void Function(BuildContext)? editTapped;

  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
    required this.editTapped
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const StretchMotion(), 
        children: [
          SlidableAction(
            onPressed: editTapped,
            icon: Icons.edit,
            backgroundColor: Colors.blue,
            borderRadius: BorderRadius.circular(5),
          )
        ]
      ),
      endActionPane: ActionPane(
        motion: const StretchMotion(), 
        children: [
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,  
            backgroundColor: Colors.red.shade400,
            borderRadius: BorderRadius.circular(5),
          )
        ]
      ),
      child: ListTile(
        title: Text(name),
        subtitle: Text("${dateTime.day}/${dateTime.month}/${dateTime.year}"),
        trailing: Text(
          "\$$amount",
          style: const TextStyle(
            fontSize: 14,
          ),  
        ),
      ),
    );
  }
}
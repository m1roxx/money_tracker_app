import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final newExpenseNameController = TextEditingController();
  final newExpenseDollarsController = TextEditingController();
  final newExpenseCentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          "Add new expense",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2
                  )
                )
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newExpenseDollarsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Dollars",
                      hintStyle: TextStyle(
                        color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2
                        )
                      )
                    ),
                  ),
                ),

                Expanded(
                  child: TextField(
                    controller: newExpenseCentsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Cents",
                      hintStyle: TextStyle(
                        color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2
                        )
                      )
                    ),
                  ),
                ),
              ],
            )
          ],
        ),

        actions: [
          MaterialButton(
            onPressed: save,
            child: Text(
              "Save",
              style: TextStyle(
                color: Colors.grey[800]
              ),
            ),
          ),

          MaterialButton(
            onPressed: cancel,
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.grey[800]
              ),  
            ),
          ),
        ],
      )
      
    );
  }

  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(expense);
  }

  void editExpense(ExpenseItem expense) {
    newExpenseNameController.text = expense.name;
    var amountParts = expense.amount.split('.');
    newExpenseDollarsController.text = amountParts[0];
    newExpenseCentsController.text = amountParts.length > 1 ? amountParts[1] : '';

    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text(
          "Edit expense",
          style: TextStyle(
            fontSize: 22,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newExpenseNameController,
              decoration: const InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 2
                  )
                )
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: newExpenseDollarsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Dollars",
                      hintStyle: TextStyle(
                        color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2
                        )
                      )
                    ),
                  ),
                ),

                Expanded(
                  child: TextField(
                    controller: newExpenseCentsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Cents",
                      hintStyle: TextStyle(
                        color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2
                        )
                      )
                    ),
                  ),
                ),
              ],
            )
          ],
        ),

        actions: [
          MaterialButton(
            onPressed: () => edit(expense),
            child: Text(
              "Save",
              style: TextStyle(
                color: Colors.grey[800]
              ),
            ),
          ),

          MaterialButton(
            onPressed: cancel,
            child: Text(
              "Cancel",
              style: TextStyle(
                color: Colors.grey[800]
              ),  
            ),
          ),
        ],
      )
    );
  }

  void edit(ExpenseItem expense) {
    if (newExpenseNameController.text.isNotEmpty && newExpenseDollarsController.text.isNotEmpty) {
      String updatedAmount = newExpenseDollarsController.text;
      if (newExpenseCentsController.text.isNotEmpty) {
        updatedAmount += ".${newExpenseCentsController.text}";
      }

      expense.name = newExpenseNameController.text;
      expense.amount = updatedAmount;

      Provider.of<ExpenseData>(context, listen: false).updateExpense(expense);

      Navigator.pop(context);
      clearController();
    }
  }

  void save() {
    if (newExpenseNameController.text.isNotEmpty && newExpenseDollarsController.text.isNotEmpty) {
      String amount = "";
      if (newExpenseCentsController.text.isNotEmpty) {
        amount = '${newExpenseDollarsController.text}.${newExpenseCentsController.text}';
      } else {
        amount = newExpenseDollarsController.text;
      }
      

      ExpenseItem newExpense = ExpenseItem(
        name: newExpenseNameController.text, 
        amount: amount, 
        dateTime: DateTime.now()
      );

      Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    }

    Navigator.pop(context);
    clearController();
  }

  void cancel() {
    Navigator.pop(context);
    clearController();
  }

  void clearController() {
    newExpenseNameController.clear();
    newExpenseDollarsController.clear();
    newExpenseCentsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: FloatingActionButton(
          onPressed:  addNewExpense,
          backgroundColor: Colors.black,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white,), 
        ),
        
        body: ListView(
          children: [
            // weekly summary
            ExpenseSummary(startOfWeek: value.startOfWeekDate()),

            const SizedBox(height: 20,),

            // expense list 
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name, 
                amount: value.getAllExpenseList()[index].amount, 
                dateTime: value.getAllExpenseList()[index].dateTime,
                deleteTapped: (p0) => deleteExpense(value.getAllExpenseList()[index]),
                editTapped: (p0) => editExpense(value.getAllExpenseList()[index]),
              )
            ),
          ]
        ),
      ),
    );
  }
}
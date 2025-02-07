import 'package:blaemuya/professional/screens/subscription_options.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:flutter/material.dart';

class ProfessionalPayment extends StatelessWidget {
  void _showDepositDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Deposit Money"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Enter the amount to deposit"),
              TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Amount",
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Please enter numbers only';
                    }
                  }
                  return null;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText('Payment history'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showDepositDialog(
                  context); // Show the dialog when the icon is pressed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subscription Info Card with Gradient Background
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color.fromARGB(
                          255, 183, 196, 255), // Starting color
                      const Color.fromARGB(255, 122, 131,
                          167), // Ending color (you can adjust this)
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Premium user",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Start Date: 01/01/2025"),
                            SizedBox(height: 4),
                            Text("End Date: 01/02/2025"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Total Balance",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "500",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 122, 131, 167),
                      ),
                    ),
                    SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubscriptionPlanSelectionPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Buy package",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            // Transaction History Title
            Text(
              "Transaction history",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 85, 81, 81),
              ),
            ),

            SizedBox(height: 12),

            // Transaction Cards
            _buildTransactionCard(
                "Subscription payment", "21/1/2025", "5 PM", "800 Birr"),
            SizedBox(height: 8),
            _buildTransactionCard(
                "Subscription payment", "21/1/2025", "4 AM", "800 Birr"),
          ],
        ),
      ),
    );
  }

  // Widget for transaction history card
  Widget _buildTransactionCard(
      String title, String date, String time, String amount) {
    return Card(
      color: Color.fromARGB(255, 183, 187, 206),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                SizedBox(height: 4),
                Text("$date  $time",
                    style: TextStyle(fontSize: 12, color: Colors.grey[700])),
              ],
            ),
            Text(amount,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[900])),
          ],
        ),
      ),
    );
  }
}

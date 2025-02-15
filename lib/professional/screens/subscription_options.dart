import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blaemuya/widgets/appBar_text.dart';

class SubscriptionPlanSelectionPage extends ConsumerStatefulWidget {
  @override
  _SubscriptionPlanSelectionPageState createState() =>
      _SubscriptionPlanSelectionPageState();
}

class _SubscriptionPlanSelectionPageState
    extends ConsumerState<SubscriptionPlanSelectionPage> {
  int selectedPlanIndex = 0;
  int selectedDuration = 1;
  double totalPrice = 0.0;

  // Define prices for each plan per month
  final List<double> planPrices = [90.0, 150.0, 190.0];

  // Define number of jobs allowed for each plan
  final List<int> planJobsLimit = [5, 10, 20];

  // Define plan names
  final List<String> planNames = ["Silver", "Gold", "Diamond"];

  @override
  void initState() {
    super.initState();
    updatePrice(selectedPlanIndex);
  }

  void updatePrice(int index) {
    setState(() {
      selectedPlanIndex = index;
      totalPrice = planPrices[index] * selectedDuration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: CustomText("Payment"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 120.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 14.0),
                  // Plan Selection Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildPlanButton('Silver', 0),
                      _buildPlanButton('Gold', 1),
                      _buildPlanButton('Diamond', 2),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Duration Dropdown
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButton<int>(
                      value: selectedDuration,
                      onChanged: (value) {
                        setState(() {
                          selectedDuration = value!;
                          updatePrice(selectedPlanIndex);
                        });
                      },
                      items:
                          [1, 3, 6, 12].map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(
                            '$value month${value > 1 ? 's' : ''}',
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Availability and Job Application Info
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "✔ You will be available on the platform for ${selectedDuration} months.",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "✔ You can apply upto  ${planJobsLimit[selectedPlanIndex]} jobs.",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Price Summary
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Summary',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Per month:'),
                              Text(
                                '${planPrices[selectedPlanIndex].toStringAsFixed(2)} Birr',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total:'),
                              Text(
                                '${totalPrice.toStringAsFixed(2)} Birr',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Payment Method
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Pay with',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle payment method
                    },
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/chapa_logo (1).png',
                        height: 50,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanButton(String text, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          updatePrice(index);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: selectedPlanIndex == index
                ? const Color.fromARGB(255, 9, 19, 58)
                : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: selectedPlanIndex == index ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

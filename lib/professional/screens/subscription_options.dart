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
  double pricePerMonth = 50.0; 
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    updatePrice(selectedPlanIndex); 
  }

  void updatePrice(int index) {
    setState(() {
      selectedPlanIndex = index;
      if (selectedDuration == 1) {
        totalPrice = pricePerMonth;
      } else if (selectedDuration == 3) {
        totalPrice = pricePerMonth * 3;
      } else if (selectedDuration == 6) {
        totalPrice = pricePerMonth * 6;
      }
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
                  // Plan Selection Buttons (Make them equal in size)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildPlanButton('Silver', 0),
                      _buildPlanButton('Gold', 1),
                      _buildPlanButton('Premium', 2),
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
                      items: [1, 3, 6, 12].map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(
                            '$value month${value > 1 ? 's' : ''}',
                          ),
                        );
                      }).toList(),
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
                              Text('Per 1 month:'),
                              Text(
                                '${pricePerMonth.toStringAsFixed(2)} Birr',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
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

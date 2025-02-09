import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/widgets/job/customer_profile_card.dart';
import 'package:blaemuya/professional/screens/jobs/new_jobs.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:blaemuya/widgets/job/customers_Commented_card.dart';
import 'package:blaemuya/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:blaemuya/widgets/new_jobs_card.dart';

class CustomerComment extends StatelessWidget {
  const CustomerComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText('Professionals Comments'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             SizedBox(
              width: double.infinity,
              child:  CustomersReviewsCard(
                name: "John Doe",
                imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9SRRmhH4X5N2e4QalcoxVbzYsD44C-sQv-w&s",
                rating: 4.5,
                Profession: 'Electrician',
                 date: '12/2/2021', 
                 Comment: 'He is good Professional,  ',
                onImageTap: () {
                  // Handle image click action
                   
                 
                }, ),
                
             ),
             
             
            
            ],
          );
        },
      ),
    );
  }
}

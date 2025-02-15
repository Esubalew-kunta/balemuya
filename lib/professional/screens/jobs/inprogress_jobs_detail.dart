import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/professional/screens/jobs/customers_commented.dart';
import 'package:blaemuya/widgets/job/customer_profile_card.dart';
import 'package:blaemuya/professional/screens/jobs/new_jobs.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:blaemuya/widgets/job/customers_Commented_card.dart';
import 'package:blaemuya/widgets/job/inprogress_jobs_details_card.dart';
import 'package:blaemuya/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:blaemuya/widgets/new_jobs_card.dart';

class InprogressJobsDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText(' inprogress Job Details'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: InprogressJobsDetailsCard(
                  cancelButton: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Cancel Job"),
                            content: Text(
                                "Are you sure you want to cancel this job?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text("No",
                                    style: TextStyle(color: Colors.blue)),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();

                                  // Show the animated snackbar
                                  showCustomSnackBar(
                                    context,
                                    title: 'Cancelled',
                                    message: "Job has been cancelled!",
                                    type: AnimatedSnackBarType.error,
                                  );
                                },
                                child: Text("Yes",
                                    style: TextStyle(color: Colors.red)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(40, 218, 7, 7),
                      side: BorderSide(
                        color: const Color.fromARGB(99, 253, 0, 0),
                      ),
                      minimumSize: Size(100, 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  title: 'Plumbing',
                  urgency: 'Urgent',
                  time: '2 hr ago',
                  distance: "1.2 km",
                  description:
                      "Looking for an experienced plumber to fix a leaking pipe.",
                ),
              ),
              SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  "Customer Info",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              CustomerInfoCard(
                name: "John Doe",
                imageUrl:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9SRRmhH4X5N2e4QalcoxVbzYsD44C-sQv-w&s",
                rating: 4.5,
                address: "Addis Ababa",
                peopleHired: 15,
                onImageTap: () {
                  // Handle image click action
                },
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomersCommented(),
                          ),
                        );
                      },
                      child: const Text('Previous Reviews',
                          style: TextStyle(color: primaryColor)),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:blaemuya/professional/screens/jobs/customers_commented.dart';
import 'package:blaemuya/widgets/job/customer_profile_card.dart';
import 'package:blaemuya/professional/screens/jobs/new_jobs.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:blaemuya/widgets/job/customers_Commented_card.dart';
import 'package:blaemuya/widgets/job/requested_job_card.dart';
import 'package:blaemuya/widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:blaemuya/widgets/new_jobs_card.dart';

class RequestedJob extends StatelessWidget {
  final List<Map<String, String>> jobs = [
    {
      "title": "Plumbing repair",
      "time": "2 hr ago",
      "urgency": "Urgent",
      "distance": "2 Km away",
      "description":
          "Experienced plumber needed for immediate repair of a leaking pipe in a residential area. Tools and materials provided on-site.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        itemCount: jobs.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: RequestedJobCard(
                  title: jobs[index]["title"]!,
                  urgency: jobs[index]["urgency"]!,
                  time: jobs[index]["time"]!,
                  distance: jobs[index]["distance"]!,
                  description: jobs[index]["description"]!,
                  ///////////////////////
                  acceptButton: ElevatedButton(
                    onPressed: () {
                      showCustomSnackBar(
                        context,
                        title: 'Success',
                        message:
                            "Congratulations, you have Accepted job offer!",
                        type: AnimatedSnackBarType.success,
                      );
                    },
                    child: Text(
                      'Accept',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w300),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(40, 80, 200, 120),
                      side: BorderSide(
                          color: const Color.fromARGB(99, 0, 255, 85)),
                      minimumSize: Size(100, 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
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
                                  Navigator.of(context)
                                      .pop(); // Close the dialog

                                  // Show the animated snackbar
                                  showCustomSnackBar(
                                    context,
                                    title: 'Cancelled',
                                    message: "Job offer has been cancelled!",
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
                      backgroundColor: const Color.fromARGB(40, 214, 19, 19),
                      side: BorderSide(
                        color: const Color.fromARGB(98, 255, 0, 0),
                      ),
                      minimumSize: Size(100, 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
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
                name: "Tigist Abebe",
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

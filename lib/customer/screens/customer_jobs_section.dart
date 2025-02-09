import 'package:blaemuya/customer/screens/jobs/applied_candidates.dart';
import 'package:blaemuya/customer/screens/jobs/completed_jobs.dart';
import 'package:blaemuya/customer/screens/jobs/pending_jobs.dart';
import 'package:blaemuya/customer/screens/jobs/posted_jobs.dart';
import 'package:blaemuya/customer/screens/jobs/requested_professionals.dart';
import 'package:blaemuya/professional/screens/jobs/applied_jobs.dart';
import 'package:blaemuya/professional/screens/jobs/inprogress_jobs.dart';
import 'package:blaemuya/professional/screens/jobs/new_jobs.dart';
import 'package:blaemuya/professional/screens/jobs/requested_job.dart';
import 'package:blaemuya/professional/screens/pHome.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:flutter/material.dart';

class CustomerJobsSection extends StatefulWidget {
  @override
  _CustomerJobsSectionState createState() => _CustomerJobsSectionState();
}

class _CustomerJobsSectionState extends State<CustomerJobsSection>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: CustomText('Job Listings'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 69, 81, 131),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: Colors.white),
                  insets: EdgeInsets.symmetric(horizontal: 16),
                ),
                tabs: const [
                  Tab(text: "Posted"),
                  Tab(text: "Requested"),
                  Tab(text: "Pending"),
                  Tab(text: "Candidates"),
                  Tab(text: "Completed"),
                  Tab(text: "Cancelled"),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                PostedJobs(),
                RequestedProfessionals(),
                PendingJobs(),
                AppliedCandidatesList(),
                CompletedJobs(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

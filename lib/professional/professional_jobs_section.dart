import 'package:blaemuya/professional/screens/jobs/applied_jobs.dart';
import 'package:blaemuya/professional/screens/jobs/inprogress_jobs.dart';
import 'package:blaemuya/professional/screens/jobs/new_jobs.dart';
import 'package:blaemuya/professional/screens/jobs/professional_completed_jobs.dart';
import 'package:blaemuya/professional/screens/jobs/requested_job.dart';
import 'package:blaemuya/professional/screens/pHome.dart';
import 'package:blaemuya/utils/colors.dart';
import 'package:blaemuya/widgets/appBar_text.dart';
import 'package:flutter/material.dart';

class JobScreen extends StatefulWidget {
  @override
  _JobScreenState createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen>
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
              color: const Color.fromARGB(255, 182, 128, 226),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Align(
              alignment: Alignment.center,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: const Color.fromARGB(255, 26, 26, 26),
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(width: 3.0, color: Colors.white),
                  insets: EdgeInsets.symmetric(horizontal: 16),
                ),
                tabs: const [
                  Tab(text: "New"),
                  Tab(text: "Applied"),
                  Tab(text: "Requested"),
                  Tab(text: "In Progress"),
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
                NewJobs(),
                AppliedJobs(),
                RequestedJob(),
                InprogressJobs(),
                ProfessionalCompletedJobs(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

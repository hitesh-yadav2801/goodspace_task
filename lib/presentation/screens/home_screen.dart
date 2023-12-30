import 'package:flutter/material.dart';
import 'package:goodspace_task/core/constants/my_colors.dart';
import 'package:goodspace_task/core/constants/my_strings.dart';
import 'package:goodspace_task/core/routes.dart';
import 'package:goodspace_task/data/http_inactive_product.dart';
import 'package:goodspace_task/presentation/common_widgets/job_card.dart';
import 'package:goodspace_task/presentation/common_widgets/profile_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/my_vars.dart';
import '../../data/Models/models.dart'; // Import your custom card widget

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Data>? jobDataList;

  @override
  void initState() {
    super.initState();
    fetchJobDetails();
  }

  Future<void> fetchJobDetails() async {
    // Fetch job details using HttpJobDetails
    final List<Data>? response = await HttpJobDetails.fetchJobDetails();

    if (response != null) {
      setState(() {
        jobDataList = response;
      });
    } else {
      // Handle error
      print('Failed to fetch job details.');
    }
  }
  Future<void> showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Confirmation'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                logout(context); // Call the logout function
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(MyStrings.AUTH_TOKEN_KEY);

    // Update isLoggedIn variable
    MyVars.isLoggedIn = false;

    // Navigate to the login screen
    Navigator.pushReplacementNamed(context, Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row with CircleAvatar and IconButtons
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.diamond_outlined, color: MyColors.blueColor,),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none_outlined),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.format_align_right_rounded),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout_outlined, color: Colors.red,),
                      onPressed: () => showLogoutConfirmationDialog(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Row with Icon and Text "Step into the future"
                const Row(
                  children: [
                    Icon(Icons.diamond_outlined, color: MyColors.yellowColor,),
                    SizedBox(width: 8),
                    Text(
                      "Step into the future",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Horizontal List View with Custom Cards
                SizedBox(
                  height: 120,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ProfileCard(
                        imageUrl: 'assets/images/person1.png',
                        name: 'Neha',
                        designation: 'Frontend Developer',
                        isVerified: true,
                      ),
                      ProfileCard(
                        imageUrl: 'assets/images/person2.png',
                        name: 'Rahul',
                        designation: 'Mobile Developer',
                        isVerified: true,
                      ),
                      ProfileCard(
                        imageUrl: 'assets/images/person3.png',
                        name: 'Kartik',
                        designation: 'Data Engineer',
                        isVerified: false,
                      ),

                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Text "Jobs for you"
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Jobs for you',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: MyColors.blueColor
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Horizontal Line
                Container(
                  height: 1.5,
                  color: MyColors.blueColor,
                ),
                const SizedBox(height: 16),

                // Search Text Field
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Search Jobs',
                    prefixIcon: Icon(Icons.search, color: MyColors.primaryColor,),
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 14)
                  ),
                ),
                const SizedBox(height: 16),

                if (jobDataList != null)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: jobDataList!.length,
                    itemBuilder: (context, index) {
                      return JobCard(
                        // Extract job data from jobData and pass it to JobCard
                        jobTitle: jobDataList![index].cardData?.title ?? '',
                        companyName: jobDataList![index].cardData?.companyName ?? '',
                        location: jobDataList![index].cardData?.locationCity ?? 'Remote',
                        postedDuration: jobDataList![index].cardData?.relativeTime ?? '',
                        pay: jobDataList![index].cardData?.monthlyCompensation ?? '',
                        experience:
                        '${jobDataList![index].cardData?.lowerworkex ?? ''}-${jobDataList![index].cardData?.upperworkex ?? ''} Years',
                        jobType: jobDataList![index].cardData?.isRemote == 1 ? 'Remote' : 'On-Site',
                        recruiterName: jobDataList![index].cardData?.userInfo?.name ?? '',
                        avatarImagePath: 'assets/images/recruiter.png',
                      );
                    },
                  ),


                // List of Custom Cards
                // JobCard(jobTitle: 'IOS Developer', companyName: 'GoodSpace', location: 'Delhi', postedDuration: '2 days ago', pay: '15-20 LPA', experience: '3-4 Years', jobType: 'Remote', recruiterName: 'Kachra Seth', avatarImagePath: 'assets/images/recruiter.png',),
                // JobCard(jobTitle: 'Android Developer', companyName: 'GoodSpace', location: 'Gurgaon', postedDuration: '3 days ago', pay: '15-20 LPA', experience: '3-4 Years', jobType: 'On-Site', recruiterName: 'Raju', avatarImagePath: 'assets/images/recruiter.png'),
                // JobCard(jobTitle: 'Data Scientist', companyName: 'GoodSpace', location: 'Pune', postedDuration: '5 days ago', pay: '15-20 LPA', experience: '3-4 Years', jobType: 'Hybrid', recruiterName: 'Shyam', avatarImagePath: 'assets/images/recruiter.png'),
                // JobCard(jobTitle: 'Full Stack Developer', companyName: 'GoodSpace', location: 'Bengaluru', postedDuration: 'Today', pay: '15-20 LPA', experience: '3-4 Years', jobType: 'Remote', recruiterName: 'Babu Rao', avatarImagePath: 'assets/images/recruiter.png'),
                // Add more CustomCards as needed...
              ],
            ),
          ),
        ),
      ),
    );
  }
}

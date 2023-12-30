import 'package:flutter/material.dart';
import 'package:goodspace_task/core/constants/my_colors.dart';
import 'package:goodspace_task/presentation/common_widgets/my_button.dart';

class JobCard extends StatelessWidget {
  final String jobTitle;
  final String companyName;
  final String location;
  final String postedDuration;
  final String pay;
  final String experience;
  final String jobType;
  final String recruiterName;
  final String avatarImagePath;


  JobCard({
    required this.jobTitle,
    required this.companyName,
    required this.location,
    required this.postedDuration,
    required this.pay,
    required this.experience,
    required this.jobType,
    required this.recruiterName,
    required this.avatarImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[300]!, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0, // No elevation
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job Title Row
            Row(
              children: [
                Text(
                  jobTitle,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
                ),
                const Spacer(),
                const Icon(Icons.share),
              ],
            ),
            const SizedBox(height: 8),

            // Company Name, Location, and Posted Duration Row
            Row(
              children: [
                Expanded(
                  child: Text(
                    companyName,
                    style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.home, size: 12),
                const SizedBox(width: 4),
                Text(location, style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis)),
                const Spacer(),
                Text(postedDuration, style: const TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis)),
              ],
            ),
            const SizedBox(height: 8),

            // Pay, Experience, Job Type Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.greenColor, width: 1),
                      borderRadius: BorderRadius.circular(4),
                      color: MyColors.lightGreen,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //const Text('₹', style: TextStyle(fontSize: 11, color: MyColors.greenColor)),
                          const SizedBox(width: 3),
                          Text(pay, style: const TextStyle(fontSize: 11, color: MyColors.greenColor)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.blueColor, width: 1),
                      borderRadius: BorderRadius.circular(4),
                      color: MyColors.lightBlue,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star_border, color: MyColors.blueColor, size: 11),
                          const SizedBox(width: 3),
                          Text(experience, style: const TextStyle(fontSize: 11, color: MyColors.blueColor)),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.violetColor, width: 1),
                      borderRadius: BorderRadius.circular(4),
                      color: MyColors.lightViolet,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.cases_outlined, color: MyColors.violetColor, size: 11),
                          const SizedBox(width: 3),
                          Text(jobType, style: const TextStyle(fontSize: 11, color: MyColors.violetColor, overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Circular Avatar, Texts, and Apply Button Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('assets/images/recruiter.png'),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(recruiterName, style: const TextStyle(fontSize: 14, overflow: TextOverflow.ellipsis)),
                            Text(
                              companyName,
                              style: const TextStyle(
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(child: MyButton(title: 'Apply', onPressed: () {}))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

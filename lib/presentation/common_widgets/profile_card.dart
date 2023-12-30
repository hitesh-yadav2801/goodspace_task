import 'package:flutter/material.dart';
import 'package:goodspace_task/core/constants/my_colors.dart';

class ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String designation;
  final bool isVerified;

  ProfileCard({
    required this.imageUrl,
    required this.name,
    required this.designation,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Card(
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: MyColors.blueColor, width: 1.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            width: 150,
            height: 150,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage(imageUrl),
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  designation,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        if (isVerified)
          Positioned(
            top: 2,
            right: 2,
            child: IconButton(
              icon: const Icon(Icons.verified, color: Colors.green),
              onPressed: () {}, // Add any actions for the button if needed
            ),
          ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:goodspace_task/presentation/screens/home_screen.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({Key? key}) : super(key: key);

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  late PageController pageController;
  int selectedIndex = 0;

  late List<Widget> pages;
  late List<NavigationDestination> destinations;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);

    pages = [
      const HomeScreen(), // Placeholder for the first tab
      Container(), // Placeholder for the second tab
      Container(), // Placeholder for the third tab
      Container(), // Placeholder for the fourth tab
      Container(), // Placeholder for the fifth tab
    ];

    destinations = [
      NavigationDestination(
        icon: Icon(Iconsax.briefcase, color: selectedIndex == 0 ? Colors.blue : null),
        label: 'Work',
      ),
      NavigationDestination(
        icon: Icon(Icons.handshake_outlined, color: selectedIndex == 1 ? Colors.blue : null),
        label: 'Recruit',
      ),
      NavigationDestination(
        icon: Icon(Iconsax.user_square4, color: selectedIndex == 2 ? Colors.blue : null),
        label: 'Work',
      ),
      NavigationDestination(
        icon: Icon(Iconsax.message, color: selectedIndex == 3 ? Colors.blue : null),
        label: 'Message',
      ),
      NavigationDestination(
        icon: Icon(Iconsax.user, color: selectedIndex == 4 ? Colors.blue : null),
        label: 'Profile',
      ),
    ];
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: pages,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: NavigationBar(
          height: 40,
          elevation: 0,
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          destinations: destinations,
        ),
      ),
    );
  }
}

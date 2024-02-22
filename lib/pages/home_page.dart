



import 'package:ecommerce/pages/profile_page.dart';
import 'package:ecommerce/pages/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../widgets/health_needs.dart';

import '../widgets/nearby_doctors.dart';

import '../widgets/upcoming_card.dart';
import 'message_page.dart';

import 'package:ecommerce/slideBar_menues/NavBar.dart';


import 'schedule_page.dart'; // Schedule page
import 'profile_page.dart'; // Profile page

class HomePage extends StatelessWidget {
  String name="";
  HomePage( this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text("Hi, $name"),

            Text(
              "How are you feeling today?",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.notifications_outline),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.search_outline),
          ),
        ],
      ),
      body: ListView(

        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(14),
        children: [
          const UpcomingCard(),
          const SizedBox(height: 20),
          Text(
            "Health Needs",
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 15),
          HealthNeeds(),
          SizedBox(height: 25),
          Text(
            "Nearby Doctors",
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 15),
          const NearbyDoctors(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Ionicons.home_outline),
            activeIcon: Icon(Ionicons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.calendar_outline),
            activeIcon: Icon(Ionicons.calendar),
            label: "Schedule",
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.chatbubble_ellipses_outline),
            label: "Message",
            activeIcon: Icon(Ionicons.chatbubble_ellipses),
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_outline),
            activeIcon: Icon(Ionicons.person),
            label: "Profile",
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            // Home page
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CalendarPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MessagePage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
      ),
    );
  }
}


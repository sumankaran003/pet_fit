import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_fit/add_pet_module/add_pet.dart';
import 'package:pet_fit/feedback_module/post_feedback.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.deepPurple,
          ),
          child: Text(
            'Hi User!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Profile'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.add),
          title: const Text('Add Pet'),
          onTap: () {
            Get.to(()=>AddPetScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Feedback'),
          onTap: () {
            Get.to(()=>PostFeedback());
          },
        ),
        ListTile(
          leading: const Icon(Icons.handshake),
          title: const Text('Help'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.support_agent),
          title: const Text('Support'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.details),
          title: const Text('About'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Log Out'),
          onTap: () {},
        ),
      ],
    ),
  );
}

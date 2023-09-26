import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pet_fit/addPet/add_pet_module/add_pet.dart';
import 'package:pet_fit/feedback/feedback_module/post_feedback.dart';
import 'package:pet_fit/login_module/auth_bloc.dart';
import 'package:pet_fit/login_module/auth_event.dart';
import 'package:pet_fit/login_module/auth_state.dart';

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
            Get.to(() => AddPetScreen());
          },
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Feedback'),
          onTap: () {
            Get.to(() => PostFeedback());
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
        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                context.read<AuthBloc>().add(SignOut());
              },
            );
          },
        ),
      ],
    ),
  );
}

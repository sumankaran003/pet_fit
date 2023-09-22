import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pet_fit/feedback_chip_module/feedbackchip_bloc.dart';
import 'package:pet_fit/feedback_emoji_module/feedbackemoji_bloc.dart';
import 'package:pet_fit/feedback_module/post_feedback_bloc.dart';
import 'package:pet_fit/home_page_module/homapage.dart';
import 'package:pet_fit/home_page_module/homepage_bloc.dart';
import 'package:pet_fit/login_module/auth_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_fit/login_module/auth_screen.dart';
import 'package:pet_fit/pet_list_module/pet_list_bloc.dart';
import 'package:pet_fit/pet_list_module/pet_list_screen.dart';
import 'package:pet_fit/product_list_module/product_list_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(),
        ),
        BlocProvider(
          create: (context) => PetListBloc(),
        ),
        BlocProvider(
          create: (context) => ChipBloc(),
        ),
        BlocProvider(
          create: (context) => ProductListBloc(),
        ),
        BlocProvider(
          create: (context) => EmojiBloc(),
        ),
        BlocProvider(
          create: (context) => PostFeedbackBloc(),
        ),
        BlocProvider(
          create: (context) => HomepageBloc(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Pet Fit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: user != null ? HomePage() : SignInSignUp(),
      ),
    );
  }
}

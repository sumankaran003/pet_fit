import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pet_fit/addPet/add_pet_module/add_pet_bloc.dart';
import 'package:pet_fit/addPet/capture_image_module/capture_image_module_bloc.dart';
import 'package:pet_fit/addPet/capture_video_module/capture_video_module_bloc.dart';
import 'package:pet_fit/create_schedule/create_schedule_bloc.dart';
import 'package:pet_fit/feedback/feedback_chip_module/feedbackchip_bloc.dart';
import 'package:pet_fit/feedback/feedback_emoji_module/feedbackemoji_bloc.dart';
import 'package:pet_fit/feedback/feedback_module/post_feedback_bloc.dart';
import 'package:pet_fit/home_page_module/homapage.dart';
import 'package:pet_fit/home_page_module/homepage_bloc.dart';
import 'package:pet_fit/login_module/auth_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_fit/login_module/auth_screen.dart';
import 'package:pet_fit/pet_list_module/pet_list_bloc.dart';
import 'package:pet_fit/product_list_module/product_list_bloc.dart';
import 'package:pet_fit/addPet/select_image_module/select_image_module_bloc.dart';
import 'package:pet_fit/addPet/select_video_module/select_video_module_bloc.dart';
import 'package:pet_fit/view_schedule/view_schedule_bloc.dart';

import 'login_module/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.setPersistence(Persistence.LOCAL);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
// Obtain a list of the available cameras on the device.

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
        BlocProvider(
          create: (context) => ImagePickerBloc(),
        ),
        BlocProvider(
          create: (context) => VideoPickerBloc(),
        ),
        BlocProvider(
          create: (context) => ImageCaptureBloc(),
        ),
        BlocProvider(
          create: (context) => AddPetBloc(),
        ),
        BlocProvider(
          create: (context) => VideoCaptureBloc(),
        ),
        BlocProvider(
          create: (context) => CreateScheduleBloc(),
        ),
        BlocProvider(
          create: (context) => ViewScheduleBloc(),
        ),

      ],
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {

          if(state is Unauthenticated){
            return GetMaterialApp(
              title: 'Pet Fit',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
                textTheme: GoogleFonts.poppinsTextTheme(),
              ),
              // home: TakePictureScreen(camera: firstCamera,),
              home: SignInSignUp(),
            );
          }

          return GetMaterialApp(
            title: 'Pet Fit',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
            // home: TakePictureScreen(camera: firstCamera,),
            home:HomePage(),
          );
        },
      ),
    );
  }
}

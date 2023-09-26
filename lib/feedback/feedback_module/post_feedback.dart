import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pet_fit/feedback/feedback_chip_module/feedback_chip.dart';
import 'package:pet_fit/feedback/feedback_chip_module/feedbackchip_bloc.dart';
import 'package:pet_fit/feedback/feedback_emoji_module/feedback_emoji.dart';
import 'package:pet_fit/feedback/feedback_emoji_module/feedbackemoji_bloc.dart';
import 'package:pet_fit/feedback/feedback_module/post_feedback_bloc.dart';
import 'package:pet_fit/models/feedback_model.dart';
import 'package:pet_fit/pet_list_module/pet_list_screen.dart';
import 'package:pet_fit/utilMethods.dart';
import 'package:pet_fit/widgets.dart';

class PostFeedback extends StatelessWidget {
  PostFeedback({super.key});

  final TextEditingController _textEditingController = TextEditingController();

  final List<String> emojiTexts = [
    "Very Dissatisfied",
    "Dissatisfied",
    "Neutral",
    "Happy",
    "Very Happy"
  ];
  final List<String> chipTexts = ["SUGGESTIONS", "COMPLAINTS", "COMPLEMENTS"];
  String selectedEmoji = "";
  String selectedCategory = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Feedback'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<PostFeedbackBloc, PostFeedbackState>(
            listener: (context, state) {
              if (state is PostFeedbackFailure) {
                showSnackBar("Something went wrong", state.error, "failure");
              }

              if (state is PostFeedbackSuccess) {
                showSnackBar("Feedback Submitted Successfully",
                    "Thank you for your feedback!", "success");
                Get.off(() => PetListScreen());
              }
            },
            builder: (context, state) {
              if (state is PostFeedbackLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                padding: const EdgeInsets.only(top: 18.0, left: 15, right: 15),
                child: Column(
                  children: [
                    const Text(
                      "Your Feedback is Valuable!",
                      style: TextStyle(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "We would like your feedback to improve our app",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "How do you feel about the features of our app",
                      style: TextStyle(fontSize: 16),
                    ),
                    BlocConsumer<ChipBloc, ChipState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        selectedCategory = state.selectedIndex >= 0
                            ? chipTexts[state.selectedIndex]
                            : "";
                        return FeedbackEmojis();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Please select feedback category",
                      style: TextStyle(fontSize: 16),
                    ),
                    BlocConsumer<EmojiBloc, EmojiState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        selectedEmoji = state.selectedIndex >= 0
                            ? emojiTexts[state.selectedIndex]
                            : "";
                        return ChipScreen();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Please leave your feedback below",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: _textEditingController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Leave feedback...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    GestureDetector(
                        onTap: () {
                          context.read<PostFeedbackBloc>().add(
                              SubmitFeedbackEvent(FeedBackModel(
                                  emoji: selectedEmoji,
                                  category: selectedCategory,
                                  feedbackText: _textEditingController.text,
                                  userId: "",
                                  timeStamp: "")));

                          _textEditingController.clear();
                        },
                        child: proceedButton("Submit"))
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }


}

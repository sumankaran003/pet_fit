import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feedbackemoji_bloc.dart';

class FeedbackEmojis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> chipTexts = [
      "Very Dissatisfied",
      "Dissatisfied",
      "Neutral",
      "Happy",
      "Very Happy"
    ];
    return BlocConsumer<EmojiBloc, EmojiState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              // scrollDirection: Axis.horizontal,
              children: [
                for (int i = 0; i < chipTexts.length; i++)
                  ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        state.selectedIndex == i
                            ? Colors.green
                            : Colors.transparent,
                        BlendMode
                            .color,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          context.read<EmojiBloc>().add(EmojiSelectedEvent(i));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/emojis/${i + 1}.png",
                            height: 40,
                          ),
                        ),
                      )),

              ],
            ),
          ),
        );
      },
    );
  }
}

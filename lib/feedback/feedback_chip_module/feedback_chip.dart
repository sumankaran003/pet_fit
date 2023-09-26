import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feedbackchip_bloc.dart';

class ChipScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> chipTexts = ["SUGGESTIONS", "COMPLAINTS", "COMPLEMENTS"];
    return BlocConsumer<ChipBloc, ChipState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            for (int i = 0; i < chipTexts.length; i++)
              ChoiceChip(
                selectedColor: Colors.deepPurpleAccent.shade100,
                label: Text(chipTexts[i]),
                selected: chipTexts[i] == chipTexts[state.selectedIndex],
                onSelected: (selected) {
                  context.read<ChipBloc>().add(ChipSelectedEvent(i));
                },
              ),
          ],
        );
      },
    );
  }
}

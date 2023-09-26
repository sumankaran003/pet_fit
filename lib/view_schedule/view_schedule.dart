import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_fit/models/ActivityModel.dart';
import 'package:pet_fit/view_schedule/view_schedule_bloc.dart';
import 'package:pet_fit/widgets.dart';


class ViewSchedule extends StatefulWidget {
  const ViewSchedule({super.key, required this.petId});
  final String petId;

  @override
  State<ViewSchedule> createState() => _ViewScheduleState();
}

class _ViewScheduleState extends State<ViewSchedule> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ViewScheduleBloc>(context).add(FetchSchedule(widget.petId));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("View Schedule"),
      ),
      body: BlocConsumer<ViewScheduleBloc, ViewScheduleState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          if (state is ScheduleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ScheduleLoaded) {
            final List<ActivityModel> activities = state.activities;
            return ListView.builder(

              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return activityTiles(activity);
              },
            );
          } else if (state is ScheduleLoadingError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const Center(child: Text('No pets available.'));
          }
        },
      ),
    );
  }
}

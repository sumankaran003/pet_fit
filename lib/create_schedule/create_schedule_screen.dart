import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pet_fit/create_schedule/create_schedule_bloc.dart';
import 'package:pet_fit/models/ActivityModel.dart';
import 'package:pet_fit/utilMethods.dart';
import 'package:pet_fit/widgets.dart';

class CreateSchedule extends StatefulWidget {
  const CreateSchedule({super.key});

  @override
  State<CreateSchedule> createState() => _CreateScheduleState();
}

class _CreateScheduleState extends State<CreateSchedule> {
  late DateTime selectedDateTime = DateTime.now();
  final TextEditingController _activityNameController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2013),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Schedule"),
      ),
      body: BlocConsumer<CreateScheduleBloc, CreateScheduleState>(
        listener: (context, state) {
          if (state is CreateScheduleSuccess) {
            Get.back();
          }
          if (state is CreateScheduleFailure) {
            showSnackBar("Something went wrong", "Schedule could not be added",
                "failure");
          }
          if (state is CreateScheduleSuccess) {
            showSnackBar(
                "Congratulations", "Activity Added Successfully", "success");
          }
        },
        builder: (context, state) {
          if (state is CreateScheduleLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Row(
                      children: [
                        const Text(
                          "Activity Name:",
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: TextFormField(
                          controller: _activityNameController,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Enter activity name...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Activity name is required';
                            }
                            return null;
                          },
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Selected Date: ${selectedDateTime.day}:${selectedDateTime.month}:${selectedDateTime.year}  Time: ${selectedDateTime.hour}:${selectedDateTime.minute}:${selectedDateTime.second}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () => _selectDateTime(context),
                    child: Text('Select Time'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Activity Name:",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextFormField(
                    controller: _notesController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Enter notes...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: Colors.deepPurple),
                      ),
                    ),
                    validator: (value) {
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                      onTap: () {
                        context
                            .read<CreateScheduleBloc>()
                            .add(AddScheduleEvent(ActivityModel(
                              name: _activityNameController.text,
                              activityTime: Timestamp.fromDate(selectedDateTime),
                              notes: _notesController.text,
                            )));

                        _activityNameController.clear();
                        _notesController.clear();
                      },
                      child: proceedButton("Add Activity"))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pet_fit/addPet/add_pet_module/add_pet_bloc.dart';
import 'package:pet_fit/screens/captureVideo.dart';
import 'package:pet_fit/addPet/capture_image_module/capture_image_module_bloc.dart';
import 'package:pet_fit/screens/capturePhoto.dart';
import 'package:pet_fit/addPet/capture_video_module/capture_video_module_bloc.dart';
import 'package:pet_fit/home_page_module/homapage.dart';
import 'package:pet_fit/models/pet_model.dart';
import 'package:pet_fit/addPet/select_image_module/add_image.dart';
import 'package:pet_fit/addPet/select_image_module/select_image_module_bloc.dart';
import 'package:pet_fit/addPet/select_video_module/add_video.dart';
import 'package:pet_fit/addPet/select_video_module/select_video_module_bloc.dart';
import 'package:pet_fit/utilMethods.dart';
import 'package:pet_fit/widgets.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  late DateTime selectedDate = DateTime.now();

  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _petLocationController = TextEditingController();
  final TextEditingController _petBreedController = TextEditingController();
  final TextEditingController _petOwnerDetailsController =
      TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Use the selectedDate as the initial date
      firstDate: DateTime(2013),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add photos/videos'),
          actions: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.deepPurple,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const TakePictureScreen());
                          },
                          child: const Text('Take Photo'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.deepPurple,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => ImagePickerPage());
                            //Navigator.of(context).pop();
                          },
                          child: const Text('Select photo'),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Icon(
                          Icons.video_camera_back_outlined,
                          color: Colors.deepPurple,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const TakeVideoScreen());
                          },
                          child: const Text('Take video'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(
                          Icons.video_call_outlined,
                          color: Colors.deepPurple,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => VideoPickerPage());
                            // Navigator.of(context).pop();
                          },
                          child: const Text('Select video'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        );
      },
    );
  }

  List<String> images = [];
  List<String> videos = [];
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new pet'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<AddPetBloc, AddPetState>(
            listener: (context, state) {
              if (state is AddPetFailure) {
                showSnackBar("Something went wrong", state.error, "failure");
              }

              if (state is AddPetSuccess) {
                showSnackBar("Pet Added Successfully",
                    "Thank you for your entry!", "success");

                Get.off(() => HomePage());
              }
            },
            builder: (context, state) {
              if (state is AddPetLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding:
                    const EdgeInsets.only(top: 18.0, left: 18.0, right: 18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Pet Name:",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: _petNameController,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Enter Pet Name...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Pet name is required';
                              }
                              return null;
                            },
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Pet Location:",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _petLocationController,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: 'Enter location...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                      color: Colors.deepPurple),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Location is required';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Pet DOB:",
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                              "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}"),
                          ElevatedButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            child: const Text('Select Date'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Text(
                            "Pet Breed:",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: _petBreedController,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: 'Enter breed...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                              ),
                            ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Breed is required';
                                  }
                                  return null;
                                },
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Owner's Details:",
                        style: TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      TextFormField(
                        controller: _petOwnerDetailsController,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Enter owner details...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Owner details is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text("Add pets's photos/videos"),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              _showDialog(context);
                            },
                            child: const Icon(
                              Icons.camera_alt_outlined,
                              size: 35,
                            ),
                          )
                        ],
                      ),
                      BlocConsumer<ImagePickerBloc, ImagePickerState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is ImagesUploadedState) {
                            images.addAll(state.imageUrls);

                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Selected photos",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ListView(
                                    shrinkWrap: true,
                                    children: state.imageUrls
                                        .map((url) => Text(
                                              url,
                                              overflow: TextOverflow.ellipsis,
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      BlocConsumer<VideoPickerBloc, VideoPickerState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is VideosUploadedState) {
                            videos.addAll(state.videoUrls);
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Selected videos",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ListView(
                                    shrinkWrap: true,
                                    children: state.videoUrls
                                        .map((url) => Text(
                                              url,
                                              overflow: TextOverflow.ellipsis,
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      BlocConsumer<ImageCaptureBloc, ImageCaptureState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is CapturedImagesUploadedState) {
                            images.addAll(state.imageUrls);
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Captured photos",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ListView(
                                    shrinkWrap: true,
                                    children: state.imageUrls
                                        .map((url) => Text(
                                              url,
                                              overflow: TextOverflow.ellipsis,
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      BlocConsumer<VideoCaptureBloc, VideoCaptureState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          if (state is CapturedVideosUploadedState) {
                            videos.addAll(state.videoUrls);
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Captured videos",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  ListView(
                                    shrinkWrap: true,
                                    children: state.videoUrls
                                        .map((url) => Text(
                                              url,
                                              overflow: TextOverflow.ellipsis,
                                            ))
                                        .toList(),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {if (images.isEmpty) {
                            Get.snackbar(
                                "No Images", "Please upload atleast one image");
                          } else {
                            context
                                .read<AddPetBloc>()
                                .add(SubmitPetEvent(PetModel(
                              petId: "",
                              name: _petNameController.text,
                              breed: _petBreedController.text,
                              location: _petLocationController.text,
                              ownerId: "",
                              ownerDetails: _petOwnerDetailsController.text,
                              dob: Timestamp.fromDate(selectedDate),
                              images: images,
                              videos: videos,
                            )));
                            images = [];
                            videos = [];
                            _petNameController.clear();
                            _petLocationController.clear();
                            _petBreedController.clear();
                            _petOwnerDetailsController.clear();
                          }}

                        },
                        child: proceedButton("Add Pet"),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

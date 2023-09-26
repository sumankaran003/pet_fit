import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:pet_fit/models/pet_model.dart';

part 'add_pet_event.dart';
part 'add_pet_state.dart';

class AddPetBloc extends Bloc<AddPetEvent, AddPetState> {
  AddPetBloc() : super(AddPetInitial()) {
    on<SubmitPetEvent>((event, emit) {
      emit(AddPetLoading());
      try {
        addPet(event.petModel);
        emit(AddPetSuccess());
      } catch (e) {
        emit(AddPetFailure(e.toString()));
      }
    });
  }

  Future<void> addPet(PetModel petModel) async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      final CollectionReference petsCollection =
          FirebaseFirestore.instance.collection('pets');

      await petsCollection.add({
        'petId':petModel.petId,
        'name': petModel.name,
        'breed': petModel.breed,
        'location': petModel.location,
        'ownerId': user?.uid,
        'ownerDetails': petModel.ownerDetails,
        'dob': petModel.dob,
        'images': List<String>.from(petModel.images),
        'videos': List<String>.from(petModel.videos),
      });
    } catch (e) {
      //print('$e');
    }
  }
}

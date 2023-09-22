import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:pet_fit/models/pet_model.dart';

part 'pet_list_event.dart';
part 'pet_list_state.dart';

class PetListBloc extends Bloc<PetListEvent, PetListState> {
  PetListBloc() : super(PetListInitial()) {
    on<FetchPets>((event, emit) async {
      emit(PetsLoading());
      try {
        List<PetModel> fetchedPets = await PetService.getPets();

        emit(PetsLoaded(fetchedPets));
      } catch (e) {
        emit(PetsLoadingError(e.toString()));
      }
    });
  }
}

class PetService {
  static Future<List<PetModel>> getPets() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore.collection('pets').get();


    return snapshot.docs
        .map((doc) => PetModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}


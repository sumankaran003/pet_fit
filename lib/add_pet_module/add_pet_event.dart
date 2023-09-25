part of 'add_pet_bloc.dart';

@immutable
abstract class AddPetEvent {}

class SubmitPetEvent extends AddPetEvent {
  final PetModel petModel;

  SubmitPetEvent(this.petModel);
}

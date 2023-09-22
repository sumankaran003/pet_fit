part of 'pet_list_bloc.dart';


abstract class PetListState {}

class PetListInitial extends PetListState {}

class PetsLoaded extends PetListState {
  final List<PetModel> pets;

  PetsLoaded(this.pets);
}


class PetsLoading extends PetListState {}

class PetsLoadingError extends PetListState {
  final String errorMessage;

  PetsLoadingError(this.errorMessage);
}

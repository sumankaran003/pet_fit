import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_fit/drawer.dart';
import 'package:pet_fit/models/pet_model.dart';
import 'package:pet_fit/widgets.dart';
import 'pet_list_bloc.dart';

class PetListScreen extends StatefulWidget {
  @override
  State<PetListScreen> createState() => _PetListScreenState();
}

class _PetListScreenState extends State<PetListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PetListBloc>(context).add(FetchPets());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),

      appBar: AppBar(
        title: const Text('Pet List'),
      ),
      body: BlocConsumer<PetListBloc, PetListState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PetsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PetsLoaded) {
            final List<PetModel> pets = state.pets;
            return ListView.builder(

              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                return petTiles(pet);
              },
            );
          } else if (state is PetsLoadingError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const Center(child: Text('No pets available.'));
          }
        },
      ),
    );
  }


}

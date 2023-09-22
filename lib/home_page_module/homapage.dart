import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_fit/home_page_module/homepage_bloc.dart';
import 'package:pet_fit/pet_list_module/pet_list_screen.dart';
import 'package:pet_fit/product_list_module/product_list_screen.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Widget> _screens = [
    PetListScreen(),
    ProductListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomepageBloc, HomepageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: state.selectedIndex == 0 ? _screens[0] : _screens[1],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.selectedIndex,
            onTap: (index) {
              context.read<HomepageBloc>().add(HomepageSelectedEvent(index));
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.pets),
                label: 'Pet',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Product',
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_fit/drawer.dart';
import 'package:pet_fit/models/product_model.dart';
import 'package:pet_fit/widgets.dart';
import 'product_list_bloc.dart';

class ProductListScreen extends StatefulWidget {
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductListBloc>(context).add(FetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),

      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: BlocConsumer<ProductListBloc, ProductListState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductsLoaded) {
            final List<ProductModel> products = state.products;
            return ListView.builder(

              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return productTiles(product);
              },
            );
          } else if (state is ProductsLoadingError) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return const Center(child: Text('No products available.'));
          }
        },
      ),
    );
  }


}

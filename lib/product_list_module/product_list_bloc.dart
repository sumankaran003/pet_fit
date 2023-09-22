import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:pet_fit/models/product_model.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';


class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductsLoading());
      try {
        List<ProductModel> fetchedProducts = await ProductService.getProducts();

        emit(ProductsLoaded(fetchedProducts));
      } catch (e) {
        emit(ProductsLoadingError(e.toString()));
      }
    });
  }
}

class ProductService {
  static Future<List<ProductModel>> getProducts() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot snapshot = await firestore.collection('products').get();


    return snapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}


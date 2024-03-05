import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app/features/products/domain/domain.dart';
import 'package:inventory_management_app/features/products/infrastructure/infrastructure.dart';
import 'products_repository_provider.dart';



final productProvider = StateNotifierProvider.autoDispose.family<ProductNotifier, ProductState, String>(
        (ref, productId ) {

      final productsRepository = ref.watch(productsRepositoryProvider);

      return ProductNotifier(
          productsRepository: productsRepository,
          productId: productId
      );
});


class ProductNotifier extends StateNotifier<ProductState> {

  final ProductsRepository productsRepository;

  ProductNotifier({
    required this.productsRepository,
    required String productId,
  }): super(ProductState(id: productId)) {
    loadProduct();
  }

  Product _newEmptyProduct() {
    return Product(id: 'new',
        name: '',
        price: 0,
        description: '',
        entryDate: '',
        stock: 0,
        category: '',
        images: []
        );
  }

  Future<void> loadProduct() async {
    try{
      if (state.id == 'new') {
        state = state.copyWith(
            product: _newEmptyProduct(),
            isLoading: false);

        return;
      }

      final product = await productsRepository.getProductById(state.id);
      state = state.copyWith(
        product: product,
        isLoading: false,
      );
    } catch(e) {
      throw Exception();
    }
  }
}

class ProductState {

  final String id;
  final Product? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id,
    this.product,
    this.isLoading = true,
    this.isSaving = false,
  });

  ProductState copyWith({
    String? id,
    Product? product,
    bool? isLoading,
    bool? isSaving,
  }) => ProductState(
    id: id ?? this.id,
    product: product ?? this.product,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving,
  );

}
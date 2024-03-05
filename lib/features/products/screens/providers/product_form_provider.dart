import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:inventory_management_app/config/constants/environment.dart';
import 'package:inventory_management_app/features/products/domain/domain.dart';
import 'package:inventory_management_app/features/products/screens/providers/products_provider.dart';
import 'package:inventory_management_app/features/shared/shared.dart';


final productFormProvider = StateNotifierProvider.autoDispose.family<ProductFormNotifier, ProductFormState, Product>(
        (ref, product) {

      // final createUpdateCallback = ref.watch( productsRepositoryProvider ).createUpdateProduct;
      final createUpdateCallback = ref.watch( productsProvider.notifier ).createOrUpdateProduct;

      return ProductFormNotifier(
        product: product,
        onSubmitCallback: createUpdateCallback,
      );
    }
);


class ProductFormNotifier extends StateNotifier<ProductFormState> {

  final Future<bool> Function( Map<String,dynamic> productLike )? onSubmitCallback;

  ProductFormNotifier({
    this.onSubmitCallback,
    required Product product,
  }): super(
      ProductFormState(
        id: product.id,
        name: Name.dirty(product.name),
        category: Category.dirty(product.category),
        price: Price.dirty(product.price),
        stock: Stock.dirty( product.stock ),
        entryDate: product.entryDate,
        description: product.description,
        images: product.images,
      )
  );

  Future<bool> onFormSubmit() async {
    _touchedEverything();
    if ( !state.isFormValid ) return false;

    // TODO: regresar
    if ( onSubmitCallback == null ) return false;

    final productLike = {
      'id' : (state.id == 'new') ? null : state.id,
      'name': state.name.value,
      'price': state.price.value,
      'description': state.description,
      'category': state.category.value,
      'stock': state.stock.value,
      'entryDate': state.entryDate,
      'images': state.images.map(
              (image) => image.replaceAll('${ Environment.apiUrl }/files/product/', '')
      ).toList()
    };

    try {
      return await onSubmitCallback!( productLike );
    } catch (e) {
      return false;
    }

  }


  void _touchedEverything() {
    state = state.copyWith(
      isFormValid: Formz.validate([
        Name.dirty(state.name.value),
        Slug.dirty(state.category.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.stock.value),
      ]),
    );
  }

}

class ProductFormState {

  final bool isFormValid;
  final String? id;
  final Name name;
  final Category category;
  final Price price;
  final String entryDate;
  final Stock stock;
  final String description;

  final List<String> images;

  ProductFormState({
    this.isFormValid = false,
    this.id,
    this.name = const Name.dirty(''),
    this.category = const Category.dirty(''),
    this.price = const Price.dirty(0),
    this.entryDate = '',
    this.stock = const Stock.dirty(0),
    this.description = '',
    this.images = const[]
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Name? name,
    Category? category,
    Price? price,
    String? entryDate,
    Stock? stock,
    String? description,
    List<String>? images,
  }) => ProductFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    name: name ?? this.name,
    category: category ?? this.category,
    price: price ?? this.price,
    entryDate: entryDate ?? this.entryDate,
    stock: stock ?? this.stock,
    description: description ?? this.description,
    images: images ?? this.images,
  );


}
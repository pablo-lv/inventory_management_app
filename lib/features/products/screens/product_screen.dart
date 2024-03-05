import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app/features/products/domain/domain.dart';
import 'package:inventory_management_app/features/products/screens/providers/product_form_provider.dart';
import 'package:inventory_management_app/features/products/screens/providers/product_provider.dart';
import 'package:inventory_management_app/features/shared/shared.dart';

class ProductScreen extends ConsumerWidget {
  final String productId;

  const ProductScreen({super.key, required this.productId});

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final productState = ref.watch(productProvider(productId));

    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child:Scaffold(
            appBar: AppBar(
              title: Text('Producto'),
              actions: [

              ],
            ),
            body: productState.isLoading ? const FullScreenLoader() : _ProductView(product: productState.product!),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (productState.product == null) return;

                ref.read(productFormProvider(productState.product!).notifier).onFormSubmit()
                    .then((value) {
                  if (!value) return;
                  showSnackBar(context, 'Product saved');
                });
              },
              child: const Icon(Icons.save_as_outlined),
            )
        )
    );
  }
}


class _ProductView extends ConsumerWidget {

  final Product product;

  const _ProductView({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final productForm = ref.watch(productFormProvider(product));

    final textStyles = Theme.of(context).textTheme;

    return ListView(
      children: [

        SizedBox(
          height: 250,
          width: 600,
          child: _ImageGallery(images: productForm.images ),
        ),

        const SizedBox( height: 10 ),
        Center(child: Text(
          productForm.name.value,
          style: textStyles.titleSmall,
          textAlign: TextAlign.center,
        )),
        const SizedBox( height: 10 ),
        _ProductInformation( product: product ),

      ],
    );
  }
}


class _ProductInformation extends ConsumerWidget {
  final Product product;
  const _ProductInformation({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref ) {

    final productForm = ref.watch(productFormProvider(product));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generales'),
          const SizedBox(height: 15 ),
          CustomProductField(
            isTopField: true,
            label: 'Nombre',
            initialValue: productForm.name.value,
            isEnabled: false,
          ),
          CustomProductField(
            isTopField: true,
            label: 'Category',
            initialValue: productForm.category.value,
            isEnabled: false,
          ),
          CustomProductField(
            isBottomField: true,
            label: 'Precio',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: productForm.price.value.toString(),
            isEnabled: false,
          ),

          const SizedBox(height: 15 ),
          const Text('Extras'),

          const SizedBox(height: 15 ),
          CustomProductField(
            isTopField: true,
            label: 'Existencias',
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            initialValue: productForm.stock.value.toString(),
            isEnabled: false,
          ),

          CustomProductField(
            maxLines: 6,
            label: 'Descripción',
            keyboardType: TextInputType.multiline,
            initialValue: product.description ,
            isEnabled: false,
          ),



          const SizedBox(height: 100 ),
        ],
      ),
    );
  }
}


class _ImageGallery extends StatelessWidget {
  final List<String> images;
  const _ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {

    return PageView(
      scrollDirection: Axis.horizontal,
      controller: PageController(
          viewportFraction: 0.7
      ),
      children: images.isEmpty
          ? [ ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Image.asset('assets/images/no-image.jpg', fit: BoxFit.cover ))
      ]
          : images.map((e){
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Image.network(e, fit: BoxFit.cover,),
        );
      }).toList(),
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:inventory_management_app/features/products/domain/domain.dart';
import 'package:inventory_management_app/features/products/infrastructure/infrastructure.dart';

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {

  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final productsRepository = ProductsRepositoryImpl(
    ProductsDatasourceImpl(accessToken: accessToken),
  );


  return productsRepository;
});
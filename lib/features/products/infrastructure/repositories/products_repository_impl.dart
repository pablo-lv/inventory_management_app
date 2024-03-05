

import 'package:inventory_management_app/features/products/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRepository {

  final ProductsDataSource dataSource;

  ProductsRepositoryImpl(this.dataSource);

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) {
    return dataSource.createUpdateProduct(productLike);
  }

  @override
  Future<Product> getProductById(String id) {
    return dataSource.getProductById(id);
  }

  @override
  Future<List<Product>> getProductByPage({int limit = 10, offset = 0}) {
    return dataSource.getProductByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Product>> searchProduct(String query) {
    return dataSource.searchProduct(query);
  }

}

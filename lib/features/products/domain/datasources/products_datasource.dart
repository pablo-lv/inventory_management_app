
import 'package:inventory_management_app/features/products/domain/entities/product.dart';

abstract class ProductsDataSource {
  Future<List<Product>> getProductByPage({int limit = 10, offset = 0});

  Future<Product> getProductById(String id);

  Future<List<Product>> searchProduct(String query);

  Future<Product> createUpdateProduct(Map<String, dynamic> productLike);
}
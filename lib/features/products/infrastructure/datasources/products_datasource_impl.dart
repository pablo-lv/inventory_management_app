import 'package:dio/dio.dart';
import 'package:inventory_management_app/config/config.dart';
import 'package:inventory_management_app/features/products/domain/domain.dart';
import 'package:inventory_management_app/features/products/infrastructure/errors/product_errors.dart';
import '../mappers/product_mapper.dart';

// import '../mappers/product_mapper.dart';


class ProductsDatasourceImpl extends ProductsDataSource {

  late final Dio _dio;
  final String accessToken;

  ProductsDatasourceImpl({
    required this.accessToken
  }) : _dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrl,
        headers: {
          'Authorization': 'Bearer $accessToken'
        }
      )
  );

  @override
  Future<Product> createUpdateProduct(Map<String, dynamic> productLike) async {
    try {

      final String? productId = productLike['id'];
      final String method = (productId == null) ? 'POST' : 'PATCH';
      final String url = (productId == null) ? '/products' : '/products/$productId';

      productLike.remove('id');

      final response = await _dio.request(
          url,
          data: productLike,
          options: Options(
              method: method
          )
      );

      final product = ProductMapper.jsonToEntity(response.data);
      return product;

    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      final response = await _dio.get('/api/products/$id');
      final product = ProductMapper.jsonToEntity(response.data);
      return product;
    } on DioError catch(e) {
      if (e.response!.statusCode == 404) throw ProductNotFound();
      throw Exception();
    } catch(e) {
      throw Exception();
    }
  }

  @override
  Future<List<Product>> getProductByPage({int limit = 10, offset = 0}) async{
    try {
      final response = await _dio.get(
          '/api/products/pageable?size=$limit&page=$offset');

      final List<Product> products = [];

      for (final product in response.data?? []) {
        products.add(ProductMapper.jsonToEntity(product));
      }

      return products;
    } on DioException catch(e) {
      throw Exception();
    } catch(e) {
      throw   Exception();
    }

  }

  @override
  Future<List<Product>> searchProduct(String query) {
    // TODO: implement searchProduct
    throw UnimplementedError();
  }




}
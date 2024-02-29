import 'package:dio/dio.dart';
import 'package:inventory_management_app/config/config.dart';
import 'package:inventory_management_app/features/auth/domain/domain.dart';
import 'package:inventory_management_app/features/auth/infrastructure/infrastructure.dart';

class AuthDataSourceImpl extends AuthDataSource {

  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    ),
  );

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(e.response?.data['message'] ?? 'Invalid credentials');
      }
      if (e.type == DioErrorType.connectionTimeout) {
        throw CustomError('Connection timeout, please try again');
      }
      throw CustomError('Something went wrong in dio request');

    } catch (e){
      throw CustomError('Something went wrong');
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    throw UnimplementedError();
  }

  @override
  Future<User> checkAuthStatus(String token) async{
    try {
      final response = await dio.get(
          '/auth/check-status',
          options: Options(
              headers: {
                'Authorization': 'Bearer $token',
              }));

      final user = UserMapper.userJsonToEntity(response.data);

      return user;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError('Invalid Token');
      }
      if (e.type == DioErrorType.connectionTimeout) {
        throw CustomError('Connection timeout, please try again');
      }
      throw CustomError('Something went wrong in dio request');

    } catch (e){
      throw CustomError('Something went wrong');
    }

  }

}
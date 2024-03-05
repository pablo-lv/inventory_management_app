import 'package:inventory_management_app/config/config.dart';
import 'package:inventory_management_app/features/auth/infrastructure/infrastructure.dart';
import 'package:inventory_management_app/features/products/domain/domain.dart';



class ProductMapper {


  static jsonToEntity( Map<String, dynamic> json ) => Product(
      id: json['id'],
      name: json['name'],
      price: double.parse( json['price'].toString() ),
      description: json['description'],
      category: json['category'],
      stock: json['stock'],
      entryDate: json['entryDate'],
      images: [],
      // user: UserMapper.userJsonToEntity( json['user'] )
  );


}
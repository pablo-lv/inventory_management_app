// Generated by https://quicktype.io
import 'package:inventory_management_app/features/auth/domain/domain.dart';

class Product {
  String id;
  String name;
  String description;
  double price;
  int stock;
  String category;
  String entryDate;
  List<String> images;
  User? user;


  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    required this.entryDate,
    required this.images,
    this.user,
  });

}
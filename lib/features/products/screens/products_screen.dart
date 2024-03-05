import 'package:flutter/material.dart';
import 'package:inventory_management_app/features/shared/shared.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Productos'),
          ),
          drawer: SideMenu(
            scaffoldKey: scaffoldKey,
            menuIndex: 1,
          ),
          body: Center(
            child: Text('Prducts Screen'),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:inventory_management_app/features/shared/shared.dart';


class SalesScreen extends StatelessWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Ventas'),
      ),
      drawer: SideMenu(scaffoldKey: scaffoldKey, menuIndex: 2,),
      body: Center(
        child: Text('Sales Screen'),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:inventory_management_app/features/shared/shared.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: Center(
        child: Text('Dashboard Screen'),
      ),
    );
  }
}
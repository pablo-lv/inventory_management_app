import 'package:flutter/material.dart';
import 'package:inventory_management_app/features/shared/shared.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      body: Container(
        color: Colors.indigo,
        height: height,
        width: width,
        child: Column(
        children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.indigo,
                // borderRadius: BorderRadius.circular(10),
              ),
              height: height * 0.15,
              width: width,
              child: Center(
                child: Icon(
                  Icons.dashboard,
                  size: 100,
                  color: Colors.white,
                )
              )
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                ),
              ),
              height: height * 0.746,
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    DashboardGridItem(title: 'Ventas Hoy', value: '\$500'),
                    DashboardGridItem(title: 'Ventas Semanal', value: '\$3000'),
                    DashboardGridItem(title: 'Venta Mensual', value: '\$12000'),
                    DashboardGridItem(title: 'Venta Anual', value: '\$150000'),
                  ],
                ),
              ),
            )
          ]
        )
      )
    );
  }
}


class DashboardItem extends StatelessWidget {
  final String title;
  final String value;

  DashboardItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}


class DashboardGridItem extends StatelessWidget {
  final String title;
  final String value;

  DashboardGridItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(fontSize: 24, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app/features/shared/shared.dart';



class SideMenu extends ConsumerStatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey;
  final int menuIndex;

  const SideMenu({
    super.key, 
    required this.scaffoldKey,
    this.menuIndex = 0
  });

  @override
  SideMenuState createState() => SideMenuState(this.menuIndex);
}

class MenuItem {
  final String link;

  MenuItem({required this.link});
}

class SideMenuState extends ConsumerState<SideMenu> {

  int navDrawerIndex = 0;

  final List<MenuItem> appMenuItems = [
    MenuItem(link: '/'),
    MenuItem(link: '/products'),
    MenuItem(link: '/sales'),
  ];

  SideMenuState(int menuIndex){
    navDrawerIndex = menuIndex;
  }

  @override
  Widget build(BuildContext context) {

    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    return NavigationDrawer(
      elevation: 1,
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        print(value);

        setState(() {
          navDrawerIndex = value;
        });
        final menuItem = appMenuItems[value];
        context.push( menuItem.link );
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [

        Padding(
          padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
          child: Text('Inventario App', style: textStyles.titleMedium ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
          child: Text('Manager', style: textStyles.titleSmall ),
        ),

        const NavigationDrawerDestination(
            icon: Icon( Icons.dashboard_outlined ),
            label: Text( 'Dashboard' ),
        ),
        const NavigationDrawerDestination(
          icon: Icon( Icons.store_outlined ),
          label: Text( 'Productos' ),

        ),
        const NavigationDrawerDestination(
          icon: Icon( Icons.money_outlined ),
          label: Text( 'Ventas' ),
        ),


        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),

        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('Otras opciones'),
        ),

        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomFilledButton(
            buttonColor: Color(0xFF5B62D0),
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
            text: 'Cerrar sesión'
          ),
        ),

      ]
    );
  }
}
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app/config/config.dart';
import 'package:inventory_management_app/config/router/app_router_notifier.dart';
import 'package:inventory_management_app/features/auth/auth.dart';
import 'package:inventory_management_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:inventory_management_app/features/dashboard/dashboard.dart';
import 'package:inventory_management_app/features/products/products.dart';
import 'package:inventory_management_app/features/sales/sales.dart';
import 'package:inventory_management_app/features/scanner/scanner.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
      initialLocation: '/splash',
      refreshListenable: goRouterNotifier,
      routes: [

        GoRoute(path: '/splash', builder: (context, state) => const CheckAuthStatusScreen()),

        ///* Auth Routes
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),

        ///* Dashboard
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        ///* Products
        GoRoute(
          path: '/products',
          builder: (context, state) => const ProductsScreen(),
        ),

        /// * Sales
        GoRoute(
          path: '/sales',
          builder: (context, state) => const SalesScreen(),
        ),

        GoRoute(
          path: '/scanner',
          builder: (context, state) => const ScannerScreen(),
        )

        // ///* Product Route
        // GoRoute(
        //   path: '/product/:id',
        //   builder: (context, state) => ProductScreen(productId: state.params['id'] ?? 'no-id'),
        // ),
      ],
      redirect: (context, state) {
        print(state.subloc);

        final isGoingTo = state.subloc;
        final authStatus = goRouterNotifier.authStatus;

        if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) return null;

        if (authStatus == AuthStatus.unauthenticated) {
          if (isGoingTo == '/login' || isGoingTo == '/register') return null;
          return '/login';
        }

        if (authStatus == AuthStatus.authenticated && isGoingTo == '/login' || isGoingTo == '/register' || isGoingTo == '/splash') return "/";

        return null;
      }
  );
});
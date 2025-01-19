import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/features/auth/models/user_model.dart';
import 'package:store_mg_fl/features/auth/providers/auth_provider.dart';

class ProductsScreen extends StatefulHookConsumerWidget {
  static const routeName = '/products';

  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  late Future<UserModel?> user;

  Future<UserModel?> handleUser() async {
    final userModel =
        await ref.read(authResponseProvider.notifier).getAuthenticatedUser();
    return userModel;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = handleUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: Center(
        child: FutureBuilder(
          future: user,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final user = snapshot.data;
                  return user != null ? Text('res: ${user.email}') : SizedBox();
                }
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/common/components/app_bar_user.dart';
import 'package:store_mg_fl/common/styles/styles.dart';

class ProductsScreen extends StatefulHookConsumerWidget {
  static const routeName = '/products';

  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), child: AppBarUser()),
      body: Container(
          decoration: BoxDecoration(
            gradient: ColorGradients().gradientBackground,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text('products screen'),
                ],
              )
            ],
          )),
    );
  }
}

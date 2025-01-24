import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/common/components/app_bar_user.dart';
import 'package:store_mg_fl/common/components/product_item.dart';
import 'package:store_mg_fl/common/styles/styles.dart';
import 'package:store_mg_fl/features/products/providers/product_provider.dart';

class ProductsScreen extends StatefulHookConsumerWidget {
  static const routeName = '/products';

  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(productProvider);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0), child: AppBarUser()),
      body: Container(
          decoration: BoxDecoration(
            gradient: ColorGradients().gradientBackground,
          ),
          child: Column(
            children: [
              Expanded(
                  child: SafeArea(
                      top: false,
                      bottom: false,
                      child: productList.when(
                        data: (products) {
                          return GridView.builder(
                            itemCount: products.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemBuilder: (context, index) =>
                                ProductItem(product: products[index]),
                          );
                        },
                        error: (error, stackTrace) {
                          return Text(error.toString());
                        },
                        loading: () => Center(
                          child: CircularProgressIndicator(),
                        ),
                      )))
            ],
          )),
    );
  }
}

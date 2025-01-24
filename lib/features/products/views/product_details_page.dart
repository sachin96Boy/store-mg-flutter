import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/common/styles/styles.dart';
import 'package:store_mg_fl/common/utils/apis.dart';
import 'package:store_mg_fl/features/products/models/product_model.dart';

class ProductDetailsPage extends HookConsumerWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Container(
        decoration:
            BoxDecoration(gradient: ColorGradients().gradientBackground),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Image.network(
                '${Api.pathUrl}${product.pictureURL}',
                width: orientation == Orientation.portrait ? 600 : 250,
                height: orientation == Orientation.portrait ? 400 : 200,
              ),
            ),
            Text(
              product.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'USD ${product.price}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(left: 32, bottom: 32, right: 32),
                  child: Text(product.description),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

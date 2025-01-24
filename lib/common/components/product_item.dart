import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/common/utils/apis.dart';
import 'package:store_mg_fl/features/products/models/product_model.dart';

class ProductItem extends HookConsumerWidget {
  final ProductModel product;
  const ProductItem({super.key, required this.product});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePath = '${Api.pathUrl}${product.pictureURL}';

    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black.withAlpha(200),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            product.name,
            style: TextStyle(fontSize: 20),
          ),
        ),
        subtitle: Text(
          "USD ${product.price}",
          style: TextStyle(fontSize: 14),
        ),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
      ),
      child: Image.network(
        imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}

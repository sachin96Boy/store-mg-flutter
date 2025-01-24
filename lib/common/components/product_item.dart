import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/common/utils/apis.dart';
import 'package:store_mg_fl/features/auth/providers/auth_provider.dart';
import 'package:store_mg_fl/features/products/models/product_model.dart';
import 'package:store_mg_fl/features/products/views/product_details_page.dart';

class ProductItem extends HookConsumerWidget {
  final ProductModel product;
  const ProductItem({super.key, required this.product});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePath = '${Api.pathUrl}${product.pictureURL}';
    final auth = ref.watch(authResponseProvider);

    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return ProductDetailsPage(product: product);
        },
      )),
      child: GridTile(
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
          trailing: auth.when(
            data: (auth) {
              final data = auth.user != null
                  ? IconButton(
                      onPressed: () {}, icon: Icon(Icons.shopping_cart))
                  : SizedBox();

              return data;
            },
            error: (error, stackTrace) {
              return Text(error.toString());
            },
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ),
        child: Hero(
          tag: product,
          child: Image.network(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

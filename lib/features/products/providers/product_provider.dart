import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/features/products/models/product_model.dart';
import 'package:store_mg_fl/features/products/repository/product_repository.dart';

class ProductNotifier extends AutoDisposeAsyncNotifier<List<ProductModel>> {
  @override
  Future<List<ProductModel>> build() {
    // TODO: implement build
    final productList = getProducts();
    return productList;
  }

  Future<List<ProductModel>> getProducts() async {
    final productList =
        await ref.read(productRepositoryProvider.notifier).getProductList();
    return productList;
  }
}

final productProvider =
    AutoDisposeAsyncNotifierProvider<ProductNotifier, List<ProductModel>>(() {
  return ProductNotifier();
});

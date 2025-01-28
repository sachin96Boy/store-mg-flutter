import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/features/cart/repository/cart_repository.dart';
import 'package:store_mg_fl/features/products/models/product_model.dart';

class CartNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<ProductModel>?, String> {
  @override
  Future<List<ProductModel>?> build(String arg) {
    // TODO: implement build
    final cartItem = getCartItems(arg);
    return cartItem;
  }

  Future<List<ProductModel>?> getCartItems(String cartId) async {
    final cartItem =
        await ref.read(cartRepositoryProvider.notifier).getCartItems(cartId);
    return cartItem;
  }

  Future<void> addCartItem(ProductModel updatedCartData, String cartId) async {
    state = AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await ref
          .read(cartRepositoryProvider.notifier)
          .addCartItems(updatedCartData, cartId);

      final newResponse = await getCartItems(cartId);
      return newResponse;
    });
  }
}

final cartProvider = AutoDisposeFamilyAsyncNotifierProvider<CartNotifier,
    List<ProductModel>?, String>(() {
  return CartNotifier();
});

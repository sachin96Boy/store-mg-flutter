import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/features/cart/models/cart_model.dart';
import 'package:store_mg_fl/features/cart/repository/cart_repository.dart';

class CartNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<CartModel>?, String> {
  @override
  Future<List<CartModel>?> build(String arg) {
    // TODO: implement build
    final cartItem = getCartItems(arg);
    return cartItem;
  }

  Future<List<CartModel>?> getCartItems(String userId) async {
    final cartItem =
        await ref.read(cartRepositoryProvider.notifier).getCartItems(userId);
    return cartItem;
  }

  Future<void> addCartItem(CartModel updatedCartData, String userId) async {
    state = AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      await ref
          .read(cartRepositoryProvider.notifier)
          .addCartItems(updatedCartData, userId);

      final newResponse = await getCartItems(userId);
      return newResponse;
    });
  }
}

final cartProvider = AutoDisposeFamilyAsyncNotifierProvider<CartNotifier,
    List<CartModel>?, String>(() {
  return CartNotifier();
});

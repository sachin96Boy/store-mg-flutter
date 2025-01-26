import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/common/utils/api_interceptor.dart';
import 'package:store_mg_fl/common/utils/apis.dart';
import 'package:store_mg_fl/features/cart/models/cart_model.dart';

class CartRepository extends AutoDisposeNotifier<AsyncValue<dynamic>> {
  @override
  AsyncValue build() {
    // TODO: implement build
    return AsyncValue.data(null);
  }

  Future<CartModel?> getCartItems(String userId) async {
    try {
      final client =
          ref.read(apiInterceptorProvider.notifier).getClientInterceptor();

      final cartProductsUrl = Uri.parse('${Api.carts}&userId=$userId');

      final response = await client.get(cartProductsUrl);

      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final body = responseBody['data'] as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final cartProducts = CartModel.fromJson(body);

        return cartProducts;
      }
      return null;
    } on Exception catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<void> addCartItems(CartModel updatedCartData, String userId) async {
    try {
      final client =
          ref.read(apiInterceptorProvider.notifier).getClientInterceptor();

      final cartProductsUrl = Uri.parse('${Api.carts}&userId=$userId');

      final response = await client.patch(
        cartProductsUrl,
        body: updatedCartData.toJson(),
      );
    } on Exception catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}

final cartRepositoryProvider =
    AutoDisposeNotifierProvider<CartRepository, AsyncValue<dynamic>>(() {
  return CartRepository();
});

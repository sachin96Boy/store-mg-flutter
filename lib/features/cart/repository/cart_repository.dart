import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/common/utils/api_interceptor.dart';
import 'package:store_mg_fl/common/utils/apis.dart';
import 'package:store_mg_fl/features/products/models/product_model.dart';

class CartRepository extends AutoDisposeNotifier<AsyncValue<dynamic>> {
  @override
  AsyncValue build() {
    // TODO: implement build
    return AsyncValue.data(null);
  }

  Future<List<ProductModel>?> getCartItems(String cartId) async {
    try {
      final client =
          ref.read(apiInterceptorProvider.notifier).getClientInterceptor();

      final cartProductsUrl = Uri.parse('${Api.carts}/$cartId?populate=*');

      final response = await client.get(cartProductsUrl);

      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final body =
          responseBody['data']['products'] as List<Map<String, dynamic>>;

      if (response.statusCode == 200) {
        final cartitemsList = body.map((element) {
          final cartProducts = ProductModel.fromJson(element);
          return cartProducts;
        }).toList();

        return cartitemsList;
      }
      return null;
    } on Exception catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<void> addCartItems(ProductModel updatedCartData, String cartId) async {
    try {
      final client =
          ref.read(apiInterceptorProvider.notifier).getClientInterceptor();

      final cartProductsUrl = Uri.parse('${Api.carts}/$cartId');

      await client.put(
        cartProductsUrl,
        body: {
          "data": {
            "products": {
              "connect": [updatedCartData.toJson()]
            }
          }
        },
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

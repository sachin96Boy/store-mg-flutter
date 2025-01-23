import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/common/utils/api_interceptor.dart';
import 'package:store_mg_fl/common/utils/apis.dart';
import 'package:store_mg_fl/features/products/models/product_model.dart';

class ProductRepository extends AutoDisposeNotifier<AsyncValue<dynamic>> {
  @override
  AsyncValue build() {
    // TODO: implement build
    return AsyncValue.data(null);
  }

  Future<List<ProductModel>> getProductList() async {
    try {
      final client =
          ref.read(apiInterceptorProvider.notifier).getClientInterceptor();

      final productsUrl = Uri.parse(Api.products);

      final response = await client.get(productsUrl);

      final responseBody = json.decode(response.body) as Map<String, dynamic>;
      final body = responseBody['data'] as List<dynamic>;
      print(body);
      if (response.statusCode == 200) {
        final productList = body.map((element) {
          final product = ProductModel.fromJson(element);
          return product;
        }).toList();

        return productList;
      }
      return [];
    } on Exception catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }
}

final productRepositoryProvider =
    AutoDisposeNotifierProvider<ProductRepository, AsyncValue<dynamic>>(() {
  return ProductRepository();
});

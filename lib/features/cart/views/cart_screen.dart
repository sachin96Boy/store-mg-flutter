import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/common/components/product_item.dart';
import 'package:store_mg_fl/features/cart/providers/cart_provider.dart';
import 'package:store_mg_fl/features/products/models/product_model.dart';

class CartScreen extends StatefulHookConsumerWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  handleCartItems(
      AsyncValue<List<ProductModel>?> data, Orientation orientation) {
    return data.when(
      data: (data) {
        if (data != null) {
          final cartItemsList = data;
          return GridView.builder(
            itemCount: cartItemsList.length,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                crossAxisCount: orientation == Orientation.portrait ? 2 : 3),
            itemBuilder: (context, index) => ProductItem(
              product: cartItemsList[index],
            ),
          );
        }
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final orientation = MediaQuery.of(context).orientation;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart Page'),
          bottom: TabBar(
            labelColor: Colors.deepOrange.shade600,
            unselectedLabelColor: Colors.deepOrange.shade900,
            tabs: [
              Tab(
                icon: Icon(Icons.shopping_cart),
              ),
              Tab(
                icon: Icon(Icons.credit_card),
              ),
              Tab(
                icon: Icon(Icons.receipt),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          handleCartItems(cartItems, orientation),
          Text('Shopping Card'),
          Text('Receipt')
        ]),
      ),
    );
  }
}

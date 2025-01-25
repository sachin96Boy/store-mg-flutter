import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartScreen extends StatefulHookConsumerWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  Widget build(BuildContext context) {
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
          Text('Credit Card'),
          Text('Shopping Card'),
          Text('Receipt')
        ]),
      ),
    );
  }
}

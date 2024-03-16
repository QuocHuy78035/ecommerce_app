import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/cart_provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider =
    Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: cartProvider.getCartItem().length,
        itemBuilder: (context, index) {
          final cartData =
          cartProvider.getCartItem().values.toList()[index];
          return Card(
            child: SizedBox(
              height: 170,
              child: Row(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(cartData.imageUrl[0]),
                  ),
                  Column(
                    children: [
                      Text(cartData.productName),
                      Text(
                        cartData.price.toString(),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: Text(cartData.productSize),
                      ),

                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
            color: Colors.yellow.shade900,
            borderRadius: BorderRadius.circular(10)
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: const Center(
          child: Text("Place Order"),
        ),
      ),
    );
  }
}

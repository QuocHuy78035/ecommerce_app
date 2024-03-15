import 'package:ecomerce_app/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade900,
        title: const Text("Cart Screen"),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: cartProvider.getCartItem().length,
        itemBuilder: (context, index) {
          final cartData = cartProvider.getCartItem().values.toList()[index];
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
                      Container(
                        height: 50,
                        width: 120,
                        color: Colors.yellow.shade900,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.remove),
                            ),
                            Text(cartData.quantity.toString()),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),

      // body: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 10),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       const Text(
      //         "Your Shopping Cart Is Empty",
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold,
      //           letterSpacing: 4,
      //         ),
      //       ),
      //       SizedBox(
      //         width: MediaQuery.of(context).size.width,
      //         child: ElevatedButton(
      //           style: ElevatedButton.styleFrom(
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(10)),
      //               backgroundColor: Colors.yellow.shade900),
      //           onPressed: () {},
      //           child: const Text(
      //             "CONTINUE SHOPPING",
      //             style: TextStyle(
      //               fontSize: 16,
      //               letterSpacing: 4,
      //               color: Colors.white
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}

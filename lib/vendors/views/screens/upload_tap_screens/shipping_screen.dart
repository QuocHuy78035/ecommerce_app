import 'package:ecomerce_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  bool _chargeShipping = false;

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Charge Shipping",
                style: TextStyle(
                  letterSpacing: 4,
                  fontSize: 18,
                ),
              ),
            ),
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: _chargeShipping,
              onChanged: (bool? value) {
                setState(
                  () {
                    _chargeShipping = value!;
                    productProvider.getFormData(
                        chargeShipping: _chargeShipping);
                  },
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        if (_chargeShipping)
          Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              onChanged: (value) {
                productProvider.getFormData(
                  shippingCharge: int.parse(value),
                );
              },
              decoration: const InputDecoration(hintText: "Shipping Charge"),
            ),
          )
      ],
    );
  }
}

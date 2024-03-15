import 'package:ecomerce_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AttributeScreen extends StatefulWidget {
  const AttributeScreen({super.key});

  @override
  State<AttributeScreen> createState() => _AttributeScreenState();
}

class _AttributeScreenState extends State<AttributeScreen> {
  bool _entered = false;
  List<String> _sizeList = [];
  bool _isSave = false;
  final TextEditingController _sizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            onChanged: (value) {
              productProvider.getFormData(brandName: value);
            },
            decoration: const InputDecoration(hintText: "Brand"),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: TextFormField(
                  controller: _sizeController,
                  onChanged: (value) {
                    setState(() {
                      _entered = true;
                    });
                  },
                  decoration: const InputDecoration(hintText: "Size"),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              _entered == true
                  ? ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _sizeList.add(_sizeController.text);
                          productProvider.getFormData(listSize: _sizeList);
                        });
                      },
                      child: const Text("Add"),
                    )
                  : Container()
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          if (_sizeList.isNotEmpty)
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _sizeList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        setState(() {
                          _sizeList.removeAt(index);
                          productProvider.getFormData(listSize: _sizeList);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.yellow.shade800,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(_sizeList[index]),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (_sizeList.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                productProvider.getFormData(listSize: _sizeList);
                setState(() {
                  _isSave = true;
                });
              },
              child: _isSave == true ? Text("Saved") : Text("Save"),
            )
        ],
      ),
    );
  }
}

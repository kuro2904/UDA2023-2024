import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/data/OrderDetail.dart';
import 'package:food_app/data/client_state.dart';
import 'package:food_app/data/product.dart';
import 'package:food_app/utils/dialog.dart';

import '../../constants/backend_config.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.product, this.selectedTopping, this.inCartId});

  final Product product;
  final List<int>? selectedTopping;
  final int? inCartId;

  @override
  State<StatefulWidget> createState() {
    return _ProductDetailState();
  }

}

class _ProductDetailState extends State<ProductDetail> {

  final TextEditingController _quantity = TextEditingController();
  late Future<List<Map<String, dynamic>>> _toppings;
  bool updateMode = false;
  List<int> selectedToppings = [];


  @override
  void initState() {
    super.initState();
    _toppings = Product.fetchTopping(widget.product.id);
    if (widget.selectedTopping != null && widget.inCartId != null) {
      updateMode = true;
      selectedToppings = widget.selectedTopping!;
      _quantity.text = ClientState().cart[widget.inCartId!].quantity.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              child: Image.network(
                BackEndConfig.fetchImageString + widget.product.imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.product.price,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.product.description,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      TextField(
                        controller: _quantity,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Quantity',
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.singleLineFormatter,
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      FutureBuilder(
                        future: _toppings,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                            return const Text('Sản phẩm này không có topping');
                          } else {
                            return SizedBox(
                              width: 500,
                              height: 400,
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return CheckboxListTile(
                                    title: Text("${snapshot.data![index]['name']} (${snapshot.data![index]['price']} vnd)"),
                                    value: selectedToppings.contains(snapshot.data![index]['id']),
                                    onChanged: (selectedValue) {
                                      setState(() {
                                        if (selectedValue!) {
                                          selectedToppings.add(snapshot.data![index]['id']);
                                        } else {
                                          selectedToppings.remove(snapshot.data![index]['id']);
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: updateMode ? _updateCart : _addToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: updateMode ? const Text(
                          'Change',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ) : const Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (updateMode)
                      ElevatedButton(
                        onPressed: _removeFromCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Remove',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _removeFromCart() async {
    if (await confirm(context, title: const Text("Bạn chắc không?"))) {
      ClientState().cart.removeAt(widget.inCartId!);
      Navigator.of(context).pop();
    }
  }

  void _addToCart() async {
    int? quantity = int.tryParse(_quantity.text);
    if (quantity == null) {
      showAlertDialog(context, "Số lượng không được để trống", "Lỗi!");
      return;
    }
    final duplicated = ClientState().getCartDuplicate(ClientState().cart.length, widget.product.id, selectedToppings);
    int merge = -1;
    if (duplicated.isNotEmpty) {
      merge = await _mergeDialog(duplicated);
    }
    ClientState().addToCart(
      OrderDetail(quantity: quantity, product: widget.product, toppings: selectedToppings),
      mergeWith: merge == -1 ? null : merge
    );
    Navigator.of(context).pop();
  }

  void _updateCart() async {
    int? quantity = int.tryParse(_quantity.text);
    if (quantity == null) {
      showAlertDialog(context, "Số lượng không được để trống", "Lỗi!");
      return;
    }
    final duplicated = ClientState().getCartDuplicate(widget.inCartId!, widget.product.id, selectedToppings);
    int merge = -1;
    if (duplicated.isNotEmpty) {
      merge = await _mergeDialog(duplicated);
    }
    if (merge != -1) {
      ClientState().addToCart(
        OrderDetail(quantity: quantity, product: widget.product, toppings: selectedToppings),
        mergeWith: merge,
        current: widget.inCartId!
      );
    } else {
      ClientState().updateCart(widget.inCartId!, OrderDetail(quantity: quantity, product: widget.product, toppings: selectedToppings));
    }
    Navigator.of(context).pop();
  }

  Future<int> _mergeDialog(List<int> duplicatedList) async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("Chọn mục bạn muốn gộp vào"),
          children: [
            ListTile(
              title: const Text("Không cảm ơn"),
              onTap: () {
                Navigator.pop(context, -1);
              },
            ),
            ...duplicatedList.map((e) {
              return ListTile(
                title: Text("${ClientState().cart[e].product.name}: ${ClientState().cart[e].quantity}"),
                onTap: () {
                  Navigator.pop(context, e);
                },
              );
            }),
          ],
        );
      }
    );
    return result;
  }
}
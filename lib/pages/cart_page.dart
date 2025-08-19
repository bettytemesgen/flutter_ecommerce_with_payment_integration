import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart';
import '../models/shoe.dart';
import '../pages/payment_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          // 🧾 Cart items list
          Expanded(
            child: cart.usercart.isEmpty
                ? const Center(
                    child: Text(
                      "Your cart is empty",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.usercart.length,
                    itemBuilder: (context, index) {
                      final Shoe shoe = cart.usercart[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: Image.asset(shoe.impagepath, width: 50),
                            title: Text(shoe.name),
                            subtitle: Text('\$${shoe.price}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                cart.removeFromCart(shoe);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // 💰 Total + Checkout
          if (cart.usercart.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 🧮 Total Price
                  Text(
                    'Total: \$${_calculateTotal(cart.usercart)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),

                  // ✅ Checkout Button → Go to Payment
                  ElevatedButton(
                    onPressed: () {
                      double totalAmount = _calculateTotalValue(cart.usercart);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PaymentPage(amount: totalAmount),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      "Checkout & Pay",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // 🧮 Helper to calculate total as String for display
  String _calculateTotal(List<Shoe> cartItems) {
    double total = _calculateTotalValue(cartItems);
    return total.toStringAsFixed(2);
  }

  // 🧮 Helper to calculate total as double for payment
  double _calculateTotalValue(List<Shoe> cartItems) {
    double total = 0;
    for (var shoe in cartItems) {
      total += double.tryParse(shoe.price) ?? 0;
    }
    return total;
  }
}

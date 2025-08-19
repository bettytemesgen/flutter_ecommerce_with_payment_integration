import 'package:flutter/material.dart';
import 'package:projectone/components/shoe_tile.dart'; // Custom shoe tile widget
import 'package:projectone/models/cart.dart';
import 'package:projectone/models/shoe.dart';
import 'package:provider/provider.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  // Add shoe to the cart
  void addShoeToCart(Shoe shoe) {
    Provider.of<Cart>(context, listen: false).addItemsToCart(shoe);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Successfully added "),
        content: const Text("Check your cart"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, value, child) => Column(
        children: [
          const SizedBox(height: 20), // spacing from top
          // 🔍 Minimized Search Bar with Icon
          SizedBox(
            height: 45,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: "Search",
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
                style: TextStyle(color: Colors.black, fontSize: 14),
                cursorColor: Colors.blue,
              ),
            ),
          ),

          // ✈️ Tagline
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text(
              "Everyone Flies..Some fly longer than other",
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          // 🔥 Hot Picks Title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  "Hot Picks",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text("See all", style: TextStyle(color: Colors.blue)),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 👟 List of shoes for sale
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Shoe shoe = value.getShoeList()[index];
                return ShoeTile(shoe: shoe, onTap: () => addShoeToCart(shoe));
              },
            ),
          ),

          // Divider
          const Padding(
            padding: EdgeInsets.only(top: 25.0, left: 25, right: 25),
            // child: Divider(color: Color.fromARGB(255, 102, 27, 27)),
          ),
        ],
      ),
    );
  }
}

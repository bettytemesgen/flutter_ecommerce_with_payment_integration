import 'package:flutter/material.dart';
import 'package:projectone/models/shoe.dart';

class Cart extends ChangeNotifier {
  //Llist of shoes for sale

  List<Shoe> shoeShop = [
    Shoe(
      name: "Zoom Freak",
      price: "234",
      description: "nice and waling shoes",
      impagepath: "assets/images/new-shoe.png",
    ),
    Shoe(
      name: "Jordan",
      price: "234",
      description: "nice and waling shoes",
      impagepath: "assets/images/shoe-one.jpg",
    ),
    Shoe(
      name: "Zoom Freak",
      price: "234",
      description: "nice and waling shoes",
      impagepath: "assets/images/new-shoe.png",
    ),
    Shoe(
      name: "Jordan",
      price: "234",
      description: "nice and waling shoes",
      impagepath: "assets/images/shoe-one.jpg",
    ),
  ];

  //list ot items in user cart
  List<Shoe> usercart = [];

  //get list of shoes for sale
  List<Shoe> getShoeList() {
    return shoeShop;
  }

  //get cart
  List<Shoe> getUserCart() {
    return usercart;
  }

  //add items to cart
  void addItemsToCart(Shoe shoe) {
    usercart.add(shoe);
    notifyListeners();
  }

  //remove items from cart
  // void removeItemFromCart(Shoe shoe) {
  //   usercart.remove(Shoe);
  //   notifyListeners();
  // }

  void removeFromCart(Shoe shoe) {
    usercart.remove(shoe);
    notifyListeners();
  }
}

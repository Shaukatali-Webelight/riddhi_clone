// Example code with a potential bug in it
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  final int price = 100;

  // The issue here is the 'taxRate' should be a double, but it is defined as an int.
  final taxRate = 0.15; // This is okay as a double

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bug Bot Example"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            final total = calculateTotal(price, taxRate);
            print("Total price: $total");
          },
          child: Text("Calculate Total"),
        ),
      ),
    );
  }

  double calculateTotal(int price, double taxRate) {
    return price + price * taxRate;
  }
}

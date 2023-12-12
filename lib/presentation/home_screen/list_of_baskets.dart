import 'package:basket_of_fruit/presentation/components/basket_widget.dart';
import 'package:flutter/material.dart';

class ListOfBaskets extends StatelessWidget {
  const ListOfBaskets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BasketWidget(
          color: Colors.purple,
          number: 1,
          fruits: 4,
        ),
        BasketWidget(
          color: Colors.green,
          number: 2,
          fruits: 6,
        ),
        BasketWidget(
          color: Colors.blue,
          number: 3,
          fruits: 9,
        ),
      ],
    );
  }
}

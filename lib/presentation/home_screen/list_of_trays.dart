import 'package:basket_of_fruit/common/utils/common_functions.dart';
import 'package:basket_of_fruit/presentation/components/fruit_tray_widget.dart';
import 'package:basket_of_fruit/state/tray_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListOfTrays extends StatelessWidget {
  const ListOfTrays({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CommonFunctions.deviceHeight(context) * 0.7,
      child: ListView.builder(
        shrinkWrap: true,
        // physics: NeverScrollableScrollPhysics(),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Consumer(builder: (context, ref, _) {
            final tray = ref.watch(trayStateProvider)[index];
            return FruitTrayItem(
              index: index,
              banana: tray.bananas,
              apples: tray.apples,
              mango: tray.mangoes,
            );
          });
        },
      ),
    );
  }
}
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double pctOfTotal;
  ChartBar(this.label, this.spendingAmount, this.pctOfTotal);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrains) {
        return Column(
          children: [
            Container(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(
                child: Text('৳${spendingAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(height: constrains.maxHeight * .05),
            Container(
              height: constrains.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: pctOfTotal.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constrains.maxHeight * .05),
            Container(
              height: constrains.maxHeight * .15,
              child: FittedBox(
                child: Text(
                  label
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

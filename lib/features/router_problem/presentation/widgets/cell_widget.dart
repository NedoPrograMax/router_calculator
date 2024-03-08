import 'package:flutter/material.dart';
import 'package:router/features/router_problem/data/models/field_cell.dart';

class CellWidget extends StatelessWidget {
  final FieldCell cell;
  final Color color;
  const CellWidget({
    super.key,
    required this.cell,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: color,
      ),
      alignment: Alignment.center,
      child: Text(
        cell.toPathFragment(
          withArrowNext: false,
        ),
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: color == Colors.black ? Colors.white : null,
        ),
      ),
    );
  }
}

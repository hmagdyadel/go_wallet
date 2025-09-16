import 'package:flutter/material.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/drag_handle.dart';
import 'past_transactions.dart';

class DraggableSheet extends StatelessWidget {
  const DraggableSheet({
    super.key,
    required DraggableScrollableController draggableController,
    required this.initialSize,
  }) : _draggableController = draggableController;

  final DraggableScrollableController _draggableController;
  final double initialSize;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _draggableController,
      initialChildSize: initialSize,
      minChildSize: 0.2,
      maxChildSize: 0.98,
      snap: true,
      snapSizes: [initialSize, 0.6, 0.95],
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(containerRadius),
              topRight: Radius.circular(containerRadius),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Drag handle
              DragHandle(),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: EdgeInsets.symmetric(horizontal: edge),
                  child: PastTransactions(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

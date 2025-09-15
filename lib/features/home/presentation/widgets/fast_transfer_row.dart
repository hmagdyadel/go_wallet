import 'package:flutter/material.dart';

import '../../../../core/constants/dimensions_constants.dart';
import 'user_avatar_card.dart';

class FastTransferRow extends StatelessWidget {
  final List<String> names;

  const FastTransferRow({super.key, required this.names});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(names.length, (index) {
          final name = names[index];

          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? edge : edge * 0.2, // first item gets left edge
              right: index == names.length - 1
                  ? edge
                  : edge * 0.2, // last item gets right edge
            ),
            child: UserAvatarCard(name: name),
          );
        }),
      ),
    );
  }
}

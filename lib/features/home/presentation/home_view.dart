import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/dimensions_constants.dart';
import '../../../core/utils/app_color.dart';
import '../../../core/widgets/title_text.dart';
import 'widgets/draggable_sheet.dart';
import 'widgets/fast_transfer_row.dart';
import 'widgets/home_appbar.dart';
import 'widgets/quick_actions_row.dart';
import 'widgets/wallet_cart.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late DraggableScrollableController _draggableController;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  final GlobalKey _topContentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _draggableController = DraggableScrollableController();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _draggableController.addListener(_onDragUpdate);
  }

  void _onDragUpdate() {
    if (_draggableController.isAttached) {
      final currentSize = _draggableController.size;
      // Scale starts when sheet is expanded beyond 50%
      if (currentSize > 0.5) {
        final progress = ((currentSize - 0.5) / 0.5).clamp(0.0, 1.0);
        _scaleController.value = progress;
      } else {
        _scaleController.value = 0.0;
      }
    }
  }

  double _calculateInitialChildSize(BuildContext context) {
    // Get screen height
    final screenHeight = MediaQuery.of(context).size.height;

    // Estimate the height of top content
    // This is an approximation - you might need to adjust based on your actual content
    final appBarHeight = AppBar().preferredSize.height;
    final walletCartHeight = 200.0; // Estimate based on your WalletCart widget
    final quickActionsHeight =
        80.0; // Estimate based on your QuickActionsRow widget
    final titleHeight = 30.0; // Estimate for title
    final fastTransferHeight =
        100.0; // Estimate based on your FastTransferRow widget
    final padding = edge * 4; // Total padding

    final topContentHeight =
        appBarHeight +
        walletCartHeight +
        quickActionsHeight +
        titleHeight +
        fastTransferHeight +
        padding;

    // Calculate what percentage of screen height should be left for the sheet
    final availableHeight = screenHeight - topContentHeight;
    final desiredSheetHeight =
        availableHeight * 0.8; // Use 80% of available space

    // Convert to percentage of screen height
    final initialChildSize = (desiredSheetHeight / screenHeight).clamp(
      0.2,
      0.4,
    );

    return initialChildSize;
  }

  @override
  void dispose() {
    _draggableController.removeListener(_onDragUpdate);
    _draggableController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context, userName: "Haitham Magdy"),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final initialSize = _calculateInitialChildSize(context);

          return Stack(
            children: [
              // Background content that will zoom out
              AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      key: _topContentKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: edge,
                              left: edge,
                              top: edge,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                WalletCart(),
                                SizedBox(height: edge * 0.9),
                              ],
                            ),
                          ),
                          QuickActionsRow(),
                          SizedBox(height: edge * 0.7),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: edge),
                            child: Row(
                              children: [
                                TitleText(
                                  text: "fast_transfer".tr(),
                                  fontSize: 20,
                                  color: AppColor.blue900,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: edge * 0.6),
                          FastTransferRow(
                            names: [
                              "Haitham Magdy",
                              "Mina Magdy",
                              "Tom Kelly",
                              "John Doe",
                              "Alice Brown",
                              "Laura Adams",
                              "Alice Nguyen",
                              "Mina Nady",
                            ],
                          ),
                          // Reserve space for the draggable sheet
                          SizedBox(height: constraints.maxHeight * initialSize),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Draggable bottom sheet
              DraggableSheet(
                draggableController: _draggableController,
                initialSize: initialSize,
              ),
            ],
          );
        },
      ),
    );
  }
}

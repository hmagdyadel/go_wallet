import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_wallet/core/helpers/extensions.dart';
import 'package:go_wallet/core/widgets/custom_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/constants/dimensions_constants.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/utils/app_color.dart';
import '../../../../core/widgets/drag_handle.dart';
import '../../../../core/widgets/subtitle_text.dart';
import '../../../../core/widgets/title_text.dart';
import '../../../../generated/assets.dart';

class QrCodeBottomSheet extends StatefulWidget {
  const QrCodeBottomSheet({super.key});

  @override
  State<QrCodeBottomSheet> createState() => _QrCodeBottomSheetState();
}

class _QrCodeBottomSheetState extends State<QrCodeBottomSheet> {
  final GlobalKey _qrKey = GlobalKey();
  bool _isSharing = false;

  Future<void> _shareQrCode() async {
    try {
      setState(() {
        _isSharing = true;
      });

      // Capture the QR code as an image
      RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Get temporary directory to save the image
      final Directory tempDir = await getTemporaryDirectory();
      final String tempPath = tempDir.path;
      final File file = File('$tempPath/qr_code.png');
      await file.writeAsBytes(pngBytes);

      // Share the image
      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path)],
          text: userCode, // You can add this translation
          subject: 'own_qr_code'.tr(),
        ),
      );
    } catch (e) {
      // Handle error - you might want to show a snack bar or dialog
      if (mounted) {
        context.showErrorToast("qr_code_sharing_error".tr());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSharing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: edge),
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DragHandle(),
          SizedBox(height: edge * 2),
          TitleText(
            text: "own_qr_code".tr(),
            color: AppColor.blue900,
            fontSize: 20,
          ),
          SizedBox(height: edge),
          RepaintBoundary(
            key: _qrKey,
            child: Container(
              width: 270,
              height: 220,
              padding: EdgeInsets.symmetric(horizontal: edge),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(containerRadius),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(containerRadius),
                child: QrImageView(
                  data: userCode,
                  version: QrVersions.auto,
                  backgroundColor: Colors.white,
                  embeddedImage: AssetImage(Assets.imagesQrLogo),
                  embeddedImageStyle: const QrEmbeddedImageStyle(
                    size: Size(70, 70),
                  ),
                  eyeStyle: QrEyeStyle(
                    eyeShape: QrEyeShape.square,
                    color: AppColor.primaryColor,
                  ),
                  errorCorrectionLevel: QrErrorCorrectLevel.H,
                  dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.square,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: edge * 0.2),
          SubTitleText(text: userCode, color: AppColor.blue900, fontSize: 16),
          SizedBox(height: edge * 0.4),
          SubTitleText(
            text: "own_qr_code_hint".tr(),
            color: AppColor.blue900,
            fontSize: 16,
          ),
          SizedBox(height: edge * 1.6),
          CustomButton.normal(
            text:"share_qr_code".tr(),
            onPressed: _isSharing ? null : _shareQrCode,
          ),
          SizedBox(height: edge * 2),
        ],
      ),
    );
  }
}

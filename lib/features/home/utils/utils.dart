import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/global/localization/app_localization.dart';
import '../../../core/integrated_library/bottom_navigation_bar/tab_item.dart';
import '../../../core/utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

List<TabItem> get getBottomNavigationBarIList => [
      TabItem(iconPath: AppAssets.mapSvg, title: tr(AppConstants.map)),
      TabItem(iconPath: AppAssets.familySvg, title: tr(AppConstants.family)),
    ];

enum BranchStatus {
  online,
  offline,
}

Future<BitmapDescriptor> getMarkerIcon(
    String imagePath, Size size, String name) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);

  final Radius radius = Radius.circular(size.width / 2);

  final Paint tagPaint = Paint()..color = ThemeColorLight.pinkColor;
  final double tagWidth = 40.0;

  final Paint shadowPaint = Paint()..color = ThemeColorLight.pinkWhiteColor;
  final double shadowWidth = 15.0;

  final Paint borderPaint = Paint()..color = Colors.white;
  final double borderWidth = 3.0;

  final double imageOffset = shadowWidth + borderWidth;

  // Add shadow circle
  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      shadowPaint);

  // Add border circle
  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(shadowWidth, shadowWidth, size.width - (shadowWidth * 2),
            size.height - (shadowWidth * 2)),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      borderPaint);

  // Add tag circle
  /*  canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTWH(size.width - tagWidth, -10.0, tagWidth, tagWidth),
        topLeft: radius,
        topRight: radius,
        bottomLeft: radius,
        bottomRight: radius,
      ),
      tagPaint); */

  // Add tag text
  TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
  textPainter.text = TextSpan(
    text: name,
    style: TextStyle(
        fontSize: 30.0,
        color: Colors.white,
        backgroundColor: ThemeColorLight.pinkColor),
  );

  textPainter.layout();
  textPainter.paint(canvas, Offset(-2.0, -6.0));

  // Oval for the image
  Rect oval = Rect.fromLTWH(imageOffset, imageOffset,
      size.width - (imageOffset * 2), size.height - (imageOffset * 2));

  // Add path for oval image
  canvas.clipPath(Path()..addOval(oval));

  // Add image
  ui.Image image = await getImageFromPath(
      imagePath, ""); // Alternatively use your own method to get the image
  paintImage(canvas: canvas, image: image, rect: oval, fit: BoxFit.fitWidth);

  // Convert canvas to image
  final ui.Image markerAsImage = await pictureRecorder
      .endRecording()
      .toImage(size.width.toInt(), size.height.toInt());

  // Convert image to bytes
  final ByteData? byteData =
      await markerAsImage.toByteData(format: ui.ImageByteFormat.png);
  final Uint8List uint8List = byteData!.buffer.asUint8List();

  return BitmapDescriptor.fromBytes(uint8List);
}

Future<ui.Image> getImageFromPath(String imagePath, String accessToken) async {
  Uint8List profileIcons =
       await getBytesFromAsset('assets/images/png/profile.png', 150);
  var headers = {
    'auth-token':
        'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2RldmVsb3BtZW50LnV0dXJuc29mdHdhcmUuY29tL2FwaS91c2Vycy9sb2dpbiIsImlhdCI6MTY5MTIyNTQ2NywiZXhwIjo1MjkxMjI1NDY3LCJuYmYiOjE2OTEyMjU0NjcsImp0aSI6InkzejJ1b1lNdzRGenFGbGQiLCJzdWIiOiI4IiwicHJ2IjoiZjY0ZDQ4YTZjZWM3YmRmYTdmYmY4OTk0NTRiNDg4YjNlNDYyNTIwYSJ9.-Xu58ocIFN6_nJoqxE4hB7pD8uvgghfxH3IFLc_l-3I',
    'Authorization':
        'Basic YWJkZWxoYW1pZC5haG1lZC5hYmRvQGdtYWlsLmNvbTpBYmRvQEJvb2R5QDI1MjkwMA=='
  };

  var response = await http.Client().get(
      Uri.parse(
          'https://development.uturnsoftware.com/api/members/GetMemberProfile?api_password=COLgGMo6KEiaY3cFhysY920Kd33SHmGG5cXD&imageUrl=Qv9dYrA8yYdfjMTqLvxEbreH7SM21692035394.jpg'),
      headers: headers);

  Uint8List imageBytes = response.bodyBytes;

  final Completer<ui.Image> completer = Completer();

  ui.decodeImageFromList(
      imagePath.isEmpty || imagePath == "No Data" ? profileIcons : imageBytes,
      (ui.Image img) {
    return completer.complete(img);
  });


  return completer.future;
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  var img = await fi.image.toByteData(format: ui.ImageByteFormat.png);
  return img!.buffer.asUint8List();
}

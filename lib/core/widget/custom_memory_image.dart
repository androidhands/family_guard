import 'dart:developer';
import 'dart:typed_data';

import 'package:family_guard/core/network/api_endpoint.dart';
import 'package:flutter/material.dart';

import '../network/api_caller.dart';
import '../utils/app_sizes.dart';
import 'custom_loading_shimmer.dart';
import 'package:http/http.dart' as http;

class CustomMemorykImage extends StatefulWidget {
  const CustomMemorykImage({
    Key? key,
    required this.imageUrl,
    this.errorImageUrl,
    this.height,
    this.width,
    this.fit,
    this.radius,
  }) : super(key: key);

  CustomMemorykImage.circle(
      {Key? key,
      required String imageUrl,
      String? errorImageUrl,
      required double size,
      BoxFit? fit})
      : this(
            key: key,
            radius: BorderRadius.circular(AppSizes.brMax),
            imageUrl: imageUrl,
            errorImageUrl: errorImageUrl,
            height: size,
            width: size,
            fit: fit);

  CustomMemorykImage.square(
      {Key? key,
      required String imageUrl,
      String? errorImageUrl,
      required double size,
      BorderRadius? radius})
      : this(
          key: key,
          radius: radius ?? BorderRadius.circular(AppSizes.br8),
          imageUrl: imageUrl,
          errorImageUrl: errorImageUrl,
          height: size,
          width: size,
        );

  CustomMemorykImage.rectangle(
      {Key? key,
      required String imageUrl,
      String? errorImageUrl,
      required double height,
      required double width,
      BorderRadius? radius})
      : this(
          key: key,
          radius: radius ?? BorderRadius.circular(AppSizes.br8),
          imageUrl: imageUrl,
          errorImageUrl: errorImageUrl,
          height: height,
          width: width,
        );

  final String imageUrl;
  final String? errorImageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? radius;

  @override
  State<CustomMemorykImage> createState() => _CustomMemorykImageState();
}

class _CustomMemorykImageState extends State<CustomMemorykImage> {
  Uint8List? _bytes;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    try {
      var headers = {
        'Authorization': 'Basic $basicAuth',
        'auth-token':
            'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2RldmVsb3BtZW50LnV0dXJuc29mdHdhcmUuY29tL2FwaS91c2Vycy9sb2dpbiIsImlhdCI6MTY5MTIyNTQ2NywiZXhwIjo1MjkxMjI1NDY3LCJuYmYiOjE2OTEyMjU0NjcsImp0aSI6InkzejJ1b1lNdzRGenFGbGQiLCJzdWIiOiI4IiwicHJ2IjoiZjY0ZDQ4YTZjZWM3YmRmYTdmYmY4OTk0NTRiNDg4YjNlNDYyNTIwYSJ9.-Xu58ocIFN6_nJoqxE4hB7pD8uvgghfxH3IFLc_l-3I'
      };

      var response = await http.Client().get(
          Uri.parse(
              '$baseUrl${ApiEndPoint.memberImagePath}?api_password=${ApiEndPoint.apiPassword}&imageUrl=${widget.imageUrl}'),
          headers: headers);
      log(response.statusCode.toString());

      _bytes = response.bodyBytes;

      setState(() {});
    } on Exception catch (e) {
      log('image exception ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _bytes != null
        ? ClipRRect(
            borderRadius: widget.radius ?? BorderRadius.circular(AppSizes.br8),
            child: Image.memory(
              _bytes!,
              width: widget.width,
              height: widget.height,
              fit: widget.fit ?? BoxFit.cover,

              /*     ///place holder widget
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return CustomLoadingShimmer(
                    height: widget.height ?? AppSizes.imageHeightLarge,
                    width: widget.width ?? AppSizes.widthFullScreen,
                    borderRadius: widget.radius);
              }, */

              ///error widget
              errorBuilder: (context, error, stackTrace) {
                return widget.errorImageUrl != null
                    ? CustomMemorykImage(
                        imageUrl: widget.errorImageUrl!,
                        height: widget.height,
                        width: widget.width,
                        fit: widget.fit,
                      )
                    : const Icon(Icons.error);
              },
            ),
          )
        : CustomLoadingShimmer(
            height: widget.height ?? AppSizes.imageHeightLarge,
            width: widget.width ?? AppSizes.widthFullScreen,
            borderRadius: widget.radius);
  }
}

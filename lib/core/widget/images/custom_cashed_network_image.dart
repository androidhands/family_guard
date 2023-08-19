import 'package:cached_network_image/cached_network_image.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/network/api_caller.dart';
import 'package:family_guard/core/network/api_endpoint.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_sizes.dart';

import '../custom_loading_shimmer.dart';

class CustomCashedNetworkImage extends StatelessWidget {
  const CustomCashedNetworkImage({
    Key? key,
    required this.imageUrl,
    this.errorImageUrl,
    this.height,
    this.width,
    this.fit,
    this.radius,
    required this.token,
  }) : super(key: key);

  CustomCashedNetworkImage.circle({
    Key? key,
    required String imageUrl,
    String? errorImageUrl,
    required double size,
    required String token,
  }) : this(
            key: key,
            radius: BorderRadius.circular(AppSizes.brMax),
            imageUrl: imageUrl,
            errorImageUrl: errorImageUrl,
            height: size,
            width: size,
            token: token);

  CustomCashedNetworkImage.square({
    Key? key,
    required String imageUrl,
    String? errorImageUrl,
    required double size,
    BorderRadius? radius,
    required String token,
  }) : this(
            key: key,
            radius: radius ?? BorderRadius.circular(AppSizes.br8),
            imageUrl: imageUrl,
            errorImageUrl: errorImageUrl,
            height: size,
            width: size,
            token: token);

  CustomCashedNetworkImage.rectangle({
    Key? key,
    required String imageUrl,
    String? errorImageUrl,
    required double height,
    required double width,
    BorderRadius? radius,
    required String token,
  }) : this(
            key: key,
            radius: radius ?? BorderRadius.circular(AppSizes.br8),
            imageUrl: imageUrl,
            errorImageUrl: errorImageUrl,
            height: height,
            width: width,
            token: token);

  final String imageUrl;
  final String? errorImageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final BorderRadius? radius;
  final String token;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: radius ?? BorderRadius.circular(AppSizes.br8),
      child: Image.network(
        '$baseUrl${ApiEndPoint.memberImagePath}?api_password=${ApiEndPoint.apiPassword}&imageUrl=$imageUrl',
        height: height ?? AppSizes.imageHeightLarge,
        width: width ?? AppSizes.widthFullScreen,
        fit: fit ?? BoxFit.cover,
        headers: {'Authorization': 'Basic $basicAuth', 'auth-token': token},
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return CustomLoadingShimmer(
              height: height ?? AppSizes.imageHeightLarge,
              width: width ?? AppSizes.widthFullScreen,
              borderRadius: radius);
        },
        errorBuilder: (context, url, error) => errorImageUrl != null
            ? CachedNetworkImage(
                imageUrl: errorImageUrl!,
                height: height,
                width: width,
                fit: fit,
              )
            : CustomSvgImage.square(
                path: AppAssets.person,
                color: ThemeColorLight.whiteColor,
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:family_guard/core/integrated_library/loading/beat.dart';


class LoadingAnimationWidget {
  LoadingAnimationWidget._();


  /// One ring emerge from the center and scale up until touches the outer ring.
  /// Then the outer ring expand a bit then come back to normal.
  /// Required color is applied to both rings.
  static Widget beat({
    required double size,
    Key? key,
  }) {
    return Beat(
      size: size,
      key: key,
    );
  }

}

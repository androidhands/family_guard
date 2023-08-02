import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/extension/shadow.dart';
import 'package:awesome_bottom_bar/widgets/hexagon/hexagon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../global/theme/theme_color/theme_color_light.dart';
import 'bottom_bar.dart';
import 'build_icon.dart';
import 'package:family_guard/core/integrated_library/bottom_navigation_bar/tab_item.dart'
    as tap;

class BottomBarCreative extends StatefulWidget {
  final List<tap.TabItem> items;

  /// view
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;
  final double? blur;
  final int? visitHighlight;

  /// item
  final int indexSelected;
  final Function(int index)? onTap;

  final Color color;
  final Color colorSelected;
  final Color? backgroundSelected;
  final double iconSize;
  final TextStyle? titleStyle;
  final double? paddingVertical;
  final CountStyle? countStyle;
  final HighlightStyle? highlightStyle;

  final bool isFloating;

  final double? top;
  final double? bottom;
  final double? pad;
  final bool? enableShadow;

  const BottomBarCreative({
    Key? key,
    required this.items,
    required this.backgroundColor,
    this.boxShadow,
    this.blur,
    this.visitHighlight,
    this.borderRadius,
    this.indexSelected = 0,
    this.onTap,
    required this.color,
    required this.colorSelected,
    this.iconSize = 22,
    this.titleStyle,
    this.backgroundSelected,
    this.paddingVertical,
    this.countStyle,
    this.isFloating = false,
    this.highlightStyle,
    this.top = 12,
    this.bottom = 12,
    this.pad = 4,
    this.enableShadow = true,
  }) : super(
          key: key,
        );

  @override
  BottomBarCreativeState createState() => BottomBarCreativeState();
}

class BottomBarCreativeState extends State<BottomBarCreative> {
  @override
  Widget build(BuildContext context) {
    int defaultVisit =
        widget.items.length / 2 == 0 ? 0 : (widget.items.length / 2).ceil() - 1;
    int visit = widget.visitHighlight ?? defaultVisit;

    double bottom = MediaQuery.of(context).viewPadding.bottom;
    EdgeInsets padDefault = EdgeInsets.only(
        top: widget.top!,

        ///here
        bottom: (widget.bottom! > 2 ? widget.bottom! + bottom : bottom));

    EdgeInsetsGeometry pad = widget.paddingVertical != null
        ? EdgeInsets.symmetric(vertical: 12.0.h)
        : padDefault;

    double sizeHighlight = 40.h;

    isShadow = widget.enableShadow!;

    return BuildLayout(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow ?? shadow,
      ),
      blur: widget.blur,
      clipBehavior: Clip.none,
      child: widget.items.isNotEmpty
          ? IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(widget.items.length, (index) {
                  tap.TabItem item = widget.items[index];
                  Widget highlightWidget = GestureDetector(
                    onTap: index != widget.indexSelected
                        ? () => widget.onTap?.call(visit)
                        : null,
                    child: buildHighLight(context,
                        item: item,
                        color: widget.colorSelected,
                        size: sizeHighlight),
                  );

                  return Expanded(
                    child: InkWell(
                      onTap: index != widget.indexSelected
                          ? () => widget.onTap?.call(index)
                          : null,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 450),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: ScaleTransition(
                              scale: animation,
                              child: child,
                            ),
                          );
                        },
                        child: widget.indexSelected != index
                            ? buildItem(
                                context,
                                item: item,
                                sizeIcon: 22.h,
                                color: widget.color,
                                isSelected: index == widget.indexSelected,
                              )
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: pad,
                                    child: highlightWidget,
                                  )
                                ],
                              ),
                      ),
                    ),
                  );
                }),
              ),
            )
          : null,
    );
  }

  Widget buildItem(
    BuildContext context, {
    required tap.TabItem item,
    bool isSelected = false,
    required Color color,
    double sizeIcon = 22,
    TextStyle? styleTitle,
    double? paddingVer,
    CountStyle? countStyle,
  }) {
    double bottom = MediaQuery.of(context).viewPadding.bottom;

    EdgeInsets padDefault = EdgeInsets.only(
      top: widget.top!,

      ///here
      bottom: (widget.bottom! > 2 ? widget.bottom! + bottom : bottom),
    );
    Color itemColor = isSelected ? widget.colorSelected : color;

    return Container(
      padding: paddingVer != null
          ? EdgeInsets.symmetric(vertical: paddingVer)
          : padDefault,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BuildIcon(
            item: item,
            iconColor: itemColor,
            iconSize: widget.iconSize,
            countStyle: countStyle,
          ),
          if (item.title is String && item.title != '') ...[
            SizedBox(height: widget.pad),
            Text(
              item.title!,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.merge(widget.titleStyle)
                  .copyWith(color: itemColor),
              textAlign: TextAlign.center,
            )
          ],
        ],
      ),
    );
  }

  Widget buildHighLight(
    BuildContext context, {
    required tap.TabItem item,
    required Color color,
    double size = 48,
    CountStyle? countStyle,
  }) {
    Color background = widget.highlightStyle?.background ?? color;
    Color colorIcon = widget.highlightStyle?.color ?? Colors.white;
    if (widget.highlightStyle?.isHexagon == true) {
      return AnimateHexagonWidget(
        hexagonWidget: HexagonWidget(
          width: size,
          height: size,
          color: background,
          elevation: widget.highlightStyle?.elevation ?? 0,
          child: BuildIcon(
            item: item,
            iconColor: colorIcon,
            iconSize: 22,
            countStyle: countStyle,
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
          gradient: ThemeColorLight.gradientMAinColor,
          borderRadius: BorderRadius.circular(size / 2)),
      height: size,
      width: size,
      alignment: Alignment.center,
      child: BuildIcon(
        item: item,
        iconColor: colorIcon,
        iconSize: 22,
        countStyle: countStyle,
      ),
    );
  }
}

class AnimateHexagonWidget extends StatefulWidget {
  final Widget hexagonWidget;

  const AnimateHexagonWidget({Key? key, required this.hexagonWidget})
      : super(key: key);

  @override
  State<AnimateHexagonWidget> createState() => _AnimateHexagonWidgetState();
}

class _AnimateHexagonWidgetState extends State<AnimateHexagonWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.hexagonWidget;
  }
}

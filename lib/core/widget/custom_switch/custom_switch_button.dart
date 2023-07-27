import 'package:flutter/material.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import '../../global/theme/theme_color/theme_color_dark.dart';
import '../images/custom_svg_image.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? iconAsset;

  const CustomSwitch(
      {Key? key, required this.value, required this.onChanged, this.iconAsset})
      : super(key: key);

  @override
  CustomSwitchState createState() => CustomSwitchState();
}

class CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const  Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: SizedBox(
            width: AppSizes.pW8,
            height: AppSizes.h3,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.br50),
                      // I commented here.
                      // color: _circleAnimation.value == Alignment.centerLeft
                      //     ? widget.inactiveColor
                      //     : widget.activeColor,

                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.center,
                        // You can set your own colors in here!
                        colors: widget.value
                            ? [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                              ]
                            : [
                                ThemeColorDark.secondaryColor,
                                ThemeColorDark.secondaryColor
                              ],
                      ),
                      border: widget.value
                          ? null
                          : Border.all(
                              width: 1.5, color: ThemeColorDark.grayScale)),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _circleAnimation.value == Alignment.centerRight
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: AppSizes.pH6, right: 0),
                                child: null)
                            : Container(),
                        _circleAnimation.value == Alignment.centerLeft
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 0, right: AppSizes.pH6),
                                child: null)
                            : Container(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: _circleAnimation.value == Alignment.centerLeft
                          ? AppSizes.pW4
                          : widget.value
                              ? AppSizes.pW6
                              : AppSizes.pW4,
                      height: _circleAnimation.value == Alignment.centerLeft
                          ? AppSizes.pW4
                          : widget.value
                              ? AppSizes.pW6
                              : AppSizes.pW4,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.value
                              ? ThemeColorDark.elevatedButtonTextColor
                              : ThemeColorDark.grayScale),
                      child: widget.iconAsset == null
                          ? null
                          :
                          CustomSvgImage.icons(
                              path: widget.iconAsset!,
                              color: Theme.of(context).iconTheme.color),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

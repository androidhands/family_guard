import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum NavigationMethod {
  push,
  pushReplacement,
  pushReplacementALL,
  offUntil,
  pop
}

class NavigationService {

 static Future<dynamic> navigateTo(
      {bool isNamed = false,
      required NavigationMethod navigationMethod,
      required dynamic page,
      Transition? transition,
      Duration? duration,
      Curve? curve,
      dynamic arguments,
      bool preventDuplicates = true,
      bool? popGesture,
      Map<String, String>? parameters}) async {
    assert(navigationMethod != NavigationMethod.pop);
    assert(navigationMethod != NavigationMethod.pushReplacementALL);
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    if (isNamed) {
      return await _getNavigationMethod(
          isNamed: true, navigationMethod: navigationMethod)(
        page.toString(),
        preventDuplicates: preventDuplicates,
        arguments: arguments,
        parameters: parameters,
      );
    } else {
      return await _getNavigationMethod(
          isNamed: false, navigationMethod: navigationMethod)(
        page,
        preventDuplicates: preventDuplicates,
        arguments: arguments,
        popGesture: popGesture,
        curve: curve,
        transition: transition,
        duration: duration,
      );
    }
  }

  static goBack<T>({
    T? result,
    bool closeOverlays = false,
    bool canPop = true,
    int? id,
  }) {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Get.back<T>(
        canPop: canPop, id: id, closeOverlays: closeOverlays, result: result);
  }

  static void popUntil({
    required RoutePredicate predicate,
  }) {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    Get.until(predicate);
  }

  static Future<T?>? offAll<T>({
    bool isNamed = false,
    required dynamic page,
    bool Function(Route<dynamic>)? predicate,
    int? id,
    Transition? transition,
    Curve? curve,
    Duration? duration,
  }) {
    if (Get.context != null) {
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    }
    if (!isNamed) {
      _getNavigationMethod(
        navigationMethod: NavigationMethod.pushReplacementALL,
        isNamed: false,
      )(
        page,
        predicate: predicate ?? (_) => false,
        transition: transition,
        curve: curve,
        duration: duration,
      );
    } else {
      _getNavigationMethod(
        navigationMethod: NavigationMethod.pushReplacementALL,
        isNamed: true,
      )(
        page.toString(),
        predicate: predicate ?? (_) => false,
      );
    }
    return null;
  }

  static _getNavigationMethod(
      {bool isNamed = false, required NavigationMethod navigationMethod}) {
    switch (navigationMethod) {
      case NavigationMethod.push:
        {
          return isNamed ? Get.toNamed : Get.to;
        }
      case NavigationMethod.pushReplacement:
        {
          return isNamed ? Get.offNamed : Get.off;
        }

      case NavigationMethod.pushReplacementALL:
        {
          return isNamed ? Get.offAllNamed : Get.offAll;
        }
      default:
        {
          throw 'No navigation method selected, navigation method is required';
        }
    }
  }
}

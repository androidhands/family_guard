import 'package:family_guard/core/global/localization/app_localization.dart';
import 'package:family_guard/core/global/theme/theme_color/theme_color_light.dart';
import 'package:family_guard/core/services/date_parser.dart';
import 'package:family_guard/core/services/navigation_service.dart';
import 'package:family_guard/core/utils/app_assets.dart';
import 'package:family_guard/core/utils/app_constants.dart';
import 'package:family_guard/core/utils/app_sizes.dart';
import 'package:family_guard/core/widget/custom_appbar.dart';
import 'package:family_guard/core/widget/custom_loading_indicator.dart';
import 'package:family_guard/core/widget/images/custom_svg_image.dart';
import 'package:family_guard/features/emergency/data/models/time_zone_model.dart';
import 'package:family_guard/features/emergency/domain/entities/phone_call_entity.dart';
import 'package:family_guard/features/emergency/presentation/controller/call_details_provier.dart';
import 'package:family_guard/features/emergency/presentation/widgets/custom_call_player_widget.dart';
import 'package:family_guard/features/profile/presentation/widgets/custom_my_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class CallDetailsScreen extends StatelessWidget {
  final PhoneCallEntity phoneCallEntity;

  const CallDetailsScreen({Key? key, required this.phoneCallEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            CallDetailsProvier(phoneCallEntity: phoneCallEntity),
        builder: (context, child) {
          return Consumer<CallDetailsProvier>(
              builder: (context, provider, child) {
            return Scaffold(
              appBar: CustomAppbar(
                title: tr(AppConstants.callsLog),
                withTransparent: false,
                withOutElevation: true,
                withMenu: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        provider.getCallDetails();
                      },
                      icon: const Icon(
                        Icons.refresh,
                        color: ThemeColorLight.pinkColor,
                      ))
                ],
                popOnPressed: () {
                  NavigationService.goBack();
                },
                popIconsColor: ThemeColorLight.pinkColor,
              ),
              body: provider.isLoading
                  ? Center(
                      child: CustomLoadingIndicators.defaultLoading(),
                    )
                  : Padding(
                      padding: EdgeInsets.all(AppSizes.pW5),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: AppSizes.mapAddressHight2,
                              width: AppSizes.widthFullScreen,
                              child: Stack(
                                children: [
                                  GoogleMap(
                                      onMapCreated: (controller) {
                                        provider.onMapCreated(controller);
                                      },
                                      initialCameraPosition: CameraPosition(
                                          target: LatLng(
                                              provider.callEntity.lat,
                                              provider.callEntity.lon))),
                                  Center(
                                      child: CustomSvgImage(
                                    path: AppAssets.pinLocation,
                                    width: AppSizes.locationIndicatorWidth,
                                    height: AppSizes.locationIndicatorHight,
                                  )),
                                ],
                              ),
                            ),
                            if (provider.callEntity.status == "completed")
                              provider.isGettingRecordingUrl
                                  ? Center(
                                      child: CustomLoadingIndicators
                                          .defaultLoading(),
                                    )
                                  : CustomCallPlayerWidget(
                                      url: provider.recordUrl,
                                    ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.emergencyCase),
                              subTitle: provider.callEntity.emergencyType
                                  .replaceAll('_', ''),
                              hasDevider: false,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.callStatus),
                              subTitle: provider.callEntity.status!,
                              hasDevider: false,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.date),
                              subTitle:
                                  '${phoneCallEntity.dateCreated == null ? 'Click to show Details' : phoneCallEntity.dateCreated is String ? DateParser().dateFormatterOnlyDateTime(phoneCallEntity.dateCreated!) : DateParser().dateFormatterOnlyDateTime(TimeZoneModel.fromJson(phoneCallEntity.dateCreated!).date)} ',
                              hasDevider: false,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.duration),
                              subTitle: provider.callEntity.duration!,
                              hasDevider: false,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.country),
                              subTitle: provider.callEntity.country,
                              hasDevider: true,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.street),
                              subTitle: provider.callEntity.street,
                              hasDevider: true,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.city),
                              subTitle: provider.callEntity.city,
                              hasDevider: true,
                            ),
                            CustomMyDetailsWidget(
                              title: tr(AppConstants.state),
                              subTitle: provider.callEntity.state,
                              hasDevider: true,
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          });
        });
  }
  /*${phoneCallEntity.dateCreated == null ? 'Click to show Details' : phoneCallEntity.dateCreated is String ? DateParser().dateFormatterOnlyDateTime(phoneCallEntity.dateCreated!) : DateParser().dateFormatterOnlyDateTime(TimeZoneModel.fromJson(phoneCallEntity.dateCreated!).date)} */
}

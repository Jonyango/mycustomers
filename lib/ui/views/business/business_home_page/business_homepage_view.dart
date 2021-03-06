import 'dart:io';

import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/business_card_page/business_cardpage_view.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/views/business/business_card_page/business_cardpage_viewmodel.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';

import 'business_homepage_viewmodel.dart';

class BusinessHomePageView extends StatelessWidget {
  final String profile = 'assets/icons/svg/profile.svg';
  final String settings = 'assets/icons/svg/settings.svg';
  final String support = 'assets/icons/svg/support.svg';
  final String businessCard = 'assets/icons/svg/business_card.svg';
  final String phoneNumber = 'assets/icons/svg/phone.svg';
  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessHomePageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: SizeConfig.yMargin(context, 11),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).backgroundColor.computeLuminance() >
                                0.5
                            ? Colors.white
                            : ThemeColors.black,
                  ),
                  child: ListTile(
                    title: Text(
                      AppLocalizations.of(context).profile,
                      style: TextStyle(
                        fontSize: SizeConfig.textSize(context, 5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: BrandColors.primary,
                      backgroundImage: model.currentStore.storePic != null
                          ? MemoryImage(model.currentStore.storePic)
                          : null,
                      minRadius: SizeConfig.xMargin(context, 7),
                      maxRadius: SizeConfig.xMargin(context, 7.3),
                      child: model.currentStore.storePic != null
                          ? Container()
                          : Text(
                              model.profileCardTitle.substring(0, 1),
                              style: TextStyle(
                                color: ThemeColors.background,
                                fontSize: SizeConfig.textSize(context, 6),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Theme.of(context).cursorColor,
                    ),
                    onTap: model.navigateToProfilePage,
                  ),
                ),

                optionButton(
                  context: context,
                  icon: phoneNumber,
                  label: AppLocalizations.of(context).regPhoneNo,
                  subtitle: '${model.pNum}',
                  opens: false,
                  // onTap: () => _displayBusinessCardModal(context, model)
                ),
                // optionButton(
                //   context: context,
                //   icon: businessCard,
                //   label: 'Issue Digital Reciept',
                //   // onTap: () => _displayBusinessCardModal(context, model),
                // ),
                optionButton(
                  context: context,
                  icon: settings,
                  label: AppLocalizations.of(context).settings,
                  onTap: model.navigateToSettingsPage,
                ),
                optionButton(
                  context: context,
                  icon: support,
                  label: AppLocalizations.of(context).support,
                  onTap: model.navigateToSupportPage,
                ),
                SizedBox(height: SizeConfig.yMargin(context, 4)),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 20, horizontal: SizeConfig.xMargin(context, 7)),
                  child:
                      ViewModelBuilder<BusinessCardPageViewModel>.nonReactive(
                    builder: (_, businessCardModel, ___) => Column(
                      children: <Widget>[
                        BusinessCardWidget(
                          showArrow: false,
                          screenshotController: screenshotController,
                        ),
                        SizedBox(height: SizeConfig.yMargin(context, 1)),
                        Container(
                          height: SizeConfig.yMargin(context, 6),
                          width: SizeConfig.xMargin(context, 60),
                          child: CustomRaisedButton(
                            txtColor: ThemeColors.background,
                            btnColor: BrandColors.primary,
                            btnText: 'Share Business Card',
                            borderColor: BrandColors.primary,
                            child: Container(),
                            onPressed: () {
                              screenshotController
                                  .capture(
                                pixelRatio: ScreenUtil.pixelRatio,
                                delay: Duration(milliseconds: 10),
                              )
                                  .then(
                                (File image) {
                                  businessCardModel.imageFile = image;
                                  FlushbarHelper.createSuccess(
                                    duration: const Duration(seconds: 5),
                                    message: 'Sharing...',
                                  ).show(context);
                                  businessCardModel.shareImageAndText();
                                  FlushbarHelper.createSuccess(
                                    duration: const Duration(seconds: 5),
                                    message: 'Successful',
                                  ).show(context);
                                },
                              ).catchError(
                                (onError) {
                                  FlushbarHelper.createError(
                                    duration: const Duration(seconds: 5),
                                    message: onError.toString(),
                                  ).show(context);
                                },
                              );
                              return;
                            },
                          ),
                        )
                      ],
                    ),
                    viewModelBuilder: () => BusinessCardPageViewModel(),
                    onModelReady: (model) => model.init(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => BusinessHomePageViewModel(),
    );
  }

  Container optionButton({
    BuildContext context,
    String label,
    Function onTap,
    String icon,
    String subtitle,
    bool opens: true,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor.computeLuminance() > 0.5
            ? Colors.white
            : ThemeColors.black,
      ),
      child: ListTile(
        onTap: onTap,
        title: Text(label),
        subtitle: subtitle != null
            ? Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(subtitle),
              )
            : null,
        leading: CircleAvatar(
          backgroundColor: ThemeColors.background,
          minRadius: SizeConfig.xMargin(context, 4),
          maxRadius: SizeConfig.xMargin(context, 6),
          child: SvgPicture.asset(
            icon,
            semanticsLabel: label,
            color: BrandColors.primary,
          ),
        ),
        trailing: opens
            ? Icon(
                Icons.chevron_right,
                color: Theme.of(context).cursorColor,
              )
            : null,
      ),
    );
  }
}

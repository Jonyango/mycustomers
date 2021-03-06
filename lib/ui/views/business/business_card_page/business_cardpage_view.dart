import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/custom_share_button.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:screenshot/screenshot.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';

import 'business_cardpage_viewmodel.dart';

part '../../../widgets/business/business_card_page/business_card_widget.dart';

class BusinessCardPageView extends StatelessWidget {
  final String share = 'assets/icons/svg/share.svg';
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<BusinessCardPageViewModel>.nonReactive(
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: customizeAppBar(
            context,
            0,
            title: AppLocalizations.of(context).buisnessCard,
            arrowColor: Theme.of(context).textSelectionColor,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.xMargin(context, 7),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    BusinessCardWidget(
                      screenshotController: screenshotController,
                      showArrow: true,
                    ),
                    SizedBox(
                      height: SizeConfig.yMargin(context, 3),
                    ),
                    _BusinessCardForm(
                      formKey: formKey,
                    ),
                    SizedBox(
                      height: SizeConfig.yMargin(context, 5.5),
                    ),
                    CustomShareRaisedButton(
                      txtColor: ThemeColors.background,
                      btnColor: BrandColors.primary,
                      btnText: AppLocalizations.of(context).saveAndShare,
                      borderColor: BrandColors.primary,
                      child: SvgPicture.asset(
                        share,
                        height: SizeConfig.xMargin(context, 6),
                        color: ThemeColors.background,
                      ),
                      onPressed: () {
//                        if (formKey.currentState.validate()) {
                        screenshotController
                            .capture(
                          pixelRatio: ScreenUtil.pixelRatio,
                          delay: Duration(milliseconds: 10),
                        )
                            .then(
                          (File image) async {
                            //Capture Done
                            model.imageFile = image;
                            await model.saveBusinessCard();
                            FlushbarHelper.createSuccess(
                              duration: const Duration(seconds: 5),
                              message: 'Successful',
//                                  AppLocalizations.of(context).saveSuccessful,
                            ).show(context);
                            model.shareImageAndText();
                          },
                        ).catchError(
                          (onError) {
                            FlushbarHelper.createError(
                              duration: const Duration(seconds: 5),
                              message: onError.toString(),
                            ).show(context);
                          },
                        );
//                        }
                        return;
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.yMargin(context, 5),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).viewInsets.bottom,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => BusinessCardPageViewModel(),
      onModelReady: (model) => model.init(),
    );
  }
}

class _BusinessCardForm extends HookViewModelWidget<BusinessCardPageViewModel> {
  _BusinessCardForm({Key key, @required this.formKey})
      : super(key: key, reactive: false);
  final formKey;

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) {
    return Form(
      autovalidate: true,
      key: formKey,
      child: Column(
        children: <Widget>[
          _DefaultFormField(
            validate: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).fieldShouldNotBeEmpty;
              }
              return null;
            },
            label: AppLocalizations.of(context).storeName,
            onChange: (value) => model.updateBusinessCard(storeName: value),
          ),
          _DefaultFormField(
            validate: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).fieldShouldNotBeEmpty;
              }
              return null;
            },
            label: AppLocalizations.of(context).personalName,
            onChange: (value) => model.updateBusinessCard(personalName: value),
          ),
          _DefaultPhoneFormField(
            validate: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).fieldShouldNotBeEmpty;
              }
              return null;
            },
            label: AppLocalizations.of(context).phoneNumber,
            onChange: (PhoneNumber value) =>
                model.updateBusinessCard(phoneNumber: value.phoneNumber),
          ),
          _DefaultFormField(
            validate: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).fieldShouldNotBeEmpty;
              }
              return null;
            },
            label: AppLocalizations.of(context).emailAddress,
            onChange: (value) => model.updateBusinessCard(emailAddress: value),
          ),
          _DefaultFormField(
            validate: (value) {
              if (value.isEmpty) {
                return AppLocalizations.of(context).fieldShouldNotBeEmpty;
              }
              return null;
            },
            label: AppLocalizations.of(context).shopAddress,
            onChange: (value) {
              model.updateBusinessCard(address: value);
            },
          ),
        ],
      ),
    );
  }
}

class _DefaultFormField extends HookViewModelWidget<BusinessCardPageViewModel> {
  final String label;
  final Function onChange;
  final Function validate;

  _DefaultFormField({this.validate, this.onChange, this.label, Key key})
      : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) =>
      Container(
        margin: EdgeInsets.symmetric(
          vertical: SizeConfig.yMargin(context, 1),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.xMargin(context, 4),
          vertical: SizeConfig.yMargin(context, 0.3),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: ThemeColors.gray[700]),
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(SizeConfig.yMargin(context, 0.5)),
        ),
        child: TextFormField(
          textCapitalization: TextCapitalization.sentences,
          onChanged: onChange,
// TODO fix text fields
//          validator: validate,
          cursorColor: ThemeColors.gray[800],
          style: TextStyle(
            color: Theme.of(context).cursorColor,
            fontSize: SizeConfig.textSize(context, 5),
          ),
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: label,
            hintStyle: TextStyle(
              fontSize: SizeConfig.textSize(context, 5),
              color: ThemeColors.gray[700],
            ),
          ),
        ),
      );
}

class _DefaultPhoneFormField
    extends HookViewModelWidget<BusinessCardPageViewModel> {
  final String label;
  final onChange;
  final validate;

  _DefaultPhoneFormField({this.validate, this.onChange, this.label, Key key})
      : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    BusinessCardPageViewModel model,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.yMargin(context, 1)),
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.xMargin(context, 4),
        vertical: SizeConfig.yMargin(context, 0.3),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColors.gray[700]),
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(SizeConfig.yMargin(context, 0.5)),
      ),
      child: InternationalPhoneNumberInput(
        onInputChanged: onChange,
        textStyle: TextStyle(
          color: Theme.of(context).cursorColor,
          fontSize: SizeConfig.textSize(context, 5),
        ),
        selectorType: PhoneInputSelectorType.DIALOG,
        selectorTextStyle: TextStyle(color: Theme.of(context).cursorColor),
        inputBorder: InputBorder.none,
        hintText: '903 9393 9383',
        formatInput: true,
      ),
    );
  }
}

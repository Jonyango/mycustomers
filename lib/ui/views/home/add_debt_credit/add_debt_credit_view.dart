import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/services/notifications/notifications_reminder.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/views/marketing/widgets/customer_circle_avatar.dart';
import 'package:mycustomers/ui/views/marketing/widgets/my_list_tile.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/core/localization/app_localization.dart';

import 'add_debt_credit_viewmodel.dart';

class AddDebtCreditView extends StatelessWidget {
  final String action;
  final bool update;
  final bool newCus;

  AddDebtCreditView({Key key, this.action, this.update, this.newCus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    ScreenUtil.init(context, width: width, height: height);
    NotificationRemindersService reminders = NotificationRemindersService();
    return ViewModelBuilder<AddDebtCreditViewModel>.reactive(
        onModelReady: (model) {
          if (newCus) {
            model.init();
          }
        },
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              brightness: Brightness.dark,
              elevation: 1,
              title: Text(
                newCus
                    ? action == 'debit'
                        ? AppLocalizations.of(context).addNewDebtor
                        : AppLocalizations.of(context).addNewCreditor
                    : action == 'debit'
                        ? model.amount != null
                            ? '${model.contact.name} ${AppLocalizations.of(context).owesYou} ₦' +
                                model.amount.round().toString()
                            : '${model.contact.name} ${AppLocalizations.of(context).owesYou}'
                        : model.amount != null
                            ? '${AppLocalizations.of(context).youOwe} ${model.contact.name} ₦' +
                                model.amount.round().toString()
                            : '${AppLocalizations.of(context).youOwe} ${model.contact.name}',
                style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.bold,
                    //color: Colors.black,
                    fontFamily: 'Roboto'),
              ),
              leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(18),
                      vertical: ScreenUtil().setHeight(10)),
                  child: SvgPicture.asset(
                    'assets/icons/backarrow.svg',
                    color: action == 'debit'
                        ? BrandColors.secondary
                        : Theme.of(context).textSelectionColor,
                  ),
                ),
              ),
              backgroundColor: Theme.of(context).backgroundColor,
              centerTitle: true,
            ),
            body: Container(
              padding: EdgeInsets.only(bottom: 25),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SingleChildScrollView(
                      controller: model.controller,
                      child: Container(
                        //margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                        //padding: EdgeInsets.symmetric(vertical: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Container(
                            //   margin: EdgeInsets.only(
                            //       bottom: ScreenUtil().setHeight(10)),
                            //   child: Center(
                            //     child: Text(
                            //       'Transaction Details',
                            //       style: Theme.of(context)
                            //           .textTheme
                            //           .headline6
                            //           .copyWith(
                            //               fontSize:
                            //                   SizeConfig.yMargin(context, 2.6),
                            //               fontWeight: FontWeight.bold),
                            //     ),
                            //   ),
                            // ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: ScreenUtil().setHeight(15),
                                        top: 25),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: 5, left: 2),
                                          child: Text(
                                            AppLocalizations.of(context).amount,
                                            style: TextStyle(
                                                fontSize: SizeConfig.yMargin(
                                                    context, 2.2),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        TextField(
                                          maxLines: null,
                                          maxLengthEnforced: false,
                                          keyboardType: TextInputType.number,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  color: action == 'debit'
                                                      ? BrandColors.secondary
                                                      : Theme.of(context)
                                                          .textSelectionColor,
                                                  fontSize: SizeConfig.yMargin(
                                                      context, 2),
                                                  fontWeight: FontWeight.bold),
                                          decoration: new InputDecoration(
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFD1D1D1),
                                                  width: 2.0),
                                            ),
                                            disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFD1D1D1),
                                                  width: 2.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xFFD1D1D1),
                                                  width: 2.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: action == 'debit'
                                                      ? BrandColors.secondary
                                                      : BrandColors.primary,
                                                  width: 2.0),
                                            ),
                                            errorBorder:
                                                const OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.red,
                                                  width: 2.0),
                                            ),
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .enterAmount,
                                            //action == 'credit'
                                            //     ? 'Enter Amount you owe ${model.contact.name}'
                                            //     : 'Enter Amount ${model.contact.name} Owes You',
                                            hintStyle: TextStyle(
                                                fontSize: SizeConfig.yMargin(
                                                    context, 2)),
                                            errorText: model.errormsg,
                                            prefixIcon: Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: ScreenUtil()
                                                        .setHeight(15),
                                                    horizontal: ScreenUtil()
                                                        .setWidth(10)),
                                                child: Text(
                                                  model.currency.symbol,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .cursorColor,
                                                      fontSize:
                                                          SizeConfig.yMargin(
                                                              context, 3),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Roboto'),
                                                )),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: ScreenUtil()
                                                        .setHeight(8)),
                                          ),
                                          textInputAction: TextInputAction.next,
                                          onChanged: (value) =>
                                              model.updateAmount(value, update,
                                                  action, newCus),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: model.show,
                                    child: Column(
                                      children: <Widget>[
                                        // Container(
                                        //   child: Column(
                                        //     crossAxisAlignment: CrossAxisAlignment.start,
                                        //     children: <Widget>[
                                        //       Container(
                                        //         margin: EdgeInsets.only(bottom: 3),
                                        //         child: Text(
                                        //           'Purchase Date',
                                        //           style: TextStyle(fontSize: SizeConfig.yMargin(context, 2.2), fontWeight: FontWeight.w600),
                                        //         ),
                                        //       ),
                                        //       InkWell(
                                        //         onTap: () async {
                                        //           final DateTime picked =
                                        //               await showDatePicker(
                                        //             context: context,
                                        //             initialDate: model.selectedDate,
                                        //             firstDate: DateTime(2000),
                                        //             lastDate: action == 'credit'
                                        //                 ? DateTime(2030)
                                        //                 : DateTime(
                                        //                     int.parse(DateFormat('yyyy')
                                        //                         .format(DateTime.now())),
                                        //                     int.parse(DateFormat('MM')
                                        //                         .format(DateTime.now())),
                                        //                     int.parse(DateFormat('dd')
                                        //                         .format(DateTime.now()))),
                                        //             builder: (BuildContext context,
                                        //                 Widget child) {
                                        //               return Theme(
                                        //                 data: Theme.of(context).copyWith(
                                        //                   primaryColor: action == 'debit'
                                        //                       ? BrandColors.secondary
                                        //                       : Theme.of(context)
                                        //                           .textSelectionColor,
                                        //                   accentColor: action == 'debit'
                                        //                       ? BrandColors.secondary
                                        //                       : Theme.of(context)
                                        //                           .textSelectionColor,
                                        //                   colorScheme: Theme.of(context)
                                        //                       .colorScheme
                                        //                       .copyWith(
                                        //                           primary: action == 'debit'
                                        //                               ? BrandColors
                                        //                                   .secondary
                                        //                               : Theme.of(context)
                                        //                                   .textSelectionColor),
                                        //                   buttonTheme: ButtonThemeData(
                                        //                       textTheme:
                                        //                           ButtonTextTheme.primary),
                                        //                 ),
                                        //                 child: child,
                                        //               );
                                        //             },
                                        //           );
                                        //           if (picked != null)
                                        //             model.setOtherDate(
                                        //                 picked, update, action, newCus);
                                        //         },
                                        //         child: Container(
                                        //           margin: EdgeInsets.only(bottom: 15),
                                        //           padding: EdgeInsets.symmetric(
                                        //               vertical: ScreenUtil().setHeight(15),
                                        //               horizontal:
                                        //                   ScreenUtil().setWidth(15)),
                                        //           decoration: BoxDecoration(
                                        //               border: Border.all(
                                        //                   color: model.date2err
                                        //                       ? Colors.red
                                        //                       : Color(0xFFD1D1D1),
                                        //                   width: 2.0),
                                        //               borderRadius: BorderRadius.circular(
                                        //                   ScreenUtil().setWidth(5))),
                                        //           child: Row(
                                        //             children: <Widget>[
                                        //               Container(
                                        //                 margin: EdgeInsets.only(
                                        //                     right:
                                        //                         ScreenUtil().setWidth(15)),
                                        //                 child: SvgPicture.asset(
                                        //                     'assets/icons/calendar.svg',
                                        //                     color: action == 'debit'
                                        //                         ? BrandColors.secondary
                                        //                         : Theme.of(context)
                                        //                             .textSelectionColor),
                                        //               ),
                                        //               Container(
                                        //                 child: Text(
                                        //                   model.newODate != null
                                        //                       ? model.newODate
                                        //                       : action == 'debit'
                                        //                           ? 'Select Date of Purchase'
                                        //                           : 'Select Date of Payment',
                                        //                   style: Theme.of(context)
                                        //                       .textTheme
                                        //                       .headline6
                                        //                       .copyWith(
                                        //                         fontSize:
                                        //                             ScreenUtil().setSp(16),
                                        //                         color: action == 'debit'
                                        //                             ? BrandColors.secondary
                                        //                             : Theme.of(context)
                                        //                                 .textSelectionColor,
                                        //                       ),
                                        //                 ),
                                        //               )
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        action == 'xx' //'Credit'
                                            ? SizedBox()
                                            : Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 5, left: 2),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)
                                                            .paymentDate,
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                .yMargin(
                                                                    context,
                                                                    2.2),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        final DateTime picked =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate: model
                                                              .selectedDate,
                                                          firstDate: DateTime(
                                                              int.parse(DateFormat(
                                                                      'yyyy')
                                                                  .format(DateTime
                                                                      .now())),
                                                              int.parse(DateFormat('MM')
                                                                  .format(DateTime
                                                                      .now())),
                                                              int.parse(DateFormat(
                                                                      'dd')
                                                                  .format(DateTime
                                                                      .now()))),
                                                          lastDate:
                                                              DateTime(2300),
                                                          builder: (BuildContext
                                                                  context,
                                                              Widget child) {
                                                            return Theme(
                                                              data: Theme.of(
                                                                      context)
                                                                  .copyWith(
                                                                primaryColor: action == 'debit'
                                                                    ? BrandColors
                                                                        .secondary
                                                                    : Theme.of(
                                                                            context)
                                                                        .textSelectionColor,
                                                                accentColor: action == 'debit'
                                                                    ? BrandColors
                                                                        .secondary
                                                                    : Theme.of(
                                                                            context)
                                                                        .textSelectionColor,
                                                                colorScheme: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .copyWith(
                                                                        primary: action ==
                                                                                'debit'
                                                                            ? BrandColors.secondary
                                                                            : Theme.of(context).textSelectionColor),
                                                                buttonTheme: ButtonThemeData(
                                                                    textTheme:
                                                                        ButtonTextTheme
                                                                            .primary),
                                                              ),
                                                              child: child,
                                                            );
                                                          },
                                                        );
                                                        if (picked != null)
                                                          model.setDate(picked,
                                                              action, newCus);
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            bottom: 15),
                                                        padding: EdgeInsets.symmetric(
                                                            vertical:
                                                                ScreenUtil()
                                                                    .setHeight(
                                                                        15),
                                                            horizontal:
                                                                ScreenUtil()
                                                                    .setWidth(
                                                                        15)),
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color: model
                                                                        .date1err
                                                                    ? Colors.red
                                                                    : Color(
                                                                        0xFFD1D1D1),
                                                                width: 2.0),
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    ScreenUtil()
                                                                        .setWidth(
                                                                            5))),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              margin: EdgeInsets.only(
                                                                  right: ScreenUtil()
                                                                      .setWidth(
                                                                          15)),
                                                              child: SvgPicture.asset(
                                                                  'assets/icons/calendar.svg',
                                                                  color: action ==
                                                                          'debit'
                                                                      ? BrandColors
                                                                          .secondary
                                                                      : Theme.of(
                                                                              context)
                                                                          .textSelectionColor),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                model.newDate ??
                                                                    AppLocalizations.of(
                                                                            context)
                                                                        .selectDueDate,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline6
                                                                    .copyWith(
                                                                      fontSize:
                                                                          ScreenUtil()
                                                                              .setSp(16),
                                                                      color: action ==
                                                                              'debit'
                                                                          ? BrandColors
                                                                              .secondary
                                                                          : Theme.of(context)
                                                                              .textSelectionColor,
                                                                    ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        Visibility(
                                          visible: update ? false : true,
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 5, left: 2),
                                                  child: Text(
                                                    AppLocalizations.of(context)
                                                        .description,
                                                    style: TextStyle(
                                                        fontSize:
                                                            SizeConfig.yMargin(
                                                                context, 2.2),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: ScreenUtil()
                                                          .setWidth(10),
                                                      vertical: ScreenUtil()
                                                          .setHeight(4)),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Color(0xFFD1D1D1),
                                                          width: 2.0),
                                                      borderRadius: BorderRadius
                                                          .circular(ScreenUtil()
                                                              .setWidth(5))),
                                                  child: Column(
                                                    children: <Widget>[
                                                      Focus(
                                                        onFocusChange:
                                                            (hasFocus) {
                                                          if (hasFocus) {
                                                            model.controller.animateTo(
                                                                model.controller.position.maxScrollExtent-250,
                                                                duration:
                                                                    new Duration(
                                                                        milliseconds:
                                                                            500),
                                                                curve: Curves
                                                                    .easeOut);
                                                          }
                                                        },
                                                        child: TextFormField(
                                                          textCapitalization:
                                                              TextCapitalization
                                                                  .sentences,

                                                          focusNode:
                                                              model.descFocus,
                                                          //controller: _controller,
                                                          maxLines: null,
                                                          maxLengthEnforced:
                                                              false,
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          decoration:
                                                              new InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            focusedBorder:
                                                                InputBorder
                                                                    .none,
                                                            enabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            errorBorder:
                                                                InputBorder
                                                                    .none,
                                                            disabledBorder:
                                                                InputBorder
                                                                    .none,
                                                            hintText: AppLocalizations
                                                                    .of(context)
                                                                .enterDescription,
                                                            hintStyle: TextStyle(
                                                                fontSize:
                                                                    ScreenUtil()
                                                                        .setSp(
                                                                            15)),
                                                          ),
                                                          textInputAction: TextInputAction.next,
                                                          // onSubmitted: (value) {
                                                          //   _controller.clear();
                                                          //   model.addItem(action, update);
                                                          // },
                                                          onChanged:
                                                              model.updateItem,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: Color(0xFFD1D1D1),
                              thickness: update ? 0 : 1,
                            ),
                            Visibility(
                              visible: newCus,
                              child: Container(
                                //margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: ScreenUtil().setHeight(15)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: 5, left: 2),
                                            child: Text(
                                              AppLocalizations.of(context)
                                                  .customerName,
                                              style: TextStyle(
                                                  fontSize: SizeConfig.yMargin(
                                                      context, 2.2),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Focus(
                                            onFocusChange: (hasFocus) {
                                              if (hasFocus) {
                                                model.controller.animateTo(
                                                    model.controller.position
                                                        .maxScrollExtent,
                                                    duration: new Duration(
                                                        milliseconds: 500),
                                                    curve: Curves.easeInOut);
                                                // print(controller.position
                                                //     .viewportDimension);
                                                // controller.jumpTo(controller
                                                //     .position
                                                //     .viewportDimension);
                                                //controller.animateTo(100,duration: Duration(milliseconds: 500), curve: Curves.ease);
                                              }
                                            },
                                            child: TextFormField(
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              controller:
                                                  model.searchController,
                                              maxLines: null,
                                              maxLengthEnforced: false,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6
                                                  .copyWith(
                                                      color: action == 'debit'
                                                          ? BrandColors
                                                              .secondary
                                                          : Theme.of(context)
                                                              .textSelectionColor,
                                                      fontSize:
                                                          SizeConfig.yMargin(
                                                              context, 2),
                                                      fontWeight:
                                                          FontWeight.bold),
                                              decoration: new InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFD1D1D1),
                                                      width: 2.0),
                                                ),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFD1D1D1),
                                                      width: 2.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFD1D1D1),
                                                      width: 2.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: action == 'debit'
                                                          ? BrandColors
                                                              .secondary
                                                          : BrandColors.primary,
                                                      width: 2.0),
                                                ),
                                                errorBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.red,
                                                      width: 2.0),
                                                ),
                                                hintText:
                                                    AppLocalizations.of(context)
                                                        .enterCustomerName,
                                                hintStyle: TextStyle(
                                                    fontSize:
                                                        SizeConfig.yMargin(
                                                            context, 2)),
                                                prefixIcon: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: ScreenUtil()
                                                          .setHeight(11)),
                                                  child: SvgPicture.asset(
                                                    'assets/images/phone.svg',
                                                    color: Theme.of(context)
                                                        .cursorColor,
                                                  ),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: ScreenUtil()
                                                            .setHeight(20)),
                                              ),
                                              textInputAction:
                                                  TextInputAction.next,
                                              onChanged: (value) => model
                                                  .updateName(value, action),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    for (var item in model.contactsList)
                                      model.name != null && model.shownames
                                          ? MyListTile(
                                              onTap: () => model.setName(item),
                                              action: action,
                                              leading: Center(
                                                  child: CircleAvatar(
                                                child: Text(
                                                  '${item.displayName[0].toUpperCase()}',
                                                  style: TextStyle(
                                                    color: action == 'debtor'
                                                        ? BrandColors.primary
                                                        : BrandColors.secondary,
                                                    fontSize:
                                                        SizeConfig.yMargin(
                                                            context, 2),
                                                  ),
                                                ),
                                                radius: SizeConfig.xMargin(
                                                    context, 6),
                                                backgroundColor:
                                                    action == 'debt'
                                                        ? BrandColors.primary
                                                            .withOpacity(0.3)
                                                        : BrandColors.secondary
                                                            .withOpacity(0.3),
                                              )),
                                              title: Text(
                                                '${item.displayName}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        SizeConfig.yMargin(
                                                            context, 1.9)),
                                              ),
                                              // child: Text(
                                              // 'Add new customer',
                                              // style: TextStyle(color: action == 'debit' ? BrandColors.secondary : BrandColors.primary, fontSize: SizeConfig.yMargin(context, 2)),
                                              subtitle: Text(
                                                '${item.phone.isNotEmpty ? item.phone : 'No number'}',
                                                style: TextStyle(
                                                    color: ThemeColors
                                                        .gray.shade600,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:
                                                        SizeConfig.yMargin(
                                                            context, 2)),
                                              ),
                                            )
                                          : SizedBox(),
                                    model.contactsList.length == 0 &&
                                            model.name != null
                                        ? model.manual
                                            ? SizedBox(
                                                height: model.manual
                                                    ? 0
                                                    : MediaQuery.of(context)
                                                        .viewInsets
                                                        .bottom,
                                              )
                                            : Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 50),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          bottom: 20),
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                    context)
                                                                .noResultFoundFor +
                                                            '\'${model.name}\'',
                                                        style: TextStyle(
                                                            fontSize: SizeConfig
                                                                .yMargin(
                                                                    context,
                                                                    2)),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () =>
                                                          model.setManual(),
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15,
                                                                horizontal: 15),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: action ==
                                                                    'debit'
                                                                ? BrandColors
                                                                    .secondary
                                                                    .withOpacity(
                                                                        0.2)
                                                                : BrandColors
                                                                    .primary
                                                                    .withOpacity(
                                                                        0.2)),
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)
                                                              .addNewCustomer,
                                                          style: TextStyle(
                                                              color: action ==
                                                                      'debit'
                                                                  ? BrandColors
                                                                      .secondary
                                                                  : BrandColors
                                                                      .primary,
                                                              fontSize: SizeConfig
                                                                  .yMargin(
                                                                      context,
                                                                      2)),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                        : SizedBox(),
                                    Visibility(
                                      visible: model.manual,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Color(0xff77869e),
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(4.0)),
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: InternationalPhoneNumberInput(
                                            onInputChanged: (PhoneNumber number) {
                                              model.number = number;
                                              //model.updateNumber(action);
                                            },
                                            onInputValidated: (value) {
                                              if(value) {
                                                model.updateNumber(action);
                                              }
                                            },
                                            ignoreBlank: false,
                                            errorMessage:
                                                AppLocalizations.of(context)
                                                    .invalidPhoneNo,
                                            selectorType:
                                                PhoneInputSelectorType.DIALOG,
                                            selectorTextStyle: TextStyle(
                                                color: Theme.of(context)
                                                    .cursorColor),
                                            initialValue: model.number,
                                            textFieldController: model.inputNumberController,
                                            inputBorder: InputBorder.none,
                                          ),
                                        ),
                                        // Row(
                                        //   mainAxisSize: MainAxisSize.min,
                                        //   children: <Widget>[
                                        //     Padding(
                                        //       padding: const EdgeInsets.all(8.0),
                                        //       child: DropdownButton<String>(
                                        //         underline: Container(),
                                        //         value: model.dropDownValue,
                                        //         items: model.countryCode
                                        //             .map<DropdownMenuItem<String>>((String value) {
                                        //           return DropdownMenuItem<String>(
                                        //             value: value,
                                        //             child: Text(value),
                                        //           );
                                        //         }).toList(),
                                        //         onChanged: (String newValue) {
                                        //           model.updateCountryCode(newValue);
                                        //         },
                                        //         icon: Icon(Icons.arrow_drop_down,
                                        //             color: Theme.of(context).cursorColor),
                                        //       ),
                                        //     ),
                                        //     Container(
                                        //         height: 24.0,
                                        //         decoration: BoxDecoration(
                                        //             border: Border(
                                        //                 left: BorderSide(color: Color(0xff77869e))))),
                                        //     Expanded(
                                        //       child: TextField(
                                        //         textAlign: TextAlign.left,
                                        //         keyboardType: TextInputType.number,
                                        //         decoration: InputDecoration(
                                        //           hintText: 'Mobile Number',
                                        //           border: OutlineInputBorder(borderSide: BorderSide.none),
                                        //         ),
                                        //         controller: phoneNumber,
                                        //         onChanged: model.updateContact,
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: model.name != null
                                          ? 0
                                          : MediaQuery.of(context).viewInsets.bottom > 0 ? SizeConfig.yMargin(context, 100) *
                                              0.3 : SizeConfig.yMargin(context, 100) *
                                              0.8,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: () {
                        model.addtransaction(action, update, newCus);
                        // reminders.sendNotificationOnce(
                        //     0,
                        //     'Reminder: ',
                        //     action == 'credit'
                        //         ? AppLocalizations.of(context).youOwe +
                        //             '${model.contact.name}' +
                        //             model.amount.round().toString()
                        //         : '${model.contact.name}' +
                        //             AppLocalizations.of(context).owesYou +
                        //             model.amount.round().toString(),
                        //     action == 'debit' ? model.dueDate : model.dueDate);
                      }, //Todo: Save User Input
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setHeight(15)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: model.save
                              ? action == 'debit'
                                  ? BrandColors.secondary
                                  : BrandColors.primary
                              : action == 'debit'
                                  ? BrandColors.secondary.withOpacity(0.5)
                                  : BrandColors.primary.withOpacity(0.5),
                        ),
                        width: width,
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context).save,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    fontSize: ScreenUtil().setSp(16),
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
        viewModelBuilder: () => AddDebtCreditViewModel());
  }
}

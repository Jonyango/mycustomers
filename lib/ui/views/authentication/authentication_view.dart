import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

import '../../../core/mixings/validators.dart';
import '../../widgets/shared/custom_raised_button.dart';
import '../../widgets/shared/social_icon.dart'; 
import 'authentication_viewmodel.dart';

class AuthenticationView extends StatelessWidget with Validators {
  /// A reusable text style
  /// Can be moved to a mixin or constant
  final regularTextStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 14,
    color: Colors.black,
  );

  /// Reusable height space weights
  /// Can be moved to a mixin or constant
  final mediumVerticalHeight = SizedBox(
    height: 16.0,
  );

  final smallVerticalHeight = SizedBox(
    height: 8.0,
  );

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            // reverse: true,
            // physics: NeverScrollableScrollPhysics(),
            child: Container(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 600.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            'assets/images/auth_background.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Positioned(
                  //   right: 0.h,
                  //   top: 250.h,
                  //   left: 0.w,
                  //   child: Text(
                  //     'Last Step, I \n promise',
                  //     style: TextStyle(
                  //         fontSize: 40.sp,
                  //         color: Color(0xFF333CC1),
                  //         fontWeight: FontWeight.bold),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'What\'s The Name Of Your Company',
                            style: Theme.of(context).textTheme.headline5.copyWith(
                                fontSize: ScreenUtil()
                                    .setSp(70, allowFontScalingSelf: true),
                                fontWeight: FontWeight.w400),
                          ),
                          // _CompanyForm(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {}, // model.updatePage,
                                child: Container(
                                  width: 160.w,
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xFF000E66),
                                  ),
                                  child: Center(
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: Colors.white,
                                        ),
                                        onPressed: null),
                                  ),
                                ),
                              ),
                              Container(
                                width: 600.h,
                                height: 120.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xFF333CC1),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Finish',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            .copyWith(
                                                fontSize: ScreenUtil().setSp(60,
                                                    allowFontScalingSelf: true),
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(width: 8),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => AuthenticationViewModel(),
    );
  }
}

@override
Widget modalBottomWidget() {
  return Container(
    height: 1520.h,
    color: Color(0xff757575),
    child: Container(
      padding: EdgeInsets.all(50.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100.w),
          topRight: Radius.circular(100.w),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 10),
            Text(
              'PASTE FROM SMS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Text(
                '0349',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: ScreenUtil.screenHeightDp * 0.25,
              width: ScreenUtil.screenWidthDp,
              padding: EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  topRight: Radius.circular(24.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: PinCodeTextField(
                      length: 4,
                      obsecureText: false,
                      animationType: AnimationType.scale,
                      textInputType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.underline,
                        selectedColor: Colors.black,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        borderWidth: 1,
                        fieldWidth: ScreenUtil.screenWidthDp * 0.15,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      //errorAnimationController: errorController,
                      //controller: textEditingController,
                      autoDisposeControllers: false,
                      onCompleted: (v) {},
                      onChanged: (value) {},
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please enter 4-digit code we sent on \nyour number as SMS',
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Scaffold(
//   body: AnnotatedRegion<SystemUiOverlayStyle>(
//     value: SystemUiOverlayStyle.light,
//     child: Column(
//       children: <Widget>[
//         Container(
//           height: 500.h,

//           decoration: BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/auth_background.png'),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: SafeArea(
//             child: Center(
//               child: Image.asset('assets/images/logo.png'),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
//   bottomSheet: Container(
//     height: ScreenUtil.screenHeightDp * 0.4,
//     width: ScreenUtil.screenWidthDp,
//     padding: EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Text(
//           'Please, Enter your Phone number',
//           style: regularTextStyle,
//         ),
//         mediumVerticalHeight,
//         IntrinsicHeight(
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             child: Row(
//               children: <Widget>[
//                 DropdownButton<String>(
//                   value: model.dropdownValue,
//                   icon: Icon(Icons.keyboard_arrow_down),
//                   iconSize: 16,
//                   elevation: 16,
//                   style: regularTextStyle,
//                   onChanged: model.setDropdownValue,
//                   underline: Container(
//                     color: Colors.transparent,
//                   ),
//                   items:
//                       model.dropdownItems.map<DropdownMenuItem<String>>(
//                     (String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Padding(
//                           padding: EdgeInsets.only(left: 16.0),
//                           child: Text(value),
//                         ),
//                       );
//                     },
//                   ).toList(),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 8.0),
//                   child: VerticalDivider(
//                     color: Colors.black,
//                   ),
//                 ),
//                 Expanded(
//                   child: TextFormField(
//                     keyboardType: TextInputType.number,
//                     validator: validatePhoneNumber,
//                     onFieldSubmitted: (String value) {},
//                     onSaved: (String value) {},
//                     decoration: InputDecoration(
//                       hintText: 'Phone number',
//                       border: InputBorder.none,
//                       hintStyle: TextStyle(
//                         fontFamily: 'Lato',
//                         fontSize: 14,
//                       ),
//                       contentPadding: EdgeInsets.all(8.0),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         mediumVerticalHeight,
//         Text(
//           'Or Continue with your social account',
//           textAlign: TextAlign.center,
//           style: TextStyle(
//             fontFamily: 'Lato',
//             fontSize: 14,
//             fontWeight: FontWeight.w300,
//             color: Colors.black,
//           ),
//         ),
//         smallVerticalHeight,
//         Expanded(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               SocialIconButton(
//                 onTap: () {},
//                 socialIconUrl: 'assets/images/google_icon.png',
//               ),
//               SocialIconButton(
//                 onTap: () {},
//                 socialIconUrl: 'assets/images/facebook_icon.png',
//               ),
//               SocialIconButton(
//                 onTap: () {},
//                 socialIconUrl: 'assets/images/apple_icon.png',
//               ),
//             ],
//           ),
//         ),
//         smallVerticalHeight,
//         CustomRaisedButton(
//           label: 'Next',
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               builder: (BuildContext context) => SingleChildScrollView(
//                 child: Container(
//                     padding: EdgeInsets.only(
//                         bottom: MediaQuery.of(context).viewInsets.bottom),
//                     child: modalBottomWidget()),
//               ),
//             );
//           },
//         )
//       ],
//     ),
//   ),
// ),
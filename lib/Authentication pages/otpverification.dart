import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shellcode2/Authentication pages/signuppage.dart';
import 'package:shellcode2/colors.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

const String _heroAddTodo = 'add-todo-hero';
class _OtpVerificationState extends State<OtpVerification> {
  final phoneController = TextEditingController();
  String title1 ='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listenOtp();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightbg,
      body: Container(
        child: Column(
          children:[
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80),),
                  gradient: LinearGradient(
                    colors: [left,middle,Colors.purple],
                  )
              ),
              child:
              Center(
                child: Text(
                  'OTP Verification', style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  Text(
                    'Enter the OTP sent to Your Number', style: TextStyle(color: Colors.white,fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                      child: PinFieldAutoFill(
                        decoration: UnderlineDecoration(
                          colorBuilder: FixedColorBuilder(Colors.purple)
                        ),
                        codeLength: 6,
                        onCodeChanged: (val){

                        },
                      )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Din't Receive the OTP ?",style: TextStyle(
                          fontSize: 12,
                          color: Colors.white
                      ),),
                      GestureDetector(
                        onTap: (){
                        },
                        child: Text(" RESEND OTP",style: TextStyle(
                            fontSize: 12,
                            color: Colors.purple
                        ),),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children:[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.of(context).push(HeroDialogRoute(builder: (context) {
                              return _AddTodoPopupCard();
                            }, settings:  ModalRoute.of(context)!.settings));
                          },
                          child: Text('VERIFY & PROCEED',style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.purple[600]),
                              padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
                              textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

void _listenOtp() async{
  await SmsAutoFill().listenForCode;
}

class HeroDialogRoute<T> extends PageRoute<T> {
  /// {@macro hero_dialog_route}
  HeroDialogRoute({
    required WidgetBuilder builder,
    required RouteSettings settings,
    bool fullscreenDialog = false,
  })  : _builder = builder,
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder _builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return child;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return _builder(context);
  }

  @override
  String get barrierLabel => 'Popup dialog open';
}
class _AddTodoPopupCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroAddTodo,
          child: Material(
            color: lightbg,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(CupertinoIcons.checkmark_circle_fill,color: Colors.green,),
                        Text(
                          ' Registered Successfully!',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Dear customer, Thank you for registering with us, your account is pending approval and you will be notified once it is approved.',
                      style: TextStyle(
                        height: 1.5,
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                      },
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text('OK',style: TextStyle(
                            height: 1.5,
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                        ),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

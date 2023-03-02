import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swish/core/images/images.dart';
import '../../../auth/presentation/pages/login_screen.dart';

class InitPageScreen extends StatefulWidget {
  const InitPageScreen({Key? key}) : super(key: key);

  @override
  State<InitPageScreen> createState() => _InitPageScreenState();
}

class _InitPageScreenState extends State<InitPageScreen> {

  late PageController controller;
  var _currentPage = 0;
  @override
  void initState() {
    controller = PageController(initialPage: 0);
    _currentPage = 0;
    controller.addListener(() {
      setState(() {
        _currentPage = controller.page?.toInt()??0;
      });
    });
    super.initState();
  }

  toPageLogin(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              width: double.infinity ,
              height: 400,
              child: PageView(
                controller: controller ,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(
                                Images.bgInitPage.patch))
                        ),
                      ),
                      Align(
                        alignment:Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              ShowMedia(Images.art),
                              SizedBox(height: 27),
                              Text("MT Token", style: TextStyle(
                                  color: Color(0xff9B51E0),
                                  fontSize: 22
                              ),),
                              SizedBox(height: 7),
                              SizedBox(
                                width: 270,
                                child: Text("Control all your tokens in one secure place.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(
                                Images.bgInitPage.patch))
                        ),
                      ),
                      Align(
                        alignment:Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              ShowMedia(Images.phone),
                              SizedBox(height: 27),
                              Text("Manage Token", style: TextStyle(
                                  color: Color(0xff9B51E0),
                                  fontSize: 22
                              ),),
                              SizedBox(height: 7),
                              SizedBox(
                                width: 270,
                                child: Text("Make transactions from this app to your bank.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Spacer(),
            Container(
              width: double.infinity,
              height: 110,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 10),
                    blurRadius: 68,
                    spreadRadius: -4
                  )
                ],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25),
                topRight: Radius.circular(25))
              ),
              child: Center(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 43.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                       if(_currentPage==0) toPageLogin();
                      },
                      child: Text("Skip", style: TextStyle(
                          color: _currentPage==0?const
                          Color(0xff8B8B8B):Colors.white,
                          fontSize: 20),),
                    ),
                    _pageIndicator(),
                    GestureDetector(
                      onTap: (){
                        if(_currentPage!=0) {
                          toPageLogin();
                        } else {
                          controller.nextPage(duration: 0.2.seconds, curve: Curves.easeIn);
                        }
                      },
                      child: const Text("Next", style: TextStyle(
                          color: Color(0xff4F89EA), fontSize: 20),),
                    ),
                  ],
                ),
              )),
            )
          ],
        ),
      )
    );
  }


  _pageIndicator(){
    return Row(
      children: [
        _indicator(0),
        const SizedBox(width: 2),
        _indicator(1),
      ],
    );
  }
  
  _indicator(index){
    bool page = (_currentPage)==index;
    var color = page?const Color(0xff2260F5):const Color(0xff9BB9FF);
    double width = page?22:11;
    return AnimatedContainer(
      width: width,
      height: 4,
      duration: 0.2.seconds,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: color
      ),
    );
  }
}

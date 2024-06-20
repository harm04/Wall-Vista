import 'package:flutter/material.dart';
import 'package:wall_vista/pages/home.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  'assets/images/onBoardingIcon.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(1),
                      spreadRadius: 65,
                      blurRadius: 200,
                      blurStyle: BlurStyle.normal,
                    )
                  ]),
                ),
              ),
              Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Wrap(
                    children: [
                      Center(
                          child: Text(
                        'Eplore 4k Wallpapers',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          'Explore, Experiment Ultra 4k Wallpapers Now!',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        },
                        child: Card(
                          color: Colors.black,
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                                child: Text(
                              'Explore',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            )),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }
}

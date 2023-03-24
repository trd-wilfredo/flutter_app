import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AboutUs extends StatelessWidget {
  dynamic fonts;
  AboutUs({
    Key? key,
    required this.fonts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              Text('Study ', style: fonts['fredoka01']),
              Text(
                'App',
                style: fonts['birthstone01'],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(35, 40, 35, 20),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'all about Study ',
                              style: fonts['fredoka']),
                          TextSpan(text: 'App', style: fonts['birthstone']),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Text(
                      "Study app is designed to help you connect and communicate seamlessly with your contacts, whether it's for personal or professional use. Stay connected on the go and never miss a message with our app.",
                      textAlign: TextAlign.center,
                      style: fonts['leagueSpartan']),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: 400,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 210,
                          aspectRatio: 16 / 9,
                        ),
                        items: [
                          'assets/monster-10.png',
                          'assets/monster-19.png',
                          'assets/monster-7.png',
                          'assets/monster-8.png',
                          'assets/monster-4.png',
                        ].map((i) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              width: 200,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(i),
                                  // if (i == 'assets/monster-10.png')
                                  // if (i == 'assets/monster-6.png')
                                  // if (i == 'assets/monster-7.png')
                                  // if (i == 'assets/monster-8.png')
                                  // if (i == 'assets/monster-4.png')
                                ],
                              ),
                            );
                          });
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 35, 20),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'our mission', style: fonts['fredoka']),
                          // TextSpan(text: 'n', style: fonts['birthstone']),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 400,
                  child: Text(
                      "Our mission is to provide a seamless and secure communication experience that connects people and empowers them to achieve their goals.",
                      textAlign: TextAlign.center,
                      style: fonts['leagueSpartan']),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 40, 35, 0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'our office', style: fonts['fredoka']),
                          // TextSpan(text: 'ce', style: fonts['birthstone']),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Text(
                      "Comprised of professionals with a shared passion for creating the best communication app, we are committed to helping people connect and communicate seamlessly. We believe that effective communication is essential for success in both personal and professional life. We take pride in our work and are dedicated to ongoing innovation and improvement. Feedback from our users is highly valued and taken into consideration when implementing updates and new feature",
                      textAlign: TextAlign.center,
                      style: fonts['leagueSpartan']),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 40, 35, 0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'team', style: fonts['fredoka']),
                          // ),
                          // TextSpan(
                          //   text: 'm',
                          //   style: TextStyle(
                          //     color: Color(0xFF5ACC02),
                          //     fontFamily: 'FeatherWrite',
                          //     fontSize: 50,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Text(
                    "Our office is located in the bustling city of Mandaue in the beautiful island of Cebu, Philippines. At our office, we foster a culture of teamwork, respect, and innovation. We believe that by working together, we can achieve great things and make a positive impact in the world. We encourage our team members to bring their unique skills and perspectives to the table and provide ongoing opportunities for professional growth and development.",
                    textAlign: TextAlign.center,
                    style: fonts['leagueSpartan'],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 40, 35, 0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'culture', style: fonts['fredoka']),
                          // TextSpan(
                          //   text: 're',
                          //   style: TextStyle(
                          //     color: Color(0xFF5ACC02),
                          //     fontFamily: 'FeatherWrite',
                          //     fontSize: 50,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Text(
                      "We believe that a positive and supportive work culture is the key to building a successful and fulfilling workplace. We're dedicated to fostering a culture of respect, collaboration, and innovation that empowers our team members to thrive. One of the core values of our culture is respect. We believe that every team member deserves to be treated with dignity and fairness, and we strive to create a work environment that is free from discrimination, harassment, or prejudice. We encourage open and honest communication, and we value feedback from our team members to help us continuously improve and grow.",
                      textAlign: TextAlign.center,
                      style: fonts['leagueSpartan']),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 40, 35, 0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Firebase Storage',
                              style: fonts['fredoka']),
                          // TextSpan(
                          //   text: 'ge',
                          //   style: TextStyle(
                          //     color: Color(0xFF5ACC02),
                          //     fontFamily: 'FeatherWrite',
                          //     fontSize: 50,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Text("Firebase Storage",
                      textAlign: TextAlign.center,
                      style: fonts['leagueSpartan']),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 40, 35, 0),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Firebase Database',
                              style: fonts['fredoka']),
                          // TextSpan(
                          //   text: 'se',
                          //   style: TextStyle(
                          //     color: Color(0xFF5ACC02),
                          //     fontFamily: 'FeatherWrite',
                          //     fontSize: 50,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 400,
                  child: Text("Firebase Database",
                      textAlign: TextAlign.center,
                      style: fonts['leagueSpartan']),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// Container(
//   alignment: Alignment.center,
//   child: Container(
//     color: const Color(0xffe67e22),
//     child: Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Text(
//                 'all about Study',
//                 style: TextStyle(
//                   color: Color(0xFF5ACC02),
//                   fontFamily: 'FeatherBold',
//                   fontSize: 60,
//                 ),
//               ),
//               Text(
//                 ' App',
//                 style: TextStyle(
//                   color: Color(0xFF5ACC02),
//                   fontFamily: 'FeatherWrite',
//                   fontSize: 60,
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     ),
//   ),

// child: ConstrainedBox(
//   constraints: BoxConstraints(
//     minWidth: 5.0,
//   ),
//   child: DecoratedBox(
//     decoration: BoxDecoration(color: Colors.red),
//   ),
// ),

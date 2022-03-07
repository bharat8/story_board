import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:story_board/utils/color_utils.dart';
import 'package:http/http.dart' as http;
import 'package:story_board/widgets/clip_shadow_path.dart';
import 'package:story_board/widgets/custom_clipper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.robotoCondensed().fontFamily,
        scaffoldBackgroundColor: ColorUtils.kBackgroundColor,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool isFinalState = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            AnimatedBuilder(
                animation: _controller,
                builder: (context, anim) {
                  final double progress = _animation.value;
                  final double heightScaling =
                      0.405 + (0.307 - 0.405) * progress;
                  final double height =
                      MediaQuery.of(context).size.height * heightScaling;
                  return ClipPath(
                    clipper: BezierClipper(progress),
                    child: Container(
                      color: isFinalState ? Colors.red : Colors.orange,
                      height: height,
                      width: size.width,
                    ),
                  );
                }),
            Container(
              child: Center(
                child: RaisedButton(
                  child: Text("Toggle"),
                  onPressed: () {
                    setState(() {
                      isFinalState = !isFinalState;
                      if (!isFinalState)
                        _controller.reverse(from: 1.0);
                      else
                        _controller.forward(from: 0.0);
                    });
                  },
                ),
              ),
            ),
            // if (change == false)
            //   ClipShadowPath(
            //     shadow: const BoxShadow(
            //       color: Colors.black26,
            //       offset: Offset(4, 4),
            //       blurRadius: 4,
            //       spreadRadius: 4,
            //     ),
            //     clipper: BigClipper(),
            //     child: GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           change = true;
            //         });
            //       },
            //       child: Container(
            //         color: Colors.orange,
            //       ),
            //     ),
            //   ),
            // if (change == true)
            //   ClipShadowPath(
            //     shadow: const BoxShadow(
            //       color: Colors.black38,
            //       offset: Offset(4, 4),
            //       blurRadius: 4,
            //       spreadRadius: 4,
            //     ),
            //     clipper: SmallClipper(),
            //     child: GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           change = false;
            //         });
            //       },
            //       child: Container(
            //         color: Colors.red,
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  List<String> imageUrls = [];
  late int currentIndex;
  late double dragX;
  late double angle;
  late double dragY;

  @override
  void initState() {
    getImageUrls();
    dragX = Alignment.bottomCenter.x;
    angle = 0;
    dragY = Alignment.bottomCenter.y;
    super.initState();
  }

  getImageUrls() async {
    imageUrls = [
      "https://i.picsum.photos/id/445/3000/3000.jpg?hmac=b7xJ8KK_hoN2CeSltV4mwG_8-tK0NuzXcvYNey7Ryp8",
      "https://i.picsum.photos/id/693/3000/3000.jpg?hmac=9dxNUOyD_Xv7S7ooJq0LIUaLyQDTiIb9oSBAPLkM3U4",
      "https://i.picsum.photos/id/851/3000/3000.jpg?hmac=dJY89sN9bNQ2yB0b6I2cwDJo9YX8GjJbhmaGYfd4NXk",
      "https://i.picsum.photos/id/107/3000/3000.jpg?hmac=8TYJ9sQgnPFbVtk2eq-EIxkgnZH40Z_jFQBzxX9rU_o",
      "https://i.picsum.photos/id/64/3000/3000.jpg?hmac=9MgFqYdUe3FDVVJWmLzla7ZPnG1hTvqLYOvZINWA72c",
      "https://i.picsum.photos/id/772/3000/3000.jpg?hmac=wVmW1fbV3y06ePHudg8NjtUrzgGNljTGUIWp07JoFhs",
      "https://i.picsum.photos/id/882/3000/3000.jpg?hmac=KPlGsy6fmi-sen4kPhHUgGLglkGs9bCN9XK5LpqLYJU",
      "https://i.picsum.photos/id/47/3000/3000.jpg?hmac=jycTAU8Bcn6gNvxarekwkw0ctYwKqbe3YOaGCHzcPmw",
      "https://i.picsum.photos/id/83/3000/3000.jpg?hmac=YIzn4V7OHLWo72RPokkqtCkWWTnktWNGU1Eq-NCUqrs",
      "https://i.picsum.photos/id/698/3000/3000.jpg?hmac=ugBHwzI3G0dpHhxUOCxXKw_yGLfYGMZinSJKmtU3ziA",
      "https://i.picsum.photos/id/535/3000/3000.jpg?hmac=_QO2HZbVLwF0YT8XSrlFwwUMLBc-K6023me3DIGkAwE",
      "https://i.picsum.photos/id/909/3000/3000.jpg?hmac=Wsa7Ht7CFT2PRddiPH_Qzbk0QOemt8q1AbPtQ735Nqk",
      "https://i.picsum.photos/id/307/3000/3000.jpg?hmac=IoQJVzP6C_kKRXMKJa3fBK5uxlIlVLocqgkVkZP769Y",
      "https://i.picsum.photos/id/223/3000/3000.jpg?hmac=PqE9ok5JGjAZ9pX9J4R0NWpQlcDc5ToDQXIhAfgWYIM",
      "https://i.picsum.photos/id/532/3000/3000.jpg?hmac=wg7R2pLrvm9Pmr72ByR2zl2PL2vPoj_3ctHpjU5zV70",
      "https://i.picsum.photos/id/874/3000/3000.jpg?hmac=7UgrZ62FLtkJXwfJ5usxFtZeFDxV3CNwazAY9dhzMbE",
      "https://i.picsum.photos/id/34/3000/3000.jpg?hmac=3jXUNIBflOuuyQJQtQLAMdJ1VduG2DSHKZ8SIBxtiEU",
      "https://i.picsum.photos/id/330/3000/3000.jpg?hmac=RZ3gn7hb-xUeOrkw7ne3s8p5yaIdxNL0VOva7m2ou1c",
      "https://i.picsum.photos/id/390/3000/3000.jpg?hmac=O6DUpQ8VS5b6KirTDMqjbowH89pvkDsftT9jcgMwtYA",
      "https://i.picsum.photos/id/1051/3000/3000.jpg?hmac=_rKTOilBXGrJpllPGN155m2dXnerQ4_RoyG3HJ6KZ1o",
    ];
    currentIndex = imageUrls.length - 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (currentIndex - 1 > 0)
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 1,
                      offset: Offset.zero,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Image.network(
                  imageUrls[currentIndex - 1],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (currentIndex > 0)
            Center(
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (details.delta.dx > 0) {
                    dragX += 0.5;
                    dragX += 0.25;
                    angle += 0.2;
                  } else {
                    dragX -= 0.5;
                    dragX -= 0.25;
                    angle -= 0.2;
                  }
                  setState(() {});
                },
                onPanEnd: (details) {
                  setState(() {
                    dragX = 0;
                    angle = 0;
                    currentIndex -= 1;
                  });
                },
                child: Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.translationValues(0, 0, 0)
                    ..translate(dragX)
                    ..translate(dragX)
                    ..rotateZ(angle * 0.0174533),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 1,
                          offset: Offset.zero,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: Image.network(
                      imageUrls[currentIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            )
          else
            Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    currentIndex = imageUrls.length - 1;
                  });
                },
                child: Container(
                  color: Colors.blue[200],
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.replay, color: Colors.white),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Reload",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

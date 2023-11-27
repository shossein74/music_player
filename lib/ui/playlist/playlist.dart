import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_player/gen/assets.gen.dart';
import 'package:music_player/gen/fonts.gen.dart';
import 'dart:math' as math;

import 'package:music_player/ui/home/home.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    /*final List songList = <Widget>[
      SongItem(
        theme: theme,
        image: Image.asset("assets/images/song_image4.png"),
        title: "Bye Bye",
        subtitle: "Marshmallow, Juice WRLD",
        time: "02:09",
      ),
      SongItem(
        theme: theme,
        image: Image.asset("assets/images/song_image5.png"),
        title: "I Like You",
        subtitle: "Post Mallone, Doja Cat",
        time: "04:03",
      ),
      SongItem(
        theme: theme,
        image: Image.asset("assets/images/song_image6.png"),
        title: "Fountains",
        subtitle: "Drake, Tems",
        time: "03:18",
      ),
      SongItem(
        theme: theme,
        image: Image.asset("assets/images/song_image7.png"),
        title: "Bye Bye",
        subtitle: "Marshmallow, Juice WRLD",
        time: "02:09",
      ),
      SongItem(
        theme: theme,
        image: Image.asset("assets/images/song_image8.png"),
        title: "I Like You",
        subtitle: "Post Mallone, Doja Cat",
        time: "04:03",
      ),
      SongItem(
        theme: theme,
        image: Image.asset("assets/images/song_image9.png"),
        title: "Fountains",
        subtitle: "Drake, Tems",
        time: "03:18",
      ),
      SongItem(
        theme: theme,
        image: Image.asset("assets/images/song_image1.png"),
        title: "Bye Bye",
        subtitle: "Marshmallow, Juice WRLD",
        time: "02:09",
      ),
      SongItem(
        theme: theme,
        image: Image.asset("assets/images/song_image2.png"),
        title: "I Like You",
        subtitle: "Post Mallone, Doja Cat",
        time: "04:03",
      ),
      SongItem(
        theme: theme,
        image: Image.asset("assets/images/song_image3.png"),
        title: "Fountains",
        subtitle: "Drake, Tems",
        time: "03:18",
      ),
      SongItem(
        theme: theme,
        image: Image.asset("assets/images/song_image1.png"),
        title: "Bye Bye",
        subtitle: "Marshmallow, Juice WRLD",
        time: "02:09",
      ),
      SongItem(
        theme: theme,
        image: Image.asset("assets/images/song_image2.png"),
        title: "I Like You",
        subtitle: "Post Mallone, Doja Cat",
        time: "04:03",
      ),
      SongItem(
        theme: theme,
        image: Image.asset("assets/images/song_image3.png"),
        title: "Fountains",
        subtitle: "Drake, Tems",
        time: "03:18",
      )
    ];*/

    return Scaffold(
      backgroundColor: const Color(0xff0F0817),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: RadialGradient(
                  colors: [
                    const Color.fromARGB(255, 155, 121, 241).withOpacity(0.22),
                    const Color.fromARGB(255, 155, 121, 241).withOpacity(0.08),
                    const Color.fromARGB(255, 155, 121, 241).withOpacity(0.01),
                  ],
                  center: Alignment.center,
                  radius: 0.95,
                  focal: const Alignment(-0.10, 0.1),
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 0.5, sigmaY: 0.5, tileMode: TileMode.clamp),
            ),
          ),
          Positioned.fill(
            child: Column(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(24),
                        bottomLeft: Radius.circular(24),
                      ),
                      child: Assets.images.playlistHeader.image(
                          width: size.width,
                          height: size.height * 0.4,
                          fit: BoxFit.fill),
                    ),
                    Container(
                      height: size.height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(24),
                          bottomLeft: Radius.circular(24),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xff000000).withOpacity(0.3),
                            const Color(0xff000000).withOpacity(0.4),
                            const Color(0xff000000).withOpacity(0.6),
                            const Color(0xff000000).withOpacity(0.7),
                            const Color(0xff000000).withOpacity(0.82),
                            const Color(0xff000000).withOpacity(1),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 58,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 24,
                          ),
                          SvgPicture.asset(
                            "assets/images/chevron_left.svg",
                            width: 22,
                            height: 22,
                          ),
                          Expanded(
                            child: Container(),
                          ),
                          SvgPicture.asset(
                            "assets/images/more_horizontal.svg",
                            width: 22,
                            height: 22,
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                        bottom: 58,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 16,
                            left: 16,
                            right: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        "R&B Playlist",
                                        style: theme.textTheme.bodyLarge
                                            ?.copyWith(
                                                fontWeight: FontWeight.w900,
                                                fontFamily:
                                                    FontFamily.urbanistBold,
                                                color: theme
                                                    .colorScheme.onBackground,
                                                fontSize: 20,
                                                letterSpacing: 2),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8),
                                      child: Text(
                                        "Chill your mind",
                                        style: theme.textTheme.labelMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color:
                                                    theme.colorScheme.onSurface,
                                                fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SvgPicture.asset(
                                "assets/icons/heart.svg",
                                width: 22,
                                height: 22,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              CircleGradientButton(
                                size: 54,
                                colors: const [
                                  Color(0xff842ED8),
                                  Color(0xff842ED8),
                                  Color(0xffDB28A9),
                                  Color(0xff9D1DCA),
                                  Color(0xff9D1DCA),
                                ],
                                icon: Icons.play_arrow_rounded,
                                onPressed: () => {},
                              )
                            ],
                          ),
                        )),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    primary: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        ListView.builder(
                          itemCount: 12,
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return Container(); //songList[index];
                          },
                        ),
                        const SizedBox(
                          height: 68,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircleGradientButton extends StatelessWidget {
  final double size;
  final List<Color> colors;
  final IconData icon;
  final VoidCallback onPressed;

  const CircleGradientButton({
    Key? key,
    required this.size,
    required this.colors,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double iconSize = size * 0.42;
    final double iconPadding = (size - iconSize) / 2.5;

    return InkWell(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: SweepGradient(
            colors: colors,
            center: Alignment.center,
            //focal: Alignment.center,
            //radius: 0.6,

            stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: iconSize,
                  color: Colors.white,
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(size / 2.0),
                onTap: onPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

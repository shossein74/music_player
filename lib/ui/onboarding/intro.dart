import 'package:flutter/material.dart';
import 'package:music_player/gen/assets.gen.dart';
import 'package:music_player/gen/fonts.gen.dart';
import 'package:music_player/ui/home/home.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
        body: Stack(
      children: [
        Assets.images.introBackground
            .image(width: size.width, height: size.height, fit: BoxFit.fill),
        Positioned(
            left: 0,
            right: 0,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Feel the beats",
                  style: theme.textTheme.headlineMedium!.copyWith(
                      color: theme.colorScheme.onBackground,
                      fontWeight: FontWeight.w700),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: size.width * 0.5,
                  child: Text(
                    "Emmerse yourself into the world of music today",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.colorScheme.onSurface,
                      fontFamily: FontFamily.urbanistLight,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 28),
                GradientButton(
                  text: "Continue",
                  theme: theme,
                  width: size.width * 0.5,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                ),
                const SizedBox(height: 48),
              ],
            )),
      ],
    ));
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.text,
    required this.theme,
    this.width = 0,
    this.height = 48,
    this.textStyle,
    this.rippleColor = Colors.white,
    this.borderRadiusSize = 24.0,
    this.onPressed,
  });

  final double width;
  final double height;
  final ThemeData theme;
  final String text;
  final TextStyle? textStyle;
  final Color rippleColor;
  final double borderRadiusSize;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width == 0 ? double.infinity : width,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [
            Color(0xff842ED8),
            Color(0xffDB28A9),
            Color(0xff9D1DCA),
          ],
          center: Alignment.center,
          radius: 8,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.transparent),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> state) {
            if (state.contains(MaterialState.pressed)) {
              return rippleColor.withOpacity(0.4);
            }
            return Colors.transparent;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadiusSize)),
            ),
          ),
        ),
        child: Text(
          text,
          style: theme.textTheme.bodyLarge!.copyWith(
            color: theme.colorScheme.onBackground,
            fontWeight: FontWeight.w600,
            fontFamily: FontFamily.urbanist,
          ),
        ),
      ),
    );
  }
}

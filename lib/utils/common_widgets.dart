import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget getGradientBackground() {
  return Container(
    width: 64,
    height: 64,
    decoration: const BoxDecoration(
      gradient: SweepGradient(
        center: Alignment(0.18, 1.04),
        startAngle: 0.28,
        endAngle: -0.84,
        colors: [Color(0xFF842ED7), Color(0xFFDA28A8), Color(0xFF9C1CC9)],
      ),
    ),
  );
}

class SvgIcon extends StatelessWidget {
  const SvgIcon({
    super.key,
    required this.assetName,
    this.onPressed,
    this.iconSize,
    this.borderRadius,
    this.paddingSize,
    this.iconColor,
  });

  final String assetName;
  final Function()? onPressed;
  final double? iconSize;
  final double? borderRadius;
  final double? paddingSize;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(borderRadius ?? 16),
      child: Padding(
        padding: EdgeInsets.all(paddingSize ?? 8.0),
        child: SvgPicture.asset(
          assetName,
          width: iconSize ?? 24,
          height: iconSize ?? 24,
          colorFilter: iconColor != null
              ? ColorFilter.mode(iconColor!, BlendMode.srcIn)
              : null,
        ),
      ),
    );
  }
}

class CustomTrackShapeSlider extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class KeepPageAlive extends StatefulWidget {
  const KeepPageAlive({super.key, required this.child});

  final Widget child;

  @override
  State<KeepPageAlive> createState() => _KeepPageAliveState();
}

class _KeepPageAliveState extends State<KeepPageAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}

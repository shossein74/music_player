import 'package:flutter/material.dart';

class SliderPlayList extends StatelessWidget {
  const SliderPlayList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return SizedBox(
      height: (size.width * 0.60).toDouble(),
      child: ListView.builder(
        itemCount: 3,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 0, right: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(left: 24, right: 8),
              child: SliderItem(
                theme: theme,
                image: "assets/images/slider_image1.png",
                title: "R&B Playlist",
                subtitle: "Chill your mind",
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: SliderItem(
                theme: theme,
                image: "assets/images/slider_image2.png",
                title: "Daily Mix2",
                subtitle: "Made for you",
              ),
            );
          }
        },
      ),
    );
  }
}

class SliderItem extends StatelessWidget {
  const SliderItem({
    super.key,
    required this.theme,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width * 0.45;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            image,
            width: imageSize,
            height: imageSize,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onBackground),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            subtitle,
            style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w300,
                color: theme.colorScheme.onSurface),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';

class MovieCard extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  final List<String>? genres;
  final double? rating;

  const MovieCard({
    Key? key,
    this.title,
    this.imageUrl,
    this.genres,
    this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: screenWidth * 0.95,
            height: screenWidth * 0.45,
            padding: EdgeInsets.only(
              left: screenWidth * 0.35,
              top: 15,
              bottom: 15,
            ),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? 'No Title',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  (genres ?? []).join(' | '),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: (rating ?? 0.0) > 7.5
                        ? AppColor.mediumSeaGreen
                        : AppColor.vividSkyBlue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '${rating?.toStringAsFixed(1) ?? 'N/A'} IMDb',
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl ??
                    'https://static.vecteezy.com/system/resources/previews/004/141/669/non_2x/no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image-coming-soon-sign-simple-nature-silhouette-in-frame-isolated-illustration-vector.jpg',
                width: screenWidth * 0.3,
                height: screenWidth * 0.5,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

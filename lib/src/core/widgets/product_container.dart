import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';

class ProductContainer extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final VoidCallback? onTap;
  final VoidCallback? onTapFavorite;
  final bool isFavorite;

  const ProductContainer({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    this.onTap,
    this.onTapFavorite,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.secondaryBackground,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Color(0x33000000),
            offset: Offset(0, 3),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                Image.network(image, width: double.infinity, fit: BoxFit.cover),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF343434).withOpacity(0.4),
                        const Color(0xFF343434).withOpacity(0.15),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 50,
                    width: 200,
                    color: AppColors.secondaryBackground,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
                          child: Text(
                            title,
                            maxLines: 1,
                            style: TextTheme.of(context).bodySmall,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 4, 0, 0),
                          child: Text(
                            price,
                            maxLines: 1,
                            style: TextTheme.of(context).bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onTap,
              ),
            ),
          ),
          FavoriteButton(onTapFavorite: onTapFavorite, isFavorite: isFavorite),
        ],
      ),
    );
    // FavoriteButton(onTapFavorite: onTapFavorite, isFavorite: isFavorite),
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    super.key,
    required this.onTapFavorite,
    required this.isFavorite,
  });

  final VoidCallback? onTapFavorite;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: CircleBorder(),
          onTap: onTapFavorite,
          child: Ink(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.secondaryBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? AppColors.error : AppColors.primaryText,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}

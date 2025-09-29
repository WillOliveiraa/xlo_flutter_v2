import 'package:flutter/material.dart';
import 'package:xlo_flutter_v2/src/core/theme/app_colors.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 54,
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 15, 16, 15),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  Icons.search_sharp,
                  color: AppColors.primaryText,
                  size: 24,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Text(
                    'Search here',
                    style: TextTheme.of(context).bodyMedium,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional(1, -1),
                    child: Icon(
                      Icons.tune,
                      color: AppColors.primaryText,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

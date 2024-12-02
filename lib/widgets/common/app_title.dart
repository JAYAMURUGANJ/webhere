import 'package:flutter/material.dart';
import 'package:webhere/utils/constants/constants.dart';

import '../../utils/constants/assets.dart';
import '../../utils/constants/theme.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppAsset.appLogo,
            width: 50,
          ),
          const SizedBox(width: 2),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppDetails.appName,
                style: AppTypography().appTitleStyle,
              ),
              Text(
                AppDetails.appMoto,
                style: AppTypography().appSubTitleStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

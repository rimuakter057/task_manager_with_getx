import 'package:flutter/material.dart';

import '../../utils/assets_path.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(AssetPath.background,fit: BoxFit.cover,
    );
  }
}
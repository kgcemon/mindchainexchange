import 'package:flutter/material.dart';
import 'package:mindchain_exchange/presentation/utility/assets_path.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset(AssetsPath.appLogoSvg,width: 300,));
  }
}
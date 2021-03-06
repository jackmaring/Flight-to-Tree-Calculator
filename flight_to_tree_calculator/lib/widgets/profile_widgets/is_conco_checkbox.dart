import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sustainibility_project/extensions/hover_extensions.dart';
import 'package:sustainibility_project/providers/profile.dart';

class IsConcoCheckBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<Profile>(context);
    return Checkbox(
      activeColor: Theme.of(context).accentColor,
      checkColor: Colors.white,
      value: profileProvider.isConco,
      onChanged: (val) {
        profileProvider.updateIsConco(val);
      },
    ).showCursorOnHover;
  }
}

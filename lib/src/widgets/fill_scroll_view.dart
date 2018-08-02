import 'package:flutter/material.dart';

/// Similar [SingleChildScrollView] whose content expand to fill the viewport.
///
/// This widget is quite expensive, as it more or less requires that the contents
/// of the viewport be laid out twice (once to find their intrinsic dimensions, and
/// once to actually lay them out). The number of widgets within the column should
/// therefore be kept small. Alternatively, subsets of the children that have known
/// dimensions can be wrapped in a [SizedBox] that has tight vertical constraints,
/// so that the intrinsic sizing algorithm can short-circuit the computation when it
/// reaches those parts of the subtree.
///
class FillScrollView extends StatelessWidget {
  final Widget child;

  FillScrollView({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, viewportConstraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(child: child),
              ),
            ),
      );
}

import 'package:flutter/cupertino.dart';
import 'package:placeholder_app/tools/loading_overlay/overlay_settings.dart';

class LoadingOverlay {
  static var _hidden = true;
  static OverlayEntry? _overlayEntry;
  static void hide() async {

    if(!_hidden) {
      _hidden = true;
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  static void show(BuildContext context, {OverlaySettings overlaySettings = const OverlaySettings(),}) async {
    if(_hidden) {

      final navigatorState = Navigator.of(context, rootNavigator: true, );
      final overlayState = navigatorState.overlay!;

      final __overlayEntry = _buildOverlayEntry(overlaySettings);
      _overlayEntry = __overlayEntry;
      overlayState.insert(_overlayEntry!);
    }

    _hidden = false;
  }

  static OverlayEntry _buildOverlayEntry(OverlaySettings overlaySettings) {
    final child = overlaySettings.overlay ?? Opacity(
      opacity: overlaySettings.entrySettings.opacity,
      child: Container(
        color: overlaySettings.entrySettings.backgroundColor,
        child: CupertinoActivityIndicator(radius: overlaySettings.entrySettings.radius),
      ),
    );

    return OverlayEntry(
      builder: (context) => child,
    );
  }

  const LoadingOverlay._();
}

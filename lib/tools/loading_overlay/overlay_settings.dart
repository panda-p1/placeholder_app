import 'package:flutter/material.dart';
import 'package:placeholder_app/tools/loading_overlay/entry_settings.dart';

class OverlaySettings {
  final Widget? overlay;
  final EntrySettings entrySettings;
  const OverlaySettings({this.overlay, this.entrySettings = const EntrySettings(), });
}

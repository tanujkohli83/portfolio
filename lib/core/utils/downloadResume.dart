// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/foundation.dart';

/// Triggers a download of the resume asset.
/// Compatible with Flutter Web.
void downloadResume() {
  if (kIsWeb) {
    // In Flutter Web, assets are typically served from assets/assets/
    // The path in pubspec.yaml is assets/Resume.pdf
    const String resumePath = 'assets/Resume.pdf';

    html.AnchorElement anchorElement = html.AnchorElement(href: resumePath)
      ..setAttribute("download", "Tanuj_Kohli_Resume.pdf")
      ..click();
  } else {
    // For mobile/desktop, we could use path_provider and open_file,
    // but since this is Web-first, we'll keep it simple for now.
    debugPrint("Purchase/Download logic for non-web targets goes here.");
  }
}

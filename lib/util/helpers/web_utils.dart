import 'package:universal_html/html.dart' show window;
import 'dart:html' as html;

class WebUtils {
  // web_utils.dart
// This file will only be included in web builds


void addBeforeUnloadListener() {
  html.window.onBeforeUnload.listen((html.BeforeUnloadEvent event) {
    event.preventDefault(); // Some browsers require this
    event.returnValue = '';  // This triggers the "Are you sure you want to leave?" dialog
  } as void Function(html.Event event)?);
}

}


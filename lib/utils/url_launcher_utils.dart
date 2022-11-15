import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  UrlLauncherUtils._();

  static Future<void> openUrl(String url) async {
    if (!url.contains('https://')) {
      url = 'https://$url';
    }

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not open the page.';
    }
  }
}

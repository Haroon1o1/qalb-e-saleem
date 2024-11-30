import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaRow extends StatelessWidget {
  final ScrollController scrollController;

   SocialMediaRow({Key? key, required this.scrollController}) : super(key: key);

  final List<Map<String, String>> _socialMediaLinks = [
    {
      'url': 'https://www.facebook.com/profile.php?id=100081278269074',
      'asset': 'assets/images/facebook.png',
    },
    {
      'url': 'https://www.instagram.com/qalbesaleem_?igsh=Z3F4NjVpNHZ1amdj',
      'asset': 'assets/images/instagram.png',
    },
    {
      'url': 'https://www.qalb-e-saleem.com',
      'asset': 'assets/images/web.png',
    },
    {
      'url': 'https://play.google.com/store/apps/details?id=com.bookreadqbs.qalbesaleem&hl=en',
      'asset': 'assets/images/share.png',
      'isShare': 'true', // Flag for share button
    },
    {
      'url': 'scrollToTop',
      'asset': 'assets/images/gototop.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _socialMediaLinks.map((link) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: GestureDetector(
            onTap: () {
              if (link.containsKey('isShare')) {
                Share.share('Download Qalb-E-Saleem App: ${link['url']}');
              } else if (link['url'] == 'scrollToTop') {
                scrollController.animateTo(
                  0.0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              } else {
                _launchUrl(link['url']!);
              }
            },
            child: Image.asset(
              link['asset']!,
              width: 40,
            ),
          ),
        );
      }).toList(),
    );
  }

  void _launchUrl(String url) async{
   if (!await launchUrl(Uri.parse(url))) {
      throw new Exception("NAI CHALA");
    }
  }
}

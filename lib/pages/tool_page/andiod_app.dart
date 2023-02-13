import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_features/pages/tool_page/dowload/download_service.dart';

class AndiodPage extends StatefulWidget {
  const AndiodPage({super.key});

  @override
  State<AndiodPage> createState() => _AndiodPageState();
}

class _AndiodPageState extends State<AndiodPage> {
  Future<void> _downloadFile() async {
    DownloadService downloadService =
        kIsWeb ? WebDownloadService() : MobileDownloadService();
    await downloadService.download(
        url: kIsWeb
            ? 'assets/assets/app/app-release.apk'
            : 'assets/app/app-release.apk');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Download Andriod App'),
      ),
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            _downloadFile();
          },
          icon: Icon(
            Icons.download,
            size: 24.0,
          ),
          label: Text('Download'),
        ),
      ),
    );
  }
}

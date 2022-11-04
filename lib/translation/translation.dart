import 'package:get/get_navigation/src/root/internacionalization.dart';

import 'translation_en.dart';
import 'translation_zh.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh': zh,
        'en': en,
      };
}

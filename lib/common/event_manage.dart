import '../utils/utils.dart';

class EventManage {
  // 单例
  static late final EventManage _instance = EventManage._internal();

  factory EventManage() => _instance;

  // 私有的命名构造函数
  EventManage._internal();

  //创建通知中心
  List<EventModel> pool = [];

  //添加监听者方法
  void addObserver(
    String postName,
    dynamic key,
    void Function(dynamic value) notification,
  ) {
    pool.add(EventModel(postName, key, notification));
  }

  //发送通知
  void postNotification(String postName, dynamic value) {
    try {
      /// 遍历拿到对应的通知，并执行
      for (var element in pool) {
        if (element.postName == postName) {
          element.notification(value);
        }
      }
    } catch (e) {
      loggin(e);
    }
  }

  /// 根据postName移除通知
  void removeOfName(String postName) {
    pool.removeWhere((element) => element.postName == postName);
  }

  /// 根据key移除通知
  void removeOfKey(dynamic key) {
    pool.removeWhere((element) => element.key == key);
  }

  /// 清空通知中心
  void removeAll() {
    pool.clear();
  }
}

/// 通知模型
class EventModel {
  late String postName;
  late dynamic key;

  // 根据key标记是谁加入的通知，一般直接传widget就好
  late Function(dynamic value) notification;

  EventModel(this.postName, this.key, this.notification);
}

const String eventChangeTab = "event_change_tab";
const String eventTabChange = "event_tab_change";
const String eventUser = "event_user";

// import 'package:worker_manager/worker_manager.dart';

//  import 'package:library_pc/controllers/db_helper.dart';

//  class MailWorker extends Worker {
//    Future<bool> onStart() async {
//      await DBHelper.sendMails();
//      return true;
//    }

//  }

//  void mailWorkerCallback() {

//    MailWorker().start();
//  }
import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/bll/Mappers/UserSettingsMapper.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/ChapterVM.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/ContactForm.dart';
import 'package:yatadabaron_flutter/pl/AccountPage/AccountPage.dart';
import 'package:yatadabaron_flutter/pl/ContactUsPage/ContactUs.dart';
import 'package:yatadabaron_flutter/pl/HomePage/HomePage.dart';
import 'package:yatadabaron_flutter/pl/LettersPage/LettersPage.dart';
import 'package:yatadabaron_flutter/pl/ReadingPage/ReadPage.dart';
import 'package:yatadabaron_flutter/pl/SearchPage/SearchPage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:yatadabaron_flutter/bll/ViewModels/UserSettings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:launch_review/launch_review.dart';
import 'package:package_info/package_info.dart';
import 'package:yatadabaron_flutter/pl/SignUpPage/SignupPage.dart';

class Utils {
  static Map<String,String> apiBasicHeaders(){
    return {
        "Content-Type": "application/json; charset=UTF-8",
        "authorization": "Basic " + base64Encode(utf8.encode("abdlrhmanshehata:ilp01bmrIDC!"))
      };
  }
  static String getText(int code) {
    List<String> staticTextArabic = [
      "يَتَدَبَّرُونْ", //1
      "يتدبرون - محرك بحث قرآني مفتوح المصدر صدر في شوال 1439هـ\nهذا التطبيق مجاني لكل الباحثين في احصائيات القرآن الكريم وغير مقصود من ورائه التربح بأي شكل من الأشكال كما أنه خالي تماماً من أي اعلانات تجارية", //2
      "بحث في القرآن كاملاً", //3
      "برجاء ادخال كلمة البحث هنا", //4
      "كلمة مستقلة", //5
      "جزء من كلمة", //6
      "بداية الآية", //7
      "نهاية الآية", //8
      "بسملة", //9
      "تجاهل البسملة", //10
      "ابحث", //11
      "تم العثور علي % نتيجة لكلمة ", //12
      "الرجوع للرئيسية", //13
      "البسملة: ", //14
      "رسم بياني", //15
      "جدول", //16
      "احصائيات الحروف", //17
      "عفوأ حدثت مشكلة ولن يتمكن البرنامج من القيام, برجاء العلم أنه تم ارسال جميع التفاصيل للمسؤولين وسيتم تلافي مثل هذه المشكلة في النسخ القادمة من البرنامج برجاء انتظار التحديث القادم قريباً", //18
      "ابحث", //19
      "موضع البحث: ", //20
      "اعتبار البسملة", //21
      "لم يتم العثور علي أية نتائج,يمكنك تغيير اعدادات البحث", //22
      "برجاء ادخال كلمة البحث أولاً ثم التأكد من اعدادات البحث ثم الضغط علي زر البحث", //23
      "ابحث", //24
      "تواصل معنا", //25
      "البريد الالكتروني", //26
      "الرسالة: ", //27
      "الاسم", //28
      "ارسال", //29
      "تم", //30
      "برجاء ادخال الاسم والرسالة, يفضل ادخال البريد الالكتروني حتي نتمكن من التواصل معكم", //31
      "برجاء العلم أننا نراجع كل الرسائل بمنتهي الدقة ونهتم كثيراً بأراء المستخدمين لذا ندعوكم بمشاركتنا بكل ما يدور ببالكم من تعليقات وآراء و جزاكم الله عنا كل خير", //32
      "تم ارسال الرسالة بنجاح,نشكركم علي التعاون", //33
      "عفواً قد حدث خطأ ما ,برجاء الارسال مرة آخري والتأكد من الاتصال بالانترنت", //34
      "برجاء التفاعل معنا عن طريق تقييم البرنامج, جزاكم الله خيراً علي تفاعكلم الدائم", //35
      "موافق", //36
      "لاحقاً", //37
      "نشكركم علي رسالتكم السابقة ونذكركم بأننا دائماً نتطلع الي المزيد من آرائكم المثمرة", //38
      "تردد الحروف", //39
      "بحث قرآني", //40
      "القرآن الكريم", //41
      "تواصل معنا", //42
      "تقييم البرنامج", //43
      "مجهول", //44
      "تسجيل الدخول", //45
      "كلمة المرور", //46
      "إنشاء حساب",//47
      "تسجيل الخروج",//48
      "إلغاء",//49
      "العمر",//50
      "النوع",//51
      "البلد",//52
      "غرض الاستخدام",//53
      "تم إنشاء حساب جديد بنجاح",//54
      "قد حدث خطأ ما أثناء إنشاء حساب جديد ! برجاء المحاولة مرة آخري والتأكد من الاتصال الجيد بالانترنت",//55
      "برجاء الانتظار ...",//56
      "هذه البيانات غير صحيحة, برجاء التأكد منها واعادة المحاولة",//57
      "ادارة الحساب",//58
      "",//59
      "",//60
      "",//61
      "",//62
      "",//63
      "",//64

    ];
    int index = code - 1;
    if ((index) >= 0 && (index) < staticTextArabic.length) {
      return staticTextArabic[index];
    } else {
      return "";
    }
  }
  static showPleaseWait(BuildContext context){
    showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return Utils.simpleDialog(context, Utils.getText(56),false);
          },
    );
  }
  static goLetters(BuildContext context) async{
    Navigator.push(
        context, MaterialPageRoute(builder: (b) => LettersPage()));
  }

  static goSearch(BuildContext context, [ChapterVM chapter = null]) async{
    Navigator.push(
        context, MaterialPageRoute(builder: (b) => SearchPage()));
  }

  static goRead(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (b) => ReadPage()));
  }

  static goAccount(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (b) => AccountPage()));
  }

  static goSignup(BuildContext context) async {
    Navigator.push(context, MaterialPageRoute(builder: (b) => SignupPage()));
  }

  static goContact(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (b) => ContactUs()));
  }

  static goHome(BuildContext context) async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (b) => HomePage()));
  }
static String apiBaseURL(){
  return "http://www.wisebaysolutions.tech/api/yatadabaron/";
}
  static showRatingDialog(BuildContext context) async {
    UserSettings u = await getUserSettings();
    int no = int.tryParse(u.noOfUses) ?? 0;
    int hasRated = int.tryParse(u.userHasRated) ?? 0;
    bool condition = false;
    if (hasRated == 1) {
      condition = (no % 20 == 0);
    } else {
      condition = (no % 10 == 0);
    }

    if (condition) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return ratingDialog(context);
        },
      );
    }
  }

  static Future<void> sendUserMessage(
      ContactForm form, BuildContext context) async {
    if (form.Valid()) {
      UserSettings u = await getUserSettings();
      int hasSent = int.tryParse(u.userHasSentMessage) ?? 0;
      if (hasSent == 1) {
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return simpleDialog(context, getText(38));
          },
        );
      }
      //send the API
      var uri = Uri.parse(
          "http://www.wisebaysolutions.tech/yatadabaron/api/postmessage.php");
      Map<String, String> body = Map<String, String>();
      body["name"] = form.Name;
      body["email"] = form.Email;
      body["message"] = form.Message;
      body["userid"] = form.ID.toString();
      var response = await http.post(
        uri,
        body: json.encode(body),
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        encoding: Encoding.getByName("utf-8"),
      );

      try {
        if (response.statusCode == 200) {
          await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return simpleDialog(context, getText(33));
            },
          );

          //Update User Settings
          UserSettings u = await getUserSettings();
          u.userHasSentMessage = "1";
          await setUserSettings(u);

          goHome(context);
        } else {
          print(response.statusCode);
          await showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return simpleDialog(context, getText(34));
            },
          );
        }
      } catch (e) {
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) {
            return simpleDialog(context, getText(34));
          },
        );
      }
    } else {
      await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return simpleDialog(context, getText(31));
        },
      );
    }
  }

  static Widget ratingDialog(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(20),
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(
            getText(35),
            textAlign: TextAlign.center,
            textDirection: Utils.getTextDirection(),
            softWrap: true,
          ),
        ),
        Text(" "),
        Row(
          textDirection: getTextDirection(),
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor,
              alignment: Alignment.center,
              child: SimpleDialogOption(
                onPressed: () async {
                  //update the user settings
                  UserSettings u = await getUserSettings();
                  u.userHasRated = "1";
                  await setUserSettings(u);

                  LaunchReview.launch();
                  Navigator.pop(context);
                },
                child: Text(
                  getText(36),
                  textDirection: Utils.getTextDirection(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Text(" "),
            Container(
              color: Theme.of(context).primaryColor,
              alignment: Alignment.center,
              child: SimpleDialogOption(
                onPressed: () async {
                  Navigator.pop(context);
                },
                child: Text(
                  getText(37),
                  textDirection: Utils.getTextDirection(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget simpleDialog(BuildContext context, String text,[bool withButton=true]) {
    Widget button;
    if (withButton) {
      button = SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            textDirection: Utils.getTextDirection(),
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                getText(30),
                textDirection: Utils.getTextDirection(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
    }else{
      button = Text("");
    }
    return SimpleDialog(
      contentPadding: EdgeInsets.all(20),
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Text(
            text,
            textDirection: Utils.getTextDirection(),
            softWrap: true,
          ),
        ),
        button
      ],
    );
  }

  static ChapterVM quranChapter() {
    ChapterVM chapter = ChapterVM();
    chapter.ID = 0;
    chapter.NameWithNumber = "القرآن الكريم كاملاً";
    chapter.ArName = "القرآن الكريم كاملاً";
    chapter.Summary = "6236 آية";
    return chapter;
  }
  
  static TextDirection getTextDirection() {
    if (true) {
      return TextDirection.rtl;
    } else {
      return TextDirection.ltr;
    }
  }

  static const String DATABASE_NAME_DEVICE = "quran.db";
  static const String DATABASE_NAME_ASSETS = "quran.db";

  static Future<String> versionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionCode = packageInfo.buildNumber;
    String versionNumber = packageInfo.version;
    _print("VERSION CODE: $versionCode");
    _print("VERSION NUMBER: $versionNumber");
    return versionCode;
  }

  static Future<String> databasePath() async {
    String _appPath = await appPath();
    return join(_appPath, DATABASE_NAME_DEVICE);
  }

  static Future<String> appPath() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String appPath = appDir.path;
    return appPath;
  }

  static Future<UserSettings> getUserSettings() async {
    String _configPath = await configPath();
    File configFile = File(_configPath);
    String content = await configFile.readAsString();
    UserSettings u = UserSettingsMapper.toUserSettings(content);
    return u;
  }

  static Future setUserSettings(UserSettings u) async {
    String _configPath = await configPath();
    File configFile = File(_configPath);
    String stringified = UserSettingsMapper.stringify(u);
    await configFile.writeAsString(stringified);
  }

  static Future<String> configPath() async {
    String v = await versionCode();
    String _configName = "config.versioncode$v.json";
    String _appPath = await appPath();
    return join(_appPath, _configName);
  }

  static _print(x) {
    print("---------------------------$x-------------------------------");
  }

  static Future<bool> Initialize() async {
    String _configPath = await configPath();
    String _databasePath = await databasePath();

    File configFile = File(_configPath);
    File databaseFile = File(_databasePath);
    bool configFileExists = await configFile.exists();
    if (!configFileExists) {
      //Delete all the files in the application directory
      Directory appDir = await getApplicationDocumentsDirectory();
      var files = appDir.list();
      await files.forEach((f) async {
        if (f is File) {
          await f.delete();
        }
      });

      //Create configuration file
      UserSettings u = UserSettings();
      String deviceId = await DeviceId.getID;
      u.userID = deviceId;
      String settingsAsString = UserSettingsMapper.stringify(u);
      await configFile.writeAsString(settingsAsString);

      // Create the writable database file from the bundled demo database file:
      ByteData databseByteData =
          await rootBundle.load("assets/data/$DATABASE_NAME_ASSETS");
      List<int> databseBytes = databseByteData.buffer.asUint8List(
          databseByteData.offsetInBytes, databseByteData.lengthInBytes);
      await databaseFile.writeAsBytes(databseBytes);
    }

    bool databaseFileExists = await databaseFile.exists();
    return databaseFileExists;
  }
}

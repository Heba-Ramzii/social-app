 import '../network/local/cache_helper.dart';
import 'components.dart';


void printFullText (String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=> print(match.group(0)));
}

String? token ;// هوا كان كدا
String? uId ;
// ف كدا حني لو عملتي لوج اوت مش هيديكي null علشان اصلا هيبقي فيه قيمه اللي هيا فاضيه دي بس دي متعتبرش null
// '' != null
// فهرح احط قبلها علامه استفهام



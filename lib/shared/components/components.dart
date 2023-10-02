import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../styles/colors.dart';

Widget defaultButton({
  double width=double.infinity,
  Color background= Colors.blue,
  bool  isUpperCase = true ,
  double radius = 0.0,
  required Function() function,
  required String text,
}) => Container(
    width: width,
    height: 40.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius,),
      color: background,
    ),
    child: MaterialButton(
          onPressed: function,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: const TextStyle(
      color: Colors.white,
    ),
    ),
    ),
    )  ;

Widget defaultFormField ({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  GestureTapCallback? onTap,
  bool isClickable = true,
  bool isPassword = false,
  required String? Function(String?)? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
}) => TextFormField(
controller: controller ,
keyboardType: type,
obscureText: isPassword,
onFieldSubmitted:onSubmit,
onTap: onTap,
onChanged:onChange ,
enabled: isClickable,
validator: validate,
decoration: InputDecoration(
labelText: label,
border: const OutlineInputBorder(),
prefixIcon: Icon(
  prefix,
),
  suffixIcon: suffix != null ? IconButton(
     onPressed:suffixPressed ,
      icon: Icon(
    suffix,)
  )
      : null,
),
);

Widget defaultTextButton({
  required Function()? function,
  required String text,
}) => TextButton(
    onPressed: function,
    child: Text(text.toUpperCase()),);


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity ,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

Widget buildArticleItem(article,context) => InkWell(
  onTap:(){
    //navigateTo(context, WebViewScreen(article['url']),);
  } ,
  child: Padding (
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
  
          height: 120.0,
  
          decoration: BoxDecoration(
  
            borderRadius: BorderRadius.circular(10.0),
  
            image: DecorationImage(
  
              image: NetworkImage('${article['urlToImage']}'),
  
              fit: BoxFit.cover,
  
            ),
  
          ),
  
        ),
  
        const SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: SizedBox(
  
            height: 120.0,
  
            child: Column(
  
              crossAxisAlignment: CrossAxisAlignment.start,
  
              mainAxisAlignment: MainAxisAlignment.start,
  
              children: [
  
                Expanded(
  
                  child: Text(
  
                    '${article['title']}',
  
                    style: Theme.of(context).textTheme.bodyLarge,
  
                    maxLines: 3,
  
                    overflow: TextOverflow.ellipsis,
  
                  ),
  
                ),
  
                Text(
  
                  '${article['publishedAt']}',
  
                  style: const TextStyle(
  
                    color: Colors.grey,
  
                  ),
  
                ),
  
              ],
  
            ),
  
          ),
  
        ),
  
      ],
  
    ),
  
  ),
);

void navigateTo(context, widget) =>Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ), (Route<dynamic> route) => false,
);

Widget articleBuilder(list,context) => list.length > 0 ? ListView.separated(
  physics: const BouncingScrollPhysics(),
  itemBuilder: (context,index) => buildArticleItem(list[index],context),
  separatorBuilder: (context,index) => myDivider(),
  itemCount: 10,) : const Center(child: CircularProgressIndicator());

void showToast({
  required String text,
  required ToastStates state,

})=>Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor:chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}


Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: (){
      Navigator.pop(context);
    },
    icon: const Icon(
      Icons.arrow_back_ios,
    ),
  ),
  title: Text(
    title!,
  ),
  actions: actions,
 );
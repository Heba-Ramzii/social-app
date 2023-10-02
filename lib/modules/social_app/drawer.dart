import 'package:flutter/material.dart';

class Drawerr extends StatelessWidget {
  const Drawerr({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer'),
         backgroundColor: Colors.purpleAccent,
       ),
      body: const Center(),
      drawerScrimColor: Colors.cyan.withOpacity(0.2),
      drawer: Drawer(
        child: ListView(
           children: const [
            ListTile(
              title: Text(
                  "go to screen1",
               ),
              trailing: Icon(Icons.icecream_sharp),
            ),
            SizedBox(height: 15.0,),
            ListTile(
              title: Text("go to screen2",
               ),
              trailing: Icon(Icons.icecream_sharp),

            ),
          ],
        ),
      ),
    );
  }
}

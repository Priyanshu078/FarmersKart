import 'package:flutter/material.dart';
import 'package:shellcode2/colors.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final phoneController = TextEditingController();
  String title1 ='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [left,middle,Colors.purple]
              )
          ),
        ),
        title: Row(
          children: [
            Expanded(child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [left,middle,Colors.purple]
                  )
              ),
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: bgcolor,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     /* Row(
                        children: [
                          Icon(Icons.search, color: yellow,),
                          MaterialButton(
                            minWidth: double.infinity,
                            height: 50,
                            onPressed: null,
                            child: TextField(
                              controller: phoneController,
                              style: TextStyle(
                                  height: 1.5,color: Colors.purple
                              ),
                              cursorColor: Colors.purpleAccent,
                              decoration: InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: Theme.of(context).textTheme.caption!.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: yellow, // Set Your Own Color
                                ),
                              ),
                              onChanged: (value) => title1 = value,
                            ), //fontSize: 12,color: tertiaryColor,fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),*/
                      Row(
                        children: [
                          Icon(Icons.search, color: yellow,),
                          Text('   '),
                          Text('Search', style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.keyboard_voice_outlined, color: yellow,)
                        ],
                      )

                    ],
                  ),
                ),
              ),
            ),)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../Model/key_player_list_model.dart';
import 'color_helper.dart';

class KeyPlayerTile extends StatelessWidget {
  TopList listItem;
  int viewType;
  KeyPlayerTile({required this.listItem,required this.viewType});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
        color:ColorHelper.primaryred.withOpacity(0.2)
      ),
      child:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.network(listItem.playerImage,fit: BoxFit.cover,height: 50, errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Text('😢',style: TextStyle(fontSize: 40),);
                  },),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Text(listItem.playerName,style: TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                      ),
                      Text(listItem.teamNiceName,style: TextStyle(fontSize: 13,color: ColorHelper.gray,fontWeight: FontWeight.w400),),
                    ],
                  ),
                ),
              ],
            ),
            viewType == 1 || viewType == 3?
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Batting Perfomance",style: TextStyle(fontSize: 15,color: ColorHelper.primaryred,fontWeight: FontWeight.w500),),
                ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text("R",style: TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                      ),
                      Text(listItem.batRun.toString(),style: TextStyle(fontSize: 15,color: ColorHelper.gray,fontWeight: FontWeight.w400),),
                    ],
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                    color: ColorHelper.primaryred.withOpacity(0.2),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text("B",style: TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                      ),
                      Text(listItem.balls.toString(),style: TextStyle(fontSize: 15,color: ColorHelper.gray,fontWeight: FontWeight.w400),),
                    ],
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                    color: ColorHelper.primaryred.withOpacity(0.2),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text("4s",style: TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                      ),
                      Text(listItem.fours.toString(),style: TextStyle(fontSize: 15,color: ColorHelper.gray,fontWeight: FontWeight.w400),),
                    ],
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                    color: ColorHelper.primaryred.withOpacity(0.2),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text("6s",style: TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                      ),
                      Text(listItem.sixes.toString(),style: TextStyle(fontSize: 15,color: ColorHelper.gray,fontWeight: FontWeight.w400),),
                    ],
                  ),
                  Container(
                    height: 30.0,
                    width: 1.0,
                    color: ColorHelper.primaryred.withOpacity(0.2),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Text("SR",style: TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                      ),
                      Text(listItem.strikeRate.toString(),style: TextStyle(fontSize: 15,color: ColorHelper.gray,fontWeight: FontWeight.w400),),
                    ],
                  ),
                ],
              ),
            ),
              ],
            )
            :Container(),

            viewType == 2 || viewType == 3?
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Balling Perfomance",style: TextStyle(fontSize: 15,color: ColorHelper.primaryred,fontWeight: FontWeight.w500),),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text("O",style: TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                          ),
                          Text(listItem.overs.toString(),style: TextStyle(fontSize: 15,color: ColorHelper.gray,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: ColorHelper.primaryred.withOpacity(0.2),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text("B",style: TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                          ),
                          Text(listItem.balls.toString(),style: TextStyle(fontSize: 15,color: ColorHelper.gray,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: ColorHelper.primaryred.withOpacity(0.2),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text("4s",style: TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                          ),
                          Text(listItem.fours.toString(),style: TextStyle(fontSize: 15,color: ColorHelper.gray,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: ColorHelper.primaryred.withOpacity(0.2),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text("6s",style: TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                          ),
                          Text(listItem.sixes.toString(),style: TextStyle(fontSize: 15,color: ColorHelper.gray,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: ColorHelper.primaryred.withOpacity(0.2),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text("SR",style: TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                          ),
                          Text(listItem.strikeRate.toString(),style: TextStyle(fontSize: 15,color: ColorHelper.gray,fontWeight: FontWeight.w400),),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
                :Container(),
          ],
        ),
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prediction/UI/profile_screen.dart';

import '../../Utils/utils.dart';
import '../Controller/ads_controller.dart';
import '../Controller/key_player_screen_controller.dart';
import '../Model/key_player_list_model.dart';
import '../Widget/app_bar_view.dart';
import '../Widget/color_helper.dart';
import '../Widget/key_player_tile.dart';

class KeyPlayerScreen extends StatelessWidget {

  KeyPlayerScreenController keyPlayerScreenController = Get.put(KeyPlayerScreenController());
  AdsController adsController = Get.find();
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
      height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorHelper.bgColor,
      appBar: AppBarView(
        title: "KEY PLAYERS",
      ),
      body: Obx(
            () => keyPlayerScreenController.isLoading.value
            ? Utils.circularIndicator(context)
            : SafeArea(
            child: Container(
              height: height,
              width: width,
              color: ColorHelper.white,
              child: Stack(
                children: [
                   /*keyPlayerScreenController..isEmpty
                        ? SizedBox(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              "No Data Found",
                            )),
                          )
                        :*/
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //top bar
                        topBar(),
                        //ads part
                        adsPart(),
                        //list of data
                        listOfData(),
                      ],
                    ),
                  ),
                  /* Obx(() => keyPlayerScreenController.isLoaderShow.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 4.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                ColorHelper.primaryGreen,
                              ),
                            ),
                          )
                        : const SizedBox()), */
                ],
              ),
            )),
      ),
    );
  }

  topBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0,bottom: 20),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: ColorHelper.primaryred.withOpacity(0.2),
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        child: Table(
          children: [
            TableRow(children: [
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  child: Container(
                    height: 35,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Top Batsman",
                        style: TextStyle(
                            fontSize: 12,
                            color: keyPlayerScreenController.isTabPressed==1
                                ? ColorHelper.white
                                : ColorHelper.primaryred),
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      color: keyPlayerScreenController.isTabPressed==1
                          ? ColorHelper.primaryred
                          : Colors.transparent,

                  ),
                  ),
                  onTap: () {
                    adsController.loadShowAdsManager();
                    keyPlayerScreenController.changeTab(1);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  child: Container(
                    height: 35,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Top Bowler",
                        style: TextStyle(
                            fontSize: 12,
                            color: keyPlayerScreenController.isTabPressed==2
                                ? ColorHelper.white
                                : ColorHelper.primaryred),
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      color: keyPlayerScreenController.isTabPressed==2
                          ? ColorHelper.primaryred
                          : Colors.transparent,
                    ),
                  ),
                  onTap: () {
                    adsController.loadShowAdsManager();
                    keyPlayerScreenController.changeTab(2);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  child: Container(
                    height: 35,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Top Allrounder",
                        style: TextStyle(
                            fontSize: 12,
                            color: keyPlayerScreenController.isTabPressed==3
                                ? ColorHelper.white
                                : ColorHelper.primaryred),
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(7.0)),
                      color: keyPlayerScreenController.isTabPressed==3
                          ? ColorHelper.primaryred
                          : Colors.transparent,
                    ),
                  ),
                  onTap: () {
                    adsController.loadShowAdsManager();
                    keyPlayerScreenController.changeTab(3);
                  },
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  listOfData() {
    RxList<TopList> tempList =keyPlayerScreenController.topBatsmanList;
    if(keyPlayerScreenController.isTabPressed == 1.obs){
      tempList =keyPlayerScreenController.topBatsmanList;
    }else if(keyPlayerScreenController.isTabPressed == 2.obs){
      tempList =keyPlayerScreenController.topBowlerList;
    }else if(keyPlayerScreenController.isTabPressed == 3.obs){
      tempList =keyPlayerScreenController.topAllRounderList;
    }
    return tempList.isEmpty
        ? SizedBox(
      height: height*0.5,
      width: width,
      child: Center(
          child: Text(
            "No Data Found",
            style: TextStyle(color:ColorHelper.primaryred),
          )),
    )
        :ListView.builder(
        itemCount: tempList.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(),
        itemBuilder: (BuildContext context,int index){
          return  Padding(
            padding: const EdgeInsets.all(10.0),
            child: InkWell(onTap: (){
              adsController.loadShowAdsManager();
              Get.to(()=>ProfileScreen(),arguments: [tempList[index].teamId,tempList[index].playerId]);
            },child: KeyPlayerTile(listItem: tempList[index], viewType: keyPlayerScreenController.isTabPressed.value,)),
          );
        }
    );
  }

  adsPart() {
    return keyPlayerScreenController.isAdLoaded?
    keyPlayerScreenController.adsController.nativeAdsPart(height,width)
        :Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
      child: Container(
        width: width * 0.95,
        height: 120,
        decoration: BoxDecoration(color: ColorHelper.primaryredlight, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text("Ad Loading",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: ColorHelper.primaryred,
              fontSize: 15,
              //fontFamily: "Verda",
            ),),
        ),
      ),
    );
  }
}

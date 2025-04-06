import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/utils.dart';
import '../Controller/profile_screen_controller.dart';
import '../Utils/string_helper.dart';
import '../Widget/app_bar_view.dart';
import '../Widget/color_helper.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreenController profileScreenController = Get.put(ProfileScreenController());
  late double width;
  late double height;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorHelper.bgColor,
      appBar: const AppBarView(
        title: "PLAYER PROFILE",
      ),
      body: Obx(
        () => profileScreenController.isLoading.value
            ? Utils.circularIndicator(context)
            : SafeArea(
                child: Container(
                height: height,
                width: width,
                color: ColorHelper.white,
                // padding: const EdgeInsets.only(left: 0, right: 0),
                child: Stack(
                  children: [
                    /*profileScreenController..isEmpty
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
                          //player name part
                        playerNmaePart(),
                        //player bating data
                        playerBatingData(),
                          //ads part
                          adsPart(),
                          //player bating data
                          playerBowlingData(),
                        ],
                      ),
                    ),
                     Obx(() => profileScreenController.isLoaderShow.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 4.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                ColorHelper.primaryred,
                              ),
                            ),
                          )
                        : const SizedBox()),
                  ],
                ),
              )),
      ),
    );
  }

  playerNmaePart() {
    return Container(
      height: height * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            profileScreenController.playerName,
            style: const TextStyle(fontSize: 18, color: ColorHelper.primaryred, fontWeight: FontWeight.w600),
          ),
          Container(
            width: width * 0.3,
            height: 30,
            decoration: BoxDecoration(
              color: ColorHelper.primaryredlight,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Image.asset(
                  '${StringHelper.svgIconPath}/menu_icon.png',
                ),
                const SizedBox(width: 10),
                DropdownButton(
                  icon: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 22

                      ),
                      Image.asset(
                        '${StringHelper.svgIconPath}/dropdown_icon.png',
                      ),
                    ],
                  ),
                  iconSize: 0.0,
                  underline: const SizedBox(),
                  onChanged: (newValue) {
                    profileScreenController.setSelected(newValue.toString());
                    int indexWhere = profileScreenController.allTeamListService.indexWhere((item) => item.teamNiceName==newValue);
                    profileScreenController.teamId=profileScreenController.allTeamListService[indexWhere].teamId;
                    profileScreenController.profileScreenData();
                  },
                  value: profileScreenController.selected.value,
                  items: profileScreenController.allTeamListService.map((selectedType) {
                    return DropdownMenuItem(
                      child: Text(
                        selectedType.teamNiceName,
                      ),
                      value: selectedType.teamNiceName,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  playerBatingData() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0,left: 10,right: 10),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: ColorHelper.primaryredlight,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0, bottom: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Date",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "   Vs",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "   R",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "   B",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "4s",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "6s",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "SR",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      thickness: 1,
                      color: ColorHelper.black.withOpacity(0.5),
                    ),
                  ),
                  profileScreenController.batingPerformance.isEmpty
                      ? SizedBox(
                        height: height*0.2,
                        width: width,
                        child: const Center(
                            child: Text(
                              "No Data Found",
                            ),
                        ),
                      )
                      :Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                        itemCount: profileScreenController.batingPerformance.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  profileScreenController.batingPerformance[index].date.substring(0, 5),
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  profileScreenController.batingPerformance[index].teamNiceName,
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  profileScreenController.batingPerformance[index].batRun.toString(),
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  profileScreenController.batingPerformance[index].balls.toString(),
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  profileScreenController.batingPerformance[index].fours.toString(),
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  profileScreenController.batingPerformance[index].sixes.toString(),
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  profileScreenController.batingPerformance[index].strikeRate.toString(),
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.network(
              profileScreenController.playerImage,
              fit: BoxFit.cover,
              height: 100,
            ),
          ),
        ),
      ],
    );
  }



  adsPart() {
    return profileScreenController.isAdLoaded?
    profileScreenController.adsController.nativeAdsPart(height,width)
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

  playerBowlingData() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50.0,left: 10,right: 10),
          child: Container(
            width: width,
            decoration: BoxDecoration(
              color: ColorHelper.primaryredlight,
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0, bottom: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Date",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "   Vs",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "   O",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "   R",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "W",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "MO",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "ER",
                          style: TextStyle(fontSize: 12, color: ColorHelper.black, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      thickness: 1,
                      color: ColorHelper.black.withOpacity(0.5),
                    ),
                  ),
                  profileScreenController.bowlingPerformance.isEmpty
                      ? SizedBox(
                    height: height*0.2,
                    width: width,
                    child: const Center(
                      child: Text(
                        "No Data Found",
                      ),
                    ),
                  )
                      :Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListView.builder(
                        itemCount: profileScreenController.bowlingPerformance.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  profileScreenController.bowlingPerformance[index].date.substring(0, 5),
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  profileScreenController.bowlingPerformance[index].teamNiceName,
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  profileScreenController.bowlingPerformance[index].overs.toString(),
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  profileScreenController.bowlingPerformance[index].ballRun.toString(),
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  profileScreenController.bowlingPerformance[index].wickets.toString(),
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  profileScreenController.bowlingPerformance[index].maidenOver.toString(),
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  profileScreenController.bowlingPerformance[index].economyRate.toString(),
                                  style: TextStyle(fontSize: 12, color: ColorHelper.light_gray, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.network(
              profileScreenController.playerImage,
              fit: BoxFit.cover,
              height: 100,
            ),
          ),
        ),
      ],
    );
  }

}

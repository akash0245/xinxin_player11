import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/ads_controller.dart';
import '../Controller/compareteams_controller.dart';
import '../Utils/string_helper.dart';
import '../Utils/utils.dart';
import '../Widget/app_bar_view.dart';
import '../Widget/color_helper.dart';
import 'key_player_screen.dart';
import 'match_status_screen.dart';

class CompareTeams extends StatelessWidget {
  CompareTeams({Key? key}) : super(key: key);
  CompareTeamsController compareTeamsController = Get.put(CompareTeamsController());
  AdsController adsController = Get.find();
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorHelper.bgColor,
      appBar: const AppBarView(
        title: "COMPARE TEAM",
        isShowBack: true,
      ),
      body: Obx(
        () => compareTeamsController.isLoading.value
            ? Utils.circularIndicator(context)
            : SafeArea(
                child: SizedBox(
                height: height,
                width: width,
                child: Stack(
                  children: [
                    /* homepageController..isEmpty
                        ? SizedBox(
                            height: height,
                            width: width,
                            child: Center(
                                child: Text(
                              "No Data Found",
                            )),
                          )
                        : */
                    Obx(() => SingleChildScrollView(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.075,
                              ),
                              Text(
                                'Select Series',
                                style: Utils.titleStyleBlack,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              seriesDropDown(width),
                              SizedBox(
                                height: height * 0.0375,
                              ),
                              Text(
                                'Select Team',
                                style: Utils.titleStyleBlack,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: teamDropDown1(),
                                  ),
                                  SizedBox(
                                    width: width * 0.051,
                                  ),
                                  Expanded(
                                    child: teamDropDown2(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.075,
                              ),
                              buttonBar(),
                              //ads part
                              adsPart(),
                            ],
                          ),
                        )),
                    Obx(() => compareTeamsController.isLoading.value
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
    /*  ); */
  }

  Container seriesDropDown(double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      decoration: BoxDecoration(color: ColorHelper.primaryredlight, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButton(
            icon: Row(
              children: [
                SizedBox(
                  width: width * 0.24,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorHelper.primaryred,
                  ),
                  child: Image.asset(
                    '${StringHelper.svgIconPath}/arrow_down.png',
                    // height: 50,
                  ),
                ),
              ],
            ),
            iconSize: 0.0,
            underline: const SizedBox(),
            onChanged: (newValue) {
              int index = compareTeamsController.teamListData.indexWhere((item) => item.seriesTitle == newValue);
              compareTeamsController.selectedSearies.value = newValue.toString();
              compareTeamsController.selectedSeariesIndex = index.obs;

              compareTeamsController.selectedTeam1 = compareTeamsController.teamListData[index].teamList[0].teamNiceName.obs;
              compareTeamsController.selectedTeam2 = compareTeamsController.teamListData[index].teamList[0].teamNiceName.obs;
            },
            value: compareTeamsController.selectedSearies.value,
            items: compareTeamsController.teamListData.map((selectedType) {
              return DropdownMenuItem(
                child: Text(
                  selectedType.seriesTitle,
                ),
                value: selectedType.seriesTitle,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buttonBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              adsController.loadShowAdsManager();
              Get.to(() => KeyPlayerScreen(), arguments: [compareTeamsController.selectedTeam1Id.value, compareTeamsController.selectedTeam2Id.value]);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(color: ColorHelper.btnRed, borderRadius: BorderRadius.circular(10)),
              child: Text(
                'KEY PLAYER',
                style: Utils.text2StyleWhite,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              adsController.loadShowAdsManager();
              Get.to(() => MatchStatusScreen(), arguments: [compareTeamsController.selectedTeam1Id.value, compareTeamsController.selectedTeam2Id.value]);
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(color: ColorHelper.btnRed, borderRadius: BorderRadius.circular(10)),
              child: Text(
                'MATCH RESULT',
                style: Utils.text2StyleWhite,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget teamDropDown1() {
    return Container(
      // width: width,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      decoration: BoxDecoration(color: ColorHelper.primaryredlight, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButton(
            icon: Row(
              children: [
                SizedBox(
                  width: width * 0.127,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorHelper.primaryred,
                  ),
                  child: Image.asset(
                    '${StringHelper.svgIconPath}/arrow_down.png',
                    // height: 50,
                  ),
                ),
              ],
            ),
            iconSize: 0.0,
            underline: const SizedBox(),
            onChanged: (newValue) {
              compareTeamsController.selectedTeam1.value = newValue.toString();
              int index = compareTeamsController.teamListData[compareTeamsController.selectedSeariesIndex.value].teamList.indexWhere((item) => item.teamNiceName == newValue);
              compareTeamsController.selectedTeam1Id.value = compareTeamsController.teamListData[compareTeamsController.selectedSeariesIndex.value].teamList[index].teamId;
            },
            value: compareTeamsController.selectedTeam1.value,
            items: compareTeamsController.teamListData[compareTeamsController.selectedSeariesIndex.value].teamList.map((selectedType) {
              return DropdownMenuItem(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      '${StringHelper.svgIconPath}/teamsymbol3.png',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      selectedType.teamNiceName,
                    ),
                  ],
                ),
                value: selectedType.teamNiceName,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget teamDropDown2() {
    return Container(
      // width: width,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      decoration: BoxDecoration(color: ColorHelper.primaryredlight, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButton(
            icon: Row(
              children: [
                SizedBox(
                  width: width * 0.127,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorHelper.primaryred,
                  ),
                  child: Image.asset(
                    '${StringHelper.svgIconPath}/arrow_down.png',
                    // height: 50,
                  ),
                ),
              ],
            ),
            iconSize: 0.0,
            underline: const SizedBox(),
            onChanged: (newValue) {
              compareTeamsController.selectedTeam2.value = newValue.toString();
              int index = compareTeamsController.teamListData[compareTeamsController.selectedSeariesIndex.value].teamList.indexWhere((item) => item.teamNiceName == newValue);
              compareTeamsController.selectedTeam2Id.value = compareTeamsController.teamListData[compareTeamsController.selectedSeariesIndex.value].teamList[index].teamId;
            },
            value: compareTeamsController.selectedTeam2.value,
            items: compareTeamsController.teamListData[compareTeamsController.selectedSeariesIndex.value].teamList.map((selectedType) {
              return DropdownMenuItem(
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      '${StringHelper.svgIconPath}/teamsymbol3.png',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      selectedType.teamNiceName,
                    ),
                  ],
                ),
                value: selectedType.teamNiceName,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }


  adsPart() {
    return compareTeamsController.isAdLoaded?
    Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child:compareTeamsController.adsController.nativeAdsPart(height,width)
        )
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

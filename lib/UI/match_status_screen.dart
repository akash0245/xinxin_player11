import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/utils.dart';
import '../Controller/ads_controller.dart';
import '../Controller/match_status_screen_controller.dart';
import '../Utils/string_helper.dart';
import '../Widget/app_bar_view.dart';
import '../Widget/color_helper.dart';
import 'key_player_screen.dart';

class MatchStatusScreen extends StatelessWidget {
  MatchStatusScreenController matchStatusScreenController = Get.put(MatchStatusScreenController());
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
        title: "MATCH STATUS",
      ),
      body: Obx(
        () => matchStatusScreenController.isLoading.value
            ? Utils.circularIndicator(context)
            : SafeArea(
                child: Container(
                height: height,
                width: width,
                color: ColorHelper.white,
                // padding: const EdgeInsets.only(left: 0, right: 0),
                child: Stack(
                  children: [
                    /*matchStatusScreenController..isEmpty
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
                          //list of data
                          statusData(),
                          //recent Matches
                          recentMatches(),
                        ],
                      ),
                    ),
                    /*Obx(() => matchStatusScreenController.isDataSubmit.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 4.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                ColorHelper.primaryred,
                              ),
                            ),
                          )
                        : const SizedBox()),*/
                  ],
                ),
              )),
      ),
    );
  }

  statusData() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: const BorderRadius.all(Radius.circular(15.0)), color: ColorHelper.primaryredlight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 4,
                      child: Text(
                        "",
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          child: Image.network(
                            matchStatusScreenController.allData.team1Icon,
                            fit: BoxFit.cover,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          child: Image.asset(
                            '${StringHelper.svgIconPath}/vs_icon.png',
                            fit: BoxFit.cover,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ClipRRect(
                          child: Image.network(
                            matchStatusScreenController.allData.team2Icon,
                            fit: BoxFit.cover,
                            height: 30,
                            width: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text(
                        "Win Rate",
                        style: TextStyle(fontSize: 15, color: ColorHelper.primaryred, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "|",
                        style: TextStyle(fontSize: 20, color: ColorHelper.primaryred.withOpacity(0.2), fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        matchStatusScreenController.teamOneRate.toInt().toString() + "%",
                        style: const TextStyle(fontSize: 16, color: ColorHelper.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "|",
                        style: TextStyle(fontSize: 20, color: ColorHelper.primaryred.withOpacity(0.2), fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        matchStatusScreenController.teamTwoRate.toInt().toString() + "%",
                        style: const TextStyle(fontSize: 16, color: ColorHelper.black, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text(
                        "Contests",
                        style: TextStyle(fontSize: 15, color: ColorHelper.primaryred, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "|",
                        style: TextStyle(fontSize: 20, color: ColorHelper.primaryred.withOpacity(0.2), fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        matchStatusScreenController.allData.totalMatch.toString(),
                        style: TextStyle(fontSize: 15, color: ColorHelper.gray, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "|",
                        style: TextStyle(fontSize: 20, color: ColorHelper.primaryred.withOpacity(0.2), fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        matchStatusScreenController.allData.totalMatch.toString(),
                        style: TextStyle(fontSize: 15, color: ColorHelper.gray, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text(
                        "Win",
                        style: TextStyle(fontSize: 15, color: ColorHelper.primaryred, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "|",
                        style: TextStyle(fontSize: 20, color: ColorHelper.primaryred.withOpacity(0.2), fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        matchStatusScreenController.allData.team1WinMatch.toString(),
                        style: TextStyle(fontSize: 15, color: ColorHelper.gray, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "|",
                        style: TextStyle(fontSize: 20, color: ColorHelper.primaryred.withOpacity(0.2), fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        matchStatusScreenController.allData.team2WinMatch.toString(),
                        style: TextStyle(fontSize: 15, color: ColorHelper.gray, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text(
                        "Lost",
                        style: TextStyle(fontSize: 15, color: ColorHelper.primaryred, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "|",
                        style: TextStyle(fontSize: 20, color: ColorHelper.primaryred.withOpacity(0.2), fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        matchStatusScreenController.allData.team1LoseMatch.toString(),
                        style: TextStyle(fontSize: 15, color: ColorHelper.gray, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "|",
                        style: TextStyle(fontSize: 20, color: ColorHelper.primaryred.withOpacity(0.2), fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        matchStatusScreenController.allData.team2LoseMatch.toString(),
                        style: TextStyle(fontSize: 15, color: ColorHelper.gray, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text(
                        "Tie",
                        style: TextStyle(fontSize: 15, color: ColorHelper.primaryred, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "|",
                        style: TextStyle(fontSize: 20, color: ColorHelper.primaryred.withOpacity(0.2), fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        matchStatusScreenController.allData.noResultMatch.toString(),
                        style: TextStyle(fontSize: 15, color: ColorHelper.gray, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        "|",
                        style: TextStyle(fontSize: 20, color: ColorHelper.primaryred.withOpacity(0.2), fontWeight: FontWeight.w600),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        matchStatusScreenController.allData.noResultMatch.toString(),
                        style: TextStyle(fontSize: 15, color: ColorHelper.gray, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  recentMatches() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            matchStatusScreenController.recentMatchList.isNotEmpty?
              Text(
                "Recent Mathes",
                style: TextStyle(fontSize: 18, color: ColorHelper.primaryred, fontWeight: FontWeight.w600),
              ):Container(),

            ],
          ),
          matchStatusScreenController.recentMatchList.isNotEmpty?
          Container(
              height: height * 0.33,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          height: height * 0.26,
                          enableInfiniteScroll: false,
                          viewportFraction: 0.9,
                          disableCenter: true,
                          onPageChanged: (index, reason) {
                            matchStatusScreenController.currentSliderIndex.value = index;
                          }),
                      items: matchStatusScreenController.recentMatchList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                width: width,
                                decoration: BoxDecoration(shape: BoxShape.rectangle, borderRadius: const BorderRadius.all(Radius.circular(10.0)), color: ColorHelper.primaryredlight),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          i.matchIndexNum.toString() + "st Match - " + i.stadiumCity,
                                          style: TextStyle(color: ColorHelper.gray, fontSize: 13),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  child: Image.network(
                                                    i.team1Icon,
                                                    fit: BoxFit.cover,
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        i.team1NiceName,
                                                        style: const TextStyle(color: ColorHelper.black, fontSize: 13, fontWeight: FontWeight.w500),
                                                      ),
                                                      Text(
                                                        "  " + i.team1Run,
                                                        style: TextStyle(color: ColorHelper.gray, fontSize: 11, fontWeight: FontWeight.w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 30,
                                              height: 20,
                                              decoration:
                                                  BoxDecoration(shape: BoxShape.rectangle, borderRadius: const BorderRadius.all(Radius.circular(30.0)), color: ColorHelper.gray.withOpacity(0.2)),
                                              child: const Center(
                                                  child: Text(
                                                "VS",
                                                style: TextStyle(color: ColorHelper.black, fontSize: 8, fontWeight: FontWeight.w500),
                                              )),
                                            ),
                                            Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                  child: Image.network(
                                                    i.team2Icon,
                                                    fit: BoxFit.cover,
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        i.team2NiceName,
                                                        style: const TextStyle(color: ColorHelper.black, fontSize: 13, fontWeight: FontWeight.w500),
                                                      ),
                                                      Text(
                                                        "  " + i.team2Run,
                                                        style: TextStyle(color: ColorHelper.gray, fontSize: 11, fontWeight: FontWeight.w500),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Center(
                                          child: Container(
                                            width: width * 0.4,
                                            height: 30,
                                            decoration: const BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(8.0)), color: ColorHelper.primaryred),
                                            child: Center(
                                                child: Text(
                                              i.winText,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(color: ColorHelper.white, fontSize: 10, fontWeight: FontWeight.w500),
                                            )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20.0, bottom: 2),
                      child: Container(
                        height: height * 0.03,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: matchStatusScreenController.recentMatchList.asMap().entries.map((entry) {
                            return GestureDetector(
                              child: Container(
                                width: matchStatusScreenController.currentSliderIndex.value == entry.key ? 20 : 7,
                                height: 7.0,
                                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: matchStatusScreenController.currentSliderIndex.value == entry.key ? ColorHelper.primaryred : ColorHelper.gray.withOpacity(0.30),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ],
                ),
              ))
          :Container(),

          Center(
            child: InkWell(
              onTap: () {
                adsController.loadShowAdsManager();
                Get.to(() => KeyPlayerScreen(), arguments: [matchStatusScreenController.team1Id, matchStatusScreenController.team2Id]);
              },
              child: Container(
                width: width * 0.45,
                height: 50,
                decoration: const BoxDecoration(shape: BoxShape.rectangle, borderRadius: BorderRadius.all(Radius.circular(8.0)), color: ColorHelper.primaryred),
                child: const Center(
                    child: Text(
                  "TOP KEY PLAYERS",
                  style: TextStyle(color: ColorHelper.white, fontSize: 15, fontWeight: FontWeight.w500),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Controller/Dashboard/dashboard_controller.dart';
import '../../Utils/string_helper.dart';
import '../../Utils/utils.dart';
import '../../Widget/app_bar_view.dart';
import '../../Widget/color_helper.dart';
import '../../Widget/no_internet.dart';
import '../compare_team.dart';
import '../match_status_screen.dart';
import '../schedule_screen.dart';
import '../series_screen.dart';
import '../splash_screen.dart';

class DashBoard extends StatelessWidget {
  DashBoard({super.key});
  DashBoardController dashBoardController = Get.find<DashBoardController>();

  late double height;
  late double width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorHelper.bgColor,
      appBar: const AppBarView(
        title: "DASHBOARD",
        isShowBack: false,
      ),
      body: Obx(
        () {

          if (dashBoardController.showNoInternet.value) {
            return NoInternetWidget(
              onRetry: () {
                if (dashBoardController.networkService.isConnected.value) {
                  dashBoardController.fetchSeriesData();
                }
              },
            );
          }

        if(dashBoardController.isLoading.value) {
          return Utils.circularIndicator(context);
        }

        return RefreshIndicator(
          onRefresh: () {
            return dashBoardController.checkInternet();
          },
          child: SafeArea(
                  child: SizedBox(
                  height: height,
                  width: width,
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Text(
                                  'Upcoming Match',
                                  style: Utils.titleStyleRed,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.020,
                              ),
                              upcomingMatchList(),
                              SizedBox(
                                height: height * 0.018,
                              ),
                              matchListDots(),
                              SizedBox(
                                height: height * 0.025,
                              ),

                              adsPart(),
                              const SizedBox(
                                height: 15,
                              ),

                              upcomingTitle(),
                              const SizedBox(
                                height: 8,
                              ),
                              upcomingSeriesList(),
                              seriesDots(),
                              SizedBox(
                                height: height * 0.019,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  compareButton(),
                                ],
                              ),
                              SizedBox(
                                height: height * 0.025,
                              )
                            ],
                          ),
                        ),
                        Obx(() => dashBoardController.isLoading.value ? loader() : const SizedBox()),
                      ],
                    ),
                  ),
                )),
        );
        }
        ),
    );
  }

  Widget loader() {
    return const Center(
      child: CircularProgressIndicator(
        strokeWidth: 4.0,
        valueColor: AlwaysStoppedAnimation<Color>(
          ColorHelper.primaryred,
        ),
      ),
    );
  }


  adsPart() {
    return dashBoardController.isAdLoaded?
    adsController.nativeAdsPart(height,width)
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

  Widget seriesDots() {
    return SizedBox(
      height: height * 0.03,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: dashBoardController.seriesListDots.asMap().entries.map((entry) {
          return GestureDetector(
            child: Container(
              width: dashBoardController.currentSeriesSliderIndex.value == entry.key ? 20 : 7,
              height: 7.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: dashBoardController.currentSeriesSliderIndex.value == entry.key ? ColorHelper.primaryred : ColorHelper.gray.withOpacity(0.30),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget compareButton() {
    return InkWell(
      onTap: () {
        adsController.loadShowAdsManager();
        Get.to(() => CompareTeams());
      },
      child: Container(
        //width: width / 2,
        // margin: const EdgeInsets.only(left: 4),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(color: ColorHelper.primaryred, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Image.asset(
              '${StringHelper.svgIconPath}/compare.png',
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Compare Team',
              style: Utils.btnTextStyleWhite,
            ),
          ],
        ),
      ),
    );
  }

  Widget upcomingSeriesList() {
    return CarouselSlider.builder(
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          dashBoardController.currentSeriesSliderIndex.value = index;
        },
        // aspectRatio: 2.0,
        enlargeCenterPage: false,
        viewportFraction: 1,
        enableInfiniteScroll: false,
      ),
      itemCount: ((dashBoardController.seriesList.length) / 2).round(),
      itemBuilder: (context, index, realIdx) {
        final int first = index * 2;

        final int second = first + 1;

        return Row(
          children: [first, second].map((idx) {
            return Expanded(
              child: Container(
                padding: EdgeInsets.only(left: idx.isOdd ? 10 : 0, right: idx.isEven ? 10 : 0),
                child: idx == dashBoardController.seriesList.length && dashBoardController.seriesList.length.isOdd
                    ? seriesBlankElement()
                    : seriesElement(idx),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget upcomingTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Upcoming Series',
          style: Utils.titleStyleRed,
        ),
        InkWell(
          onTap: () {
            adsController.loadShowAdsManager();
            Get.to(() => SeriesScreen());
          },
          child: Text(
            'View all',
            style: Utils.text1StyleGrey,
          ),
        ),
      ],
    );
  }

  Widget upcomingMatchList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: SizedBox(
        width: width,
        height: height * 0.29,
        child: Swiper(
          itemCount: dashBoardController.matchList.isNotEmpty ? dashBoardController.matchList.length : 1,
          autoplay: false,
          viewportFraction: 1,
          outer: true,
          scale: 1,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                    onTap: () {
                      adsController.loadShowAdsManager();
                      Get.to(() => MatchStatusScreen(), arguments: [dashBoardController.matchList[index].team1Id, dashBoardController.matchList[index].team2Id]);
                    },
                    child: Container(
                      width: width * 0.95,
                      decoration: BoxDecoration(color: ColorHelper.primaryredlight, borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      DateFormat('dd MMM yyyy').format(dashBoardController.matchList[index].matchTime),
                                      style: Utils.text1StyleGrey,
                                    ),
                                    SizedBox(
                                      width: width * 0.052,
                                    ),
                                    Text(
                                      dashBoardController.matchList[index].stadiumName,
                                      style: Utils.text1StyleGrey,
                                    ),
                                  ],
                                ),
                                // Row(
                                //   children: const [
                                //     Icon(Icons.more_horiz, color: ColorHelper.lightGray2),
                                //   ],
                                // ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.037,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                flagAndTeamName(text: dashBoardController.matchList[index].team1ShortName, img: dashBoardController.matchList[index].team1Logo),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorHelper.light_gray,
                                  ),
                                  child: Text(
                                    'VS',
                                    style: Utils.text1StyleWhite,
                                  ),
                                ),
                                flagAndTeamName(text: dashBoardController.matchList[index].team2ShortName, img: dashBoardController.matchList[index].team2Logo),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.034,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    adsController.loadShowAdsManager();
                                    Get.to(() => ScheduleScreen(), arguments: [dashBoardController.matchList[index].seriesId]);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                                    decoration: BoxDecoration(color: ColorHelper.btnRed, borderRadius: BorderRadius.circular(10)),
                                    child: Text(
                                      'SCHEDULE',
                                      style: Utils.text2StyleWhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
          indicatorLayout: PageIndicatorLayout.SCALE,
          onIndexChanged: (i) {
            dashBoardController.currentMatchSliderIndex.value = i;
          },
        ),
      ),
    );
  }

  Widget matchListDots() {
    return Container(
      alignment: Alignment.center,
      height: height * 0.03,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: dashBoardController.matchList.asMap().entries.map((entry) {
          return GestureDetector(
            child: Container(
              width: dashBoardController.currentMatchSliderIndex.value == entry.key ? 20 : 7,
              height: 7.0,
              margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: dashBoardController.currentMatchSliderIndex.value == entry.key ? ColorHelper.primaryred : ColorHelper.gray.withOpacity(0.30),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget seriesBlankElement() {
    return Container(
      height: height * 0.24,
      width: width * 0.45,
      decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget seriesElement(int index) {
    return InkWell(
      onTap: () {
        adsController.loadShowAdsManager();
        Get.to(() => SeriesScreen());
      },
      child: Container(
        height: height * 0.26,
        width: width * 0.45,
        decoration: BoxDecoration(color: ColorHelper.primaryredlight, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.018,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      dashBoardController.seriesList[index].seriesName,
                      style: Utils.text3StyleDarkGrey,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  upComSerDate(
                      textDate: DateFormat('dd').format(DateFormat("dd-MM-yyyy").parse(dashBoardController.seriesList[index].startDate)),
                      textMonth: DateFormat('MMM').format(DateFormat("dd-MM-yyyy").parse(dashBoardController.seriesList[index].startDate))),
                  Text(
                    'To',
                    style: Utils.text1StyleGrey,
                  ),
                  upComSerDate(
                      textDate: DateFormat('dd').format(DateFormat("dd-MM-yyyy").parse(dashBoardController.seriesList[index].endDate)),
                      textMonth: DateFormat('MMM').format(DateFormat("dd-MM-yyyy").parse(dashBoardController.seriesList[index].endDate))),
                ],
              ),
              SizedBox(
                height: height * 0.025,
              ),

              //Comment for show the TeamIcons in Series list

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     dashBoardController.seriesList[index].teamIconList.length > 3
              //         ? const SizedBox()
              //         : SizedBox(
              //             width: 15,
              //           ),
              //     dashBoardController.seriesList[index].teamIconList.isNotEmpty ? networkImg(index, 0) : const SizedBox(),
              //     dashBoardController.seriesList[index].teamIconList.length > 1 ? networkImg(index, 1) : const SizedBox(),
              //     dashBoardController.seriesList[index].teamIconList.length > 2 ? networkImg(index, 2) : const SizedBox(),
              //     dashBoardController.seriesList[index].teamIconList.length > 3
              //         ? InkWell(
              //             onTap: () {
              //               adsController.loadShowAdsManager();
              //               Get.to(() => SeriesScreen());
              //             },
              //             child: Container(
              //               alignment: Alignment.center,
              //               margin: const EdgeInsets.only(left: 1),
              //               padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
              //               decoration: BoxDecoration(color: ColorHelper.primaryred, borderRadius: BorderRadius.circular(10)),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text(
              //                     '+${dashBoardController.seriesList[index].teamIconList.length - 3}',
              //                     style: Utils.text1StyleWhite,
              //                   ),
              //                   const SizedBox(
              //                     width: 4,
              //                   ),
              //                   const Icon(
              //                     Icons.arrow_forward_rounded,
              //                     color: Colors.white,
              //                     size: 15,
              //                   )
              //                 ],
              //               ),
              //             ),
              //           )
              //         : const SizedBox(),
              //   ],
              // ),
              // SizedBox(
              //   height: height * 0.022,
              // ),
            ],
          ),
        ),
      ),
    );
  }

  //Comment for show the TeamIcons in Series list

  // Widget networkImg(int index, int i, {double hght = 25, double wdth = 25}) {
  //   return Container(
  //     height: hght,
  //     width: wdth,
  //     child: Image.network(
  //       dashBoardController.seriesList[index].teamIconList[i].teamIcon,
  //       errorBuilder: (context, error, stackTrace) => Container(
  //         color: ColorHelper.primaryred.withOpacity(0.2),
  //         width: wdth,
  //         height: hght,
  //       ),
  //     ),
  //   );
  // }

  // Widget assetImg(String path, {double hght = 2, double wdth = 1}) {
  //   return SizedBox(
  //     height: hght,
  //     width: wdth,
  //     child: Image.asset(
  //       path,
  //     ),
  //   );
  // }

  Widget upComSerDate({
    required String textDate,
    required String textMonth,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(width: 1, color: ColorHelper.primaryred.withOpacity(0.2))),
      child: Column(
        children: [
          Text(
            textDate,
            style: Utils.titleStyleRed,
          ),
          SizedBox(
            height: height * 0.037,
          ),
          Text(
            textMonth,
            style: Utils.text2StyleDarkGrey,
          ),
        ],
      ),
    );
  }

  Widget flagAndTeamName({
    required String text,
    required String img,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 70,
          child: Image.network(
            img,
            errorBuilder: (context, error, stackTrace) => Container(
              color: ColorHelper.primaryred.withOpacity(0.2),
              width: 70,
              height: 50,
            ),
            // height: 50,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text.toUpperCase(),
          style: Utils.text1StyleDarkGrey,
        ),
      ],
    );
  }
}

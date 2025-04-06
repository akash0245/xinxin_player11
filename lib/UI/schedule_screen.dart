import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Utils/utils.dart';
import '../Controller/ads_controller.dart';
import '../Controller/schedule_screen_controller.dart';
import '../Widget/app_bar_view.dart';
import '../Widget/color_helper.dart';
import 'match_status_screen.dart';

class ScheduleScreen extends StatelessWidget {

  ScheduleScreenController scheduleScreenController = Get.put(ScheduleScreenController());
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
        title: "SCHEDULE",
      ),
      body: Obx(
            () => scheduleScreenController.isLoading.value
            ? Utils.circularIndicator(context)
            : SafeArea(
            child: Container(
              height: height,
              width: width,
              color: ColorHelper.white,
              // padding: const EdgeInsets.only(left: 0, right: 0),
              child: Stack(
                children: [
                   /*scheduleScreenController..isEmpty
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
                    controller: scheduleScreenController.scrollController,
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //ads part
                        adsPart(),
                        //list of data
                        listOfData(),
                      ],
                    ),
                  ),
                   Obx(() => scheduleScreenController.isDataSubmit.value
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



  adsPart() {
    return scheduleScreenController.isAdLoaded?
    scheduleScreenController.adsController.nativeAdsPart(height,width)
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

  listOfData() {

    return ListView.builder(
        itemCount: scheduleScreenController.schedulematchList.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context,int index){
          return  InkWell(
            onTap: (){
              adsController.loadShowAdsManager();
              Get.to(()=>MatchStatusScreen(),arguments: [scheduleScreenController.schedulematchList[index].team1Id,scheduleScreenController.schedulematchList[index].team2Id]);
            },
            child: scheduleScreenController.schedulematchList[index].adTitle=="GoogleAd"?
            Container()
            :Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color:ColorHelper.primaryredlight
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: width,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                        color:ColorHelper.primaryred,
                      ),
                      child: Center(child: Text(DateFormat('dd MMM yyyy').format(DateFormat("dd-MM-yyyy").parse(scheduleScreenController.schedulematchList[index].matchDate)),style: const TextStyle(fontSize: 15,color: ColorHelper.white,fontWeight: FontWeight.w500),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                      child: Align(alignment: Alignment.topRight,child: Text(scheduleScreenController.schedulematchList[index].matchIndexNum.toString() + "th Match",style: TextStyle(fontSize: 15,color: ColorHelper.gray,fontWeight: FontWeight.w400),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(scheduleScreenController.schedulematchList[index].team1Icon,fit: BoxFit.cover,height: 30,),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(scheduleScreenController.schedulematchList[index].team1NiceName.toString(),style: const TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(scheduleScreenController.schedulematchList[index].team1Run.toString(),style: const TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(scheduleScreenController.schedulematchList[index].team2Icon,fit: BoxFit.cover,height: 30,),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(scheduleScreenController.schedulematchList[index].team2NiceName.toString(),style: const TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),),
                            ),
                          ),
                          Expanded(flex:3,child: Text(scheduleScreenController.schedulematchList[index].team2Run.toString(),style: const TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 15),
                      child: Text(scheduleScreenController.schedulematchList[index].stadiumName+", "+scheduleScreenController.schedulematchList[index].stadiumCity,style: TextStyle(fontSize: 15,color: ColorHelper.gray,fontWeight: FontWeight.w400),),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(scheduleScreenController.schedulematchList[index].textLine,style: const TextStyle(fontSize: 15,color: ColorHelper.primaryred,fontWeight: FontWeight.w500),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

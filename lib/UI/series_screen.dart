import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import '../../Utils/utils.dart';
import '../Controller/series_screen_controller.dart';
import '../Widget/app_bar_view.dart';
import '../Widget/color_helper.dart';

class SeriesScreen extends StatelessWidget {

  SeriesScreenController seriesScreenController = Get.put(SeriesScreenController());
  late double height;
  late double width;
  @override
  Widget build(BuildContext context) {
     height = MediaQuery.of(context).size.height;
      width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorHelper.bgColor,
      appBar: const AppBarView(
        title: "SERIES",
      ),
      body: Obx(
            () => seriesScreenController.isLoading.value
            ? Utils.circularIndicator(context)
            : SafeArea(
            child: Container(
              height: height,
              width: width,
              color: ColorHelper.white,
              child: Stack(
                children: [
                   /*seriesScreenController..isEmpty
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
                        //ads part
                        adsPart(),
                        //list of data
                        listOfData(),
                      ],
                    ),
                  ),
                   /*Obx(() => seriesScreenController.isDataSubmit.value
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



  listOfData() {

    return ListView.builder(
        itemCount: seriesScreenController.seriasList.length,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context,int index){
          return  seriesScreenController.seriasList[index].adTitle=="GoogleAd"?
              Container()
              :Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
                child: Container(
            decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  color:ColorHelper.primaryred.withOpacity(0.2)
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
                    child: Center(child: Text(seriesScreenController.seriasList[index].seriesTitle,style: const TextStyle(fontSize: 15,color: ColorHelper.white,fontWeight: FontWeight.w500),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                    child: Align(alignment: Alignment.topLeft,child: Text(DateFormat('MMM dd').format(DateFormat("dd-MM-yyyy").parse(seriesScreenController.seriasList[index].startDate))+" - "+DateFormat('MMM dd').format(DateFormat("dd-MM-yyyy").parse(seriesScreenController.seriasList[index].lastDate)),style: const TextStyle(fontSize: 15,color: ColorHelper.black,fontWeight: FontWeight.w500),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 10),
                    child: seriesScreenController.seriasList[index].teamIconList.isNotEmpty?

                    Container(
                      height: height * 0.14,
                      child: ListView.builder(
                          itemCount: seriesScreenController.seriasList[index].teamIconList.length >= 3?4:seriesScreenController.seriasList[index].teamIconList.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context,int indexss){
                            return  Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: indexss == 3?
                              Center(
                                  child: Container(
                                  height:50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                      color:ColorHelper.primaryred.withOpacity(0.2)
                                  ),
                                  child: Center(child: Text("+"+(seriesScreenController.seriasList[index].playingTeams-3).toString(),style: const TextStyle(color: ColorHelper.white,fontSize: 15),))))
                                  :Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10.0),
                                        child: Image.network(seriesScreenController.seriasList[index].teamIconList[indexss].teamIcon,fit: BoxFit.cover,height: 60,),
                                      ),
                                      Text(seriesScreenController.seriasList[index].teamIconList[indexss].teamNiceName,style: const TextStyle(color: ColorHelper.black,fontSize: 13),)
                                    ],
                                  ),
                            );
                          }
                      ),
                    )

                    /*Row(
                      children: [

                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(seriesScreenController.seriasList[index].teamIconList![0].teamIcon,fit: BoxFit.cover,height: 30,),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(seriesScreenController.seriasList[index].teamIconList![1].teamIcon,fit: BoxFit.cover,height: 30,),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(seriesScreenController.seriasList[index].teamIconList![2].teamIcon,fit: BoxFit.cover,height: 30,),
                        ),

                      ],
                    )*/:Container(),
                  ),

                ],
            ),
          ),
              );
        }
    );
  }
  adsPart() {
    return seriesScreenController.isAdLoaded?
        seriesScreenController.adsController.nativeAdsPart(height,width)
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

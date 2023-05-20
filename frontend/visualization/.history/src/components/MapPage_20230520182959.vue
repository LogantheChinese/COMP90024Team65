<template>
  <div class="map" id="AuMap"></div>
</template>

<script>
import axios from "axios";
import { onMounted, reactive, inject } from "vue";
export default {
  setup() {
    let $echarts = inject("echarts");
    let mapData = reactive;
    async function getState() {
      mapData = await axios.get("http://localhost:8081/map/Australia.json");
    }
    onMounted(() => {
      getState().then(() => {
        //    console.log("map", mapData);
        $echarts.registerMap("australia", mapData.data);
        let mycharts = $echarts.init(document.getElementById("AuMap"));
        mycharts.setOption({
          title: {
            text:
              "Numbers of Negative Sentiment Tweets in Australia GCCs (Feb/2022 - Aug/2022)",
            subtext: "Data processed by Team65",
            sublink: "https://github.com/LogantheChinese/COMP90024Team65",
            textStyle: {
              fontFamily: "Times New Roman",
              fontSize: 20,
              color: "black"
            },
            subtextStyle: {
              fontFamily: "Times New Roman",
              fontSize: 18,
              color: "black"
            }
          },
          geo: {
            tooltip: {
              show: false
            },
            map: "australia",
            itemStyle: {
              borderColor: "#00ffff",
              areaColor: "rgba(252,230,201)",
              emphasis: {
                areaColor: "rgba(51,161,201,0.9)"
              }
            },
            label: {
                  show: true
                },
            nameMap: {
              "New South Wales": "NSW",
              Victoria: "VIC",
              "Northern Territory": "NT",
              "Western Australia": "WA",
              "South Australia": "SA",
              Tasmania: "TAS",
              Queensland: "QLD",
              "Australian Capital Territory": ""
            }
          },
          tooltip: {
            trigger: "item",
            formatter: "{b}<br/>{c}"
          },
          visualMap: {
            min: 800,
            max: 50000,
            text: ["High", "Low"],
            realtime: false,
            //   calculable: true,
            inRange: {
              color: ["lightskyblue", "yellow", "orangered"]
            }
          },
          series: [
            //   {
            //     type: "map",
            //     map: "australia",

               //  data: [
               //    { name: "NSW", value: 800 },
               //    { name: "VIC", value: 30000 },
               //    { name: "NT", value: 2500 },
               //    { name: "WA", value: 6992 },
               //    { name: "SA", value: 44045 },
               //    { name: "TAS", value: 37659 },
               //    { name: "QLD", value: 45180 },
               //    { name: "", value: 800 }
               //  ],
            //   },
            {
              type: "effectScatter",
              coordinateSystem: "geo",
              tooltip:{
                    show:true
              },
              itemStyle: {
                color: "#b02a02"
              },
              data: [{ name: "Melbourne", value: [144.963, -37.8136, 30000] }]
            }
          ]
        });
      });
    });
    return {
      getState,
      mapData
    };
  }
};
</script>

<style>
.map {
  width: 100%;
  height: 100%;
}
</style>
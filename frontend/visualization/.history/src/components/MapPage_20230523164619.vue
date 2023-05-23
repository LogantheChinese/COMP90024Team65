<template>
  <div class="map" id="AuMap"></div>
</template>

<script>
// import axios from "axios";
import mapData from "./public/Australia.json"
import { onMounted, inject,reactive } from "vue";
export default {
  setup() {
    const mdata = reactive({
      neg:{Melbourne:37188,Sydney:30893,Brisbane:15720,Adelaide:7143,Perth:10413,Hobart:1662,Darwin:1324}
    });
    let $echarts = inject("echarts");
    onMounted(() => {
        $echarts.registerMap("australia", mapData);
        let mycharts = $echarts.init(document.getElementById("AuMap"));
        mycharts.setOption({
          title: {
          //   text:
          //     "Numbers of Negative Sentiment Tweets in Australia GCCs (Feb/2022 - Aug/2022)",
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
              borderWidth: 1.5,
              areaColor: "rgba(252,230,201)",
              emphasis: {
                areaColor: "rgba(252,230,201)"
              }
            },
            label: {
              show: true,
              fontFamily: "Times New Roman"
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
            formatter: function(param) {
              var value = param.value;
              return '<div style="rgba(255,255,255,.3); font-size: 15px;">'
                +"Numbers of Tweets in "
                +param.name+": "+value[2] + " times";
            }
          },
          visualMap: {
            min: 1000,
            max: 40000,
            text: ["High", "Low "],
            textStyle: {
              fontFamily: "Times New Roman",
              fontSize: 15,
              color: "black"
            },
            textGap: 20,
            realtime: false,
            //   calculable: true,
            inRange: {
              colorLightness: [0.9, 0.5]
            },
            outOfRange: {
              color: ["rgba(255,255,255,0.4)"]
            },
            controller: {
              inRange: {
                color: ["#c23531"]
              },
              outOfRange: {
                color: ["#999"]
              }
            }
          },
          series: [
            {
              type: "effectScatter",
              coordinateSystem: "geo",
              tooltip: {
                show: true
              },
              itemStyle: {
                color: "#b02a02"
              },
              data: [
                { name: "Melbourne", value: [144.963, -37.8136, mdata.neg.Melbourne] },
                { name: "Sydney", value: [151.2, -33.8667, mdata.neg.Sydney] },
                { name: "Brisbane", value: [153.028, -27.4678, mdata.neg.Brisbane] },
                { name: "Adelaide", value: [138.6, -34.9333, mdata.neg.Adelaide] },
                { name: "Perth", value: [115.859, -31.9522, mdata.neg.Perth] },
                { name: "Darwin", value: [130.891, -12.4152, mdata.neg.Darwin] },
                { name: "Hobart", value: [147.325, -42.8806, mdata.neg.Hobart] }
              ]
            }
          ]
        });
      // });
    });
    return {
      // getState,
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
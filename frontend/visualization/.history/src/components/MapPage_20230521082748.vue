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
          //   text:
          //     "Numbers of Negative Sentiment Tweets in Australia GCCs (Feb/2022 - Aug/2022)",
            subtext: "Data processed by Team65",
            sublink: "http://localhost:8081/homepage2",
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
            min: 0,
            max: 5000,
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
                { name: "Melbourne", value: [144.963, -37.8136, 800] },
                { name: "Sydney", value: [151.2, -33.8667, 2500] },
                { name: "Brisbane", value: [153.028, -27.4678, 3000] },
                { name: "Adelaide", value: [138.6, -34.9333, 1500] },
                { name: "Perth", value: [115.859, -31.9522, 2000] },
                { name: "Darwin", value: [130.891, -12.4152, 3500] },
                { name: "Hobart", value: [147.325, -42.8806, 1500] }
              ]
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
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
        console.log("map", mapData);
        $echarts.registerMap("australia", mapData.data);
        let mycharts = $echarts.init(document.getElementById("AuMap"));
        mycharts.setOption({
          geo: {
            map: "australia",
            itemStyle: {
              areaColor: "#0099ff",
              borderColor: "#00ffff",
          //     shadowColor: "rgba(230,130,70,0.5)",
          //     shadowBlur: 30,
              emphasis: {
                focus: "self"
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
          }
          // series: [
          //   {
          //     type: "map",
          //     map: "australia",

          //   }
          // ]
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
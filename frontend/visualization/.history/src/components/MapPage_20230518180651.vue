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
          // geo: {
          //   map: "australia"
          // },
          tooltip: {
            trigger: "item",
            formatter: "{b}<br/>{c}"
          },
          toolbox: {
            show: true,
            orient: "vertical",
            left: "right",
            top: "center",
            feature: {
              dataView: { readOnly: false },
              restore: {},
              saveAsImage: {}
            }
          },
          visualMap: {
            min: 800,
            max: 50000,
            text: ["High", "Low"],
            realtime: false,
            calculable: true,
            inRange: {
              color: ["lightskyblue", "yellow", "orangered"]
            }
          },
          series: [
            {
               type: 'map',
          map: 'australia',
              label: {
                show: true
              },
              data: [
                { name: "New South Wales", value: 20057.34 },
                { name: "Victoria", value: 15477.48 },
                { name: "Northern Territory", value: 31686.1 },
                { name: "Western Australia", value: 6992.6 },
                { name: "South Australia", value: 44045.49 },
                { name: "Australian Capital Territory", value: 40689.64 },
                { name: "Tasmania", value: 37659.78 },
                { name: "Queensland", value: 45180.97 }
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
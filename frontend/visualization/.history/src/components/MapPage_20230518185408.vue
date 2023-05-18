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
            {
               type: 'map',
          map: 'australia',
              label: {
                show: true
              },
              data: [
                { name: 'NSW', value: 20057 },
                { name: 'VIC', value: 15477 },
                { name: 'NT', value: 31686 },
                { name: 'WA', value: 6992 },
                { name: 'SA', value: 44045 },
                { name: 'TAS', value: 37659 },
                { name: 'QLD', value: 45180 },
                { name: '', value: 20057 }
              ],
              nameMap:{
               'New South Wales':'NSW',
               'Victoria':'VIC',
               'Northern Territory':'NT',
               'Western Australia':'WA',
               'South Australia':'SA',
               'Tasmania':'TAS',
               'Queensland':'QLD',
               'Australian Capital Territory':''
              }
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
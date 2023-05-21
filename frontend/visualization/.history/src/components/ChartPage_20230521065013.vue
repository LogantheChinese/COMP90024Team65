<template>
  <div class="chart" id = "charts"></div>
</template>

<script>
import { onMounted, reactive, inject } from "vue";
export default {
  setup(){
    let $echarts = inject("echarts");
    let $axios=inject("axios");
    let chartData = reactive({});
    async function getState(){
      chartData=await $axios({url:"http://localhost:8082/getAllTweetNegativeData"})
    }
    onMounted(()=>{
     getState().then(()=>{
          console.log("chart",chartData);
          let myChart = $echarts.init(document.getElementById("charts"))
          myChart.setOption([

          ])

     })
    })
    return{
      getState,chartData
    }
  }
}
</script>

<style>
.chart {
  width: 100%;
  height: 100%;
}
</style>
<template>
  <div class="chart" id="charts"></div>
</template>

<script>
import { onMounted, reactive, inject } from "vue";
export default {
  setup() {
    let $echarts = inject("echarts");
    let $axios = inject("axios");
    let chartData = reactive({});
    async function getState() {
      chartData = await $axios.get("/getAllTweetNegativeData");
    }
    onMounted(() => {
      getState().then(() => {
        console.log("chart", chartData.data.data);
        let myChart = $echarts.init(document.getElementById("charts"));
        myChart.setOption({
          title: {
            text: "Relationship between Unemployment Rate and Negative Sentiment Tweets Ratio",
            textStyle: {
              fontFamily: "Times New Roman",
              fontSize: 20,
              color: "black"
            }
          },
          legend:{
               data:['Unemployment Rata','Negative Sentiment Tweets Ratio']
          },
          series: {
            xAxis: {},
            yAxis: {}
          }
        });
      });
    });
    return {
      getState,
      chartData
    };
  }
};
</script>

<style>
.chart {
  width: 100%;
  height: 100%;
}
</style>
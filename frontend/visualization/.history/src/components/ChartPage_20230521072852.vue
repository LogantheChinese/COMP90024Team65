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
          xAxis: {
               type:'category',
               data:['2022-02','2022-03','2022-04','2022-05','2022-06','2022-07','2022-08']
          },
            yAxis: {
               type:'value'
            },
          series: {

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
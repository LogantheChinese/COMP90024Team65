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
          legend: {
            data: ["Unemployment Rata", "Negative Sentiment Tweets Ratio"],
            textStyle: {
              fontFamily: "Times New Roman",
              fontSize: 15,
              color: "black"
            },
            padding: 10
          },
          tooltip:{
               trigger:'axis'
          },
          xAxis: {
            type: "category",
            data: [
              "2022-02",
              "2022-03",
              "2022-04",
              "2022-05",
              "2022-06",
              "2022-07",
              "2022-08"
            ],
            axisLabel:{
               fontSize:15,
              fontFamily: "Times New Roman",
              color: "black"

            },
          },
          yAxis: {
            type: "value",
            axisLabel: {
              formatter: "{value} %",
              fontSize:15,
              fontFamily: "Times New Roman",
              color: "black"
            },
          },
          series: [
            {
              name: "Unemployment Rata",
              type: "line",
              smooth: true,
              data: [0.05, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08],
              lineStyle:{
               width:3
              }
            },
            {
              name: "Negative Sentiment Tweets Ratio",
              type: "line",
              smooth: true,
              data: [0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
              lineStyle:{
               width:3
              }
            }
          ]
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
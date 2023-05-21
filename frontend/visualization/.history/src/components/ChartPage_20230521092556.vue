<template>
  <div class="chart" id="charts"></div>
</template>

<script>
import { onMounted, reactive, inject } from "vue";
export default {
  setup() {
    let $echarts = inject("echarts");
    let $axios = inject("axios");
    let NegData = reactive({});
    let UData = reactive({});
    let AllData = reactive({});
//     let udata = [];
//     let tdata = [];
    async function getState() {
      NegData = await $axios.get("/getAllTweetNegativeData");
      UData = await $axios.get("/getAllSudoData");
      AllData = await $axios.get("/getAllTweetData");
    }
    onMounted(() => {
      getState().then(() => {
        console.log("chart", NegData.data.data);
        console.log("chart", UData.data.data);
        console.log("chart", AllData.data.data);
        let myChart = $echarts.init(document.getElementById("charts"));
        myChart.setOption({
          title: {
               text:"Melbourne",
            textStyle: {
              fontFamily: "Times New Roman",
              fontSize: 13,
              color: "black"
            }
          },
          legend: {
            data: ["Unemployment", "Negative"],
            textStyle: {
              fontFamily: "Times New Roman",
              fontSize: 10,
              color: "black"
            },
          },
          tooltip: {
            trigger: "axis"
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
            axisLabel: {
              fontSize: 15,
              fontFamily: "Times New Roman",
              color: "black"
            }
          },
          yAxis: {
            type: "value",
            axisLabel: {
              fontSize: 15,
              fontFamily: "Times New Roman",
              color: "black"
            }
          },
          series: [
            {
              name: "Unemployment",
              type: "line",
              smooth: true,
              data: [0.05, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08],
              lineStyle: {
                width: 3
              }
            },
            {
              name: "Negative",
              type: "line",
              smooth: true,
              data: [0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
              lineStyle: {
                width: 3
              }
              //     color:"rgba(34,139,34)"
            }
          ]
        });
      });
    });
    return {
      getState
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
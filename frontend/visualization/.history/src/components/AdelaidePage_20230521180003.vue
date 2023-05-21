<template>
  <div class="chart" id="charts"></div>
</template>
   
   <script>
import { onMounted, inject } from "vue";
export default {
  props: {
    tdata: Object,
    udata: Object
  },
  setup(props) {
    let $echarts = inject("echarts");
    onMounted(() => {
      let myChart = $echarts.init(document.getElementById("charts"));
      myChart.setOption({
        title: {
          text: "Adelaide",
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
          }
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
            data: props.udata["Adelaide"],
            lineStyle: {
              width: 3
            }
          },
          {
            name: "Negative",
            type: "line",
            smooth: true,
            data: props.tdata["Adelaide"],
            lineStyle: {
              width: 3
            }
          }
        ]
      });
    });
    return {};
  }
};
</script>
   
   <style>
.chart {
  width: 100%;
  height: 100%;
}
</style>
<template>
  <div class="chart" id="piecharts"></div>
</template>
      
<script>
import { onMounted, inject } from "vue";
export default {
  props: {
    neg: Number,
    all: Number
  },
  setup(props) {
    let $echarts = inject("echarts");
    onMounted(() => {
      let myChart = $echarts.init(document.getElementById("piecharts"));
      myChart.setOption({
        title: {
          text: "Mastodon Real Time Data",
          textStyle: {
            fontFamily: "Times New Roman",
            fontSize: 13,
            color: "black"
          },
          left: 'right'
        },
        legend: {
          orient: 'vertical',
          left:'left'
        },
        tooltip: {
          trigger: "item"
        },
        series: [
          {
            name: "Mastodon  Numbers",
            type: "pie",
            data: [
               {value: props.neg , name: 'Negative Sentiment Data'},
               {value: props.all, name: 'All '}
            ],
            emphasis:{
               itemStyle:{
                    shadowBlur:10,
                    shadowOffsetX:0,
                    shadowColor: 'rgba(0,0,0,0.5)'
               }
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
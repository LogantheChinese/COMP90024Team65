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
          trigger: "item",
          formatter: function(param) {
              var value = param.value;
              return '<div style="rgba(255,255,255,.3); font-size: 15px;">'
                +"Numbers of Tweets in "
                +value;
            }
        },
        series: [
          {
            name: "Mastodon Data Numbers",
            type: "pie",
            radius: '50%',
            data: [
               {value: props.neg , name: 'Negative Sentiment Data'},
               {value: props.all, name: 'All Data'}
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
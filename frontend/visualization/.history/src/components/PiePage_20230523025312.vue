<template>
  <div class="chart" id="piecharts"></div>
</template>
      
<script>
import { onMounted, inject, watch, ref } from "vue";
export default {
  props: {
    neg: Number,
    all: Number
  },
  setup(props) {
    let $echarts = inject("echarts");
    let myChart = ref(null)
    const updateChart = () => {
      if(myChart.value){
        myChart.value.setOption({
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
          left:'left',
          textStyle: {
            fontFamily: "Times New Roman",
            fontSize: 13,
            color: "black"
          }
        },
        tooltip: {
          trigger: "item",
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
      }
    }
    onMounted(() => {
      myChart.value = $echarts.init(document.getElementById("piecharts"));
      updateChart
    });
    watch(() =>[props.neg,props.all],updateChart);
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
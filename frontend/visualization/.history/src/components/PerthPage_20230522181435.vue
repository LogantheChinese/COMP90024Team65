<template>
  <div class="chart" id="perthcharts"></div>
</template>
   
<script>
import { onMounted, inject,watch } from "vue";
export default {
  props: {
    tdata: Object,
    udata: Object
  },
  watch:{
    watch: {
    tdata: {
      handler(newVal) {
        this.props.tdata=newVal
        // newVal is the updated tdata
        // You can perform some actions here when tdata changes
      },
      deep: true // This ensures that the watcher will detect changes in the nested properties of tdata
    },
    udata: {
      handler(newVal) {
        this.props.udata=newVal
        // newVal is the updated udata
        // You can perform some actions here when udata changes
      },
      deep: true // This ensures that the watcher will detect changes in the nested properties of udata
    }
  }
  },
  setup(props) {
    // let tweetdata = reactive({});
    // let unemploydata = reactive({});
    // watch(
    //   ()=>props.tdata,(newVal) =>{
    //     tweetdata=newVal
    //   },
    //   ()=>props.udata,(newVal)=>{
    //     unemploydata=newVal
    //   }
    // )
    let $echarts = inject("echarts");
    onMounted(() => {
      let myChart = $echarts.init(document.getElementById("perthcharts"));
      myChart.setOption({
        title: {
          text: "Perth",
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
            data: props.udata["Perth"],
            lineStyle: {
              width: 3
            }
          },
          {
            name: "Negative",
            type: "line",
            smooth: true,
            data: props.tdata["Perth"],
            lineStyle: {
              width: 3
            }
          }
        ]
      });
    });
    return {
      // tweetdata,unemploydata
      watch
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
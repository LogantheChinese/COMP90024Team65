<template>
  <router-view/>
</template>
<script>
import {provide} from "vue"
import * as echarts from "echarts"
import axios from "axios"
export default{
  setup(){
    provide("echarts",echarts)
    provide("axios",axios)

  }
}
</script>
<style lang="less">
body{
  background: url("~@/assets/bg.jpg") top center no-repeat;
}
*{
  margin: 0px;
  padding: 0px;
  box-sizing: border-box;
}
</style>

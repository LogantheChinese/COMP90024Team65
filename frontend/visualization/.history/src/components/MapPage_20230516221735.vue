<template>
  <div class="map" id="AuMap">

  </div>
</template>

<script>
import axios from 'axios';
import { onMounted,reactive, inject } from 'vue';
export default {
     setup(){
          let $echarts=inject("echarts")
          let mapData = reactive
          async function getState(){
               mapData = await axios.get("http://localhost:8081/map/Australia.json")
          }
          onMounted(()=>{
               getState().then(()=>{
                    console.log("map",mapData);
                    $echarts.registerMap("australia",mapData.data)
                    let mycharts =$echarts.init(document.getElementById("AuMap"))
                    mycharts.setOption({
                         geo:{
                              map:"australia"
                         }
                    })
               }

               )
          })
          return{
               getState,
               mapData
          }
     }
}
</script>

<style>
.map{
     width: 100%;
     height: 100%;
}
</style>
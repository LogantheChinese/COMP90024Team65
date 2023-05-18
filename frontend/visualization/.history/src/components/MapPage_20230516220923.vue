<template>
  <div class="map">

  </div>
</template>

<script>
import axios from 'axios';
import { onMounted,reactive } from 'vue';
export default {
     setup(){
          let mapData = reactive
          async function getState(){
               mapData = await axios.get("http://localhost:8081/map/Australia.json")
          }
          onMounted(()=>{
               getState().then(()=>{
                    console.log("map",);
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
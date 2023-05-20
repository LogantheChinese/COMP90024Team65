<template>
  <div>
    <header class="homePageHeader">
        <h1>Australia GCCs Tweets Analyzing Engine</h1>
    </header>
    <section class="container">
      <!-- left -->
      <section class="left">
        <h2>Numbers of Negative Sentiment Tweets in Australia GCCs (2022)</h2>
        <MapPage></MapPage>
      </section>
      <!-- mid -->
      <section class="mid">
        <ItemPage>
          <TopLeft></TopLeft>
        </ItemPage>
        <ItemPage>
          <TopLeft></TopLeft>
        </ItemPage>
        <ItemPage>
          <TopLeft></TopLeft>
        </ItemPage>
        <ItemPage>
          <BottomLeft></BottomLeft>
        </ItemPage>
      </section>
      <!-- right -->
      <section class="right">
        <ItemPage>
          <TopRight></TopRight>
        </ItemPage>
        <ItemPage>
          <BottomRight></BottomRight>
        </ItemPage>
        <ItemPage>
          <TopRight></TopRight>
        </ItemPage>
        <ItemPage>
          <BottomRight></BottomRight>
        </ItemPage>
      </section>
    </section>
  </div>
</template>

<script>
import ItemPage from "@/components/ItemPage.vue"
import TopLeft from "@/components/TopLeft.vue"
import TopRight from "@/components/TopRight.vue"
import BottomLeft from "@/components/BottomLeft.vue"
import BottomRight from "@/components/BottomRight.vue"
import {inject} from "vue"
import MapPage from "@/components/MapPage.vue"
export default {
  components:{
    ItemPage,
    TopLeft,
    TopRight,
    BottomLeft,
    BottomRight,
    MapPage
  },
  setup(){
      let $echarts =inject("echarts")
      let $axios = inject("axios")
      console.log($echarts);
      console.log($axios);
    }
}
</script>

<style lang="less">
    .homePageHeader{
        height: 1rem;
        width: 100%;
        h1{
            font-size: .5rem;
            text-align: center;
            line-height: 1rem;
            font-family: 'Times New Roman', Times, serif;
        }
    }
    .container{
      min-width: 1200px;
      max-width: 3024px;
      margin: 0 auto;
      padding: .125rem .125rem 0;
      display: flex;
      .mid, .right{
        flex: 3;
      }
      .left{
        flex: 4;
        height: 10.5rem;
        padding: 0.125rem;
        margin: .25rem;
      }
    }
</style>
<template>
  <div>
    <header class="homePageHeader">
      <h1 @click="goTo2">Australia GCCs Negative Sentiment Tweets Analyzing Engine (Feb/2022 - Aug/2022)</h1>
    </header>
    <section class="container">
      <!-- left -->
      <section class="left">
        <header class="chartTitle">
          <h2
          >Numbers of Negative Sentiment Tweets in Australia GCCs (Feb/2022 - Aug/2022)</h2>
        </header>
        <MapPage></MapPage>
      </section>
      <!-- <section class="right">
        <header class="chartTitle">
          <h2>Unemployment Rate and Negative Sentiment Tweets Ratio Statistics</h2>
        </header>
        <ChartPage></ChartPage>
      </section>-->
    </section>
  </div>
</template>

<script>
// import ItemPage from "@/components/ItemPage.vue"
import MapPage from "@/components/MapPage.vue";
import { useRouter } from 'vue-router';
// import ChartPage from "@/components/ChartPage.vue";
export default {
  components: {
    // ItemPage,
    MapPage,
    // ChartPage
  },
  setup() {
    const router = useRouter();
    const goTo2 =()=>{
      router.push({
        name: "homepage2",
      }
      );
    };
    return {
      goTo2
    }
  }
};
</script>

<style lang="less">
.homePageHeader {
  height: 1rem;
  width: 100%;
  h1 {
    font-size: 0.6rem;
    text-align: center;
    line-height: 1rem;
    font-family: "Times New Roman", Times, serif;
  }
}
.chartTitle {
  font-size: 25;
  font-family: "Times New Roman", Times, serif;
}
.container {
  min-width: 1200px;
  max-width: 3024px;
  margin: 0 auto;
  padding: 0.125rem 0.125rem 0;
  display: flex;
  .left,
  .right {
    flex: 5;
    height: 13rem;
    padding: 0.125rem;
    margin: 0.25rem;
  }
}
</style>
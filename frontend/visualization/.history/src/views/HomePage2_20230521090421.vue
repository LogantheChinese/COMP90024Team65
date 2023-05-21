<template>
  <div>
    <header class="homePageHeader">
      <h1
        @click="goTo1"
      >Australia GCCs Negative Sentiment Tweets Analyzing Engine (Feb/2022 - Aug/2022)</h1>
      <h2>Unemployment Rate and Negative Sentiment Tweets Ratio Statistics in GCCs</h2>
    </header>
    <section class="container">
      <!-- left -->
      <section class="left">
        <ItemPage>
          <ChartPage></ChartPage>
        </ItemPage>
        <ItemPage>
          <ChartPage></ChartPage>
        </ItemPage>
      </section>
      <section class="mid">
        <ItemPage>
          <ChartPage></ChartPage>
        </ItemPage>
        <ItemPage>
          <ChartPage></ChartPage>
        </ItemPage>
      </section>
      <section class="right">
        <ItemPage>
          <ChartPage></ChartPage>
        </ItemPage>
        <ItemPage>
          <ChartPage></ChartPage>
        </ItemPage>
      </section>
      <section class="right2">
        <ItemPage>
          <ChartPage></ChartPage>
        </ItemPage>
      </section>
    </section>
  </div>
</template>
   
   <script>
import ItemPage from "@/components/ItemPage.vue";
import ChartPage from "@/components/ChartPage.vue";
import { useRouter } from "vue-router";
export default {
  components: {
    ItemPage,
    ChartPage
  },
  setup() {
    const router = useRouter();
    const goTo1 = () => {
      router.push({
        name: "homepage"
      });
    };
    return {
      goTo1
    };
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
    line-height: 0.5rem;
    font-family: "Times New Roman", Times, serif;
  }
  h2 {
    font-size: 0.3rem;
    text-align: center;
    line-height: 0.5rem;
    font-family: "Times New Roman", Times, serif;
  }
}
.container {
  min-width: 1200px;
  max-width: 3024px;
  margin: 0 auto;
  padding: 0.125rem 0.125rem 0;
  display: flex;
  .left,
  .right,
  .mid,
  .right2 {
    flex: 2;
    height: 13rem;
//     padding: 0.125rem;
//     margin: 0.1rem;
  }
}
</style>
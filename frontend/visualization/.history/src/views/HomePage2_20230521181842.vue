<template>
  <div>
    <header class="homePageHeader2">
      <h1
        @click="goTo1"
      >Australia GCCs Negative Sentiment Tweets Analyzing Engine (Feb/2022 - Aug/2022)</h1>
      <h2>Unemployment Rate and Negative Sentiment Tweets Ratio Statistics in GCCs</h2>
    </header>
    <section class="container">
      <!-- left -->
      <section class="left">
        <ItemPage>
          <PerthPage :tdata="tdata" :udata="udata"></PerthPage>
        </ItemPage>
        <ItemPage>
          <DarwinPage :tdata="tdata" :udata="udata"></DarwinPage>
        </ItemPage>
      </section>
      <section class="mid">
        <ItemPage>
          <AdelaidePage :tdata="tdata" :udata="udata"></AdelaidePage>
        </ItemPage>
        <ItemPage>
          <MelbournePage :tdata="tdata" :udata="udata"></MelbournePage>
        </ItemPage>
      </section>
      <section class="right">
        <ItemPage>
          <BrisbanePage :tdata="tdata" :udata="udata"></BrisbanePage>
        </ItemPage>
        <ItemPage>
          <SydneyPage :tdata="tdata" :udata="udata"></SydneyPage>
        </ItemPage>
      </section>
      <section class="right2">
        <ItemPage>
          <HobartPage :tdata="tdata" :udata="udata"></HobartPage>
        </ItemPage>
      </section>
    </section>
  </div>
</template>
   
   <script>
import ItemPage from "@/components/ItemPage.vue";
import { useRouter } from "vue-router";
import MelbournePage from "@/components/MelbournePage.vue";
import AdelaidePage from "@/components/AdelaidePage.vue";
import BrisbanePage from "@/components/BrisbanePage.vue";
import DarwinPage from "@/components/DarwinPage.vue";
import HobartPage from "@/components/HobartPage.vue";
import PerthPage from "@/components/PerthPage.vue";
import SydneyPage from "@/components/SydneyPage.vue";

// import { onMounted, reactive, inject } from "vue";

export default {
  components: {
    ItemPage,
    MelbournePage,
    AdelaidePage,
    BrisbanePage,
    DarwinPage,
    HobartPage,
    PerthPage,
    SydneyPage
  },
  setup() {
//     let $axios = inject("axios");
//     let NegData = reactive({});
//     let UData = reactive({});
//     let AllData = reactive({});
    let udata = {'Melbourne':[0.05, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08],
    'Sydney':[0.05, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08],
    'Adelaide':[0.05, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08],
    'Brisbane':[0.05, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08],
    'Darwin':[0.05, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08],
    'Hobart':[0.05, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08],
    'Perth':[0.05, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08],};
    let tdata = {'Melbourne':[0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
    'Sydney':[0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
    'Adelaide':[0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
    'Brisbane':[0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
    'Darwin':[0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
    'Hobart':[0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
    'Perth':[0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06]};
    const router = useRouter();
//     async function getState() {
//       NegData = await $axios.get("/getAllTweetNegativeData");
//       UData = await $axios.get("/getAllSudoData");
//       AllData = await $axios.get("/getAllTweetData");
//     }
//     onMounted(()=>{
//      getState.then(()=>{
//           console.log(NegData);
//           console.log(UData)
//           console.log(AllData)
//      });
//     })
    const goTo1 = () => {
      router.push({
        name: "homepage"
      });
    };
    return {
      goTo1,
     //  getState,
      udata,
      tdata
    };
  }
};
</script>
   
   <style lang="less">
.homePageHeader2 {
  height: 1rem;
  width: 100%;
  h1 {
    font-size: 0.6rem;
    text-align: center;
    line-height: 0.5rem;
    font-family: "Times New Roman", Times, serif;
  };
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
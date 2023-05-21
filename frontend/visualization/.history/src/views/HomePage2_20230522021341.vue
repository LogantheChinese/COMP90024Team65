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
          <PerthPage v-if="udata.Perth[6]!=0&&tdata.Perth[6]!=0" :tdata="tdata" :udata="udata"></PerthPage>
        </ItemPage>
        <ItemPage>
          <DarwinPage v-if="udata.Darwin[6]!=0&&tdata.Darwin[6]!=0" :tdata="tdata" :udata="udata"></DarwinPage>
        </ItemPage>
      </section>
      <section class="mid">
        <ItemPage>
          <AdelaidePage
            v-if="udata.Adelaide[6]!=0&&tdata.Adelaide[6]!=0"
            :tdata="tdata"
            :udata="udata"
          ></AdelaidePage>
        </ItemPage>
        <ItemPage>
          <MelbournePage
            v-if="udata.Melbourne[6]!=0&&tdata.Melbourne[6]!=0"
            :tdata="tdata"
            :udata="udata"
          ></MelbournePage>
        </ItemPage>
      </section>
      <section class="right">
        <ItemPage>
          <BrisbanePage
            v-if="udata.Brisbane[6]!=0&&tdata.Brisbane[6]!=0"
            :tdata="tdata"
            :udata="udata"
          ></BrisbanePage>
        </ItemPage>
        <ItemPage>
          <SydneyPage v-if="udata.Sydney[6]!=0&&tdata.Sydney[6]!=0" :tdata="tdata" :udata="udata"></SydneyPage>
        </ItemPage>
      </section>
      <section class="right2">
        <ItemPage>
          <HobartPage v-if="udata.Hobart[6]!=0&&tdata.Hobart[6]!=0" :tdata="tdata" :udata="udata"></HobartPage>
        </ItemPage>
        <ItemPage>
          <PiePage :neg="500" :all="10000"></PiePage>
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
import PiePage from "@/components/PiePage.vue";
import { reactive, inject, onMounted } from "vue";
export default {
  components: {
    ItemPage,
    MelbournePage,
    AdelaidePage,
    BrisbanePage,
    DarwinPage,
    HobartPage,
    PerthPage,
    SydneyPage,
    PiePage
  },
  setup() {
    let $axios = inject("axios");
    let NegData = reactive({});
    // let UData = reactive({});
    let AllData = reactive({});
    let udata = {
      Melbourne: [0.04875, 0.047625, 0.045375, 0.044125, 0.041749999999999995, 0.039, 0.037375],
      Sydney: [0.044000000000000004, 0.04271428571428571, 0.03892857142857143, 0.038214285714285715, 0.03642857142857143, 0.03442857142857143, 0.03328571428571429],
      Adelaide: [0.049249999999999995, 0.049, 0.0475, 0.047, 0.04650000000000001, 0.044, 0.04125],
      Brisbane: [0.0354, 0.035, 0.034199999999999994, 0.033, 0.0316, 0.027999999999999997, 0.026399999999999996],
      Darwin: [0.032, 0.034, 0.037000000000000005, 0.038, 0.038, 0.037000000000000005, 0.038],
      Hobart: [0.04, 0.040999999999999995, 0.040999999999999995, 0.040999999999999995, 0.042, 0.042, 0.044000000000000004],
      Perth: [0.037200000000000004, 0.0362, 0.0346, 0.0338, 0.0334, 0.0318, 0.0304]
    };
    let tdata = {
      Melbourne: [0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
      Sydney: [0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
      Adelaide: [0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
      Brisbane: [0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
      Darwin: [0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
      Hobart: [0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06],
      Perth: [0.03, 0.03, 0.06, 0.05, 0.04, 0.05, 0.06]
    };
    const router = useRouter();
    async function getState() {
      NegData = await $axios.get("/getAllTweetNegativeData");
      // UData = await $axios.get("/getAllSudoData");
      AllData = await $axios.get("/getAllTweetData");
    }
    const getUnemployment = listData => {
      let cacheData = listData;
      for (let i = 0; i < listData.length; ++i) {
        if (cacheData[i].city == "Adelaide") {
          udata.Adelaide[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Brisbane") {
          udata.Brisbane[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Darwin") {
          udata.Darwin[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Melbourne") {
          udata.Melbourne[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Hobart") {
          udata.Hobart[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Perth") {
          udata.Perth[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else {
          udata.Sydney[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        }
      }
    };
    const getTweets = listData => {
      let cacheData = listData;
      for (let i = 0; i < listData.length; ++i) {
        if (cacheData[i].key.search("Adelaide")!=-1) {
          tdata.Adelaide[Number(cacheData[i].key.substring(5,6)) - 2] =
            cacheData[i].value;
        } else if (cacheData[i].key.search("Brisbane")!=-1) {
          tdata.Brisbane[Number(cacheData[i].key.substring(5,6)) - 2] =
          cacheData[i].value;
        } else if (cacheData[i].key.search("Darwin")!=-1) {
          tdata.Darwin[Number(cacheData[i].key.substring(5,6)) - 2] =
          cacheData[i].value;
        } else if (cacheData[i].key.search("Melbourne")!=-1) {
          tdata.Melbourne[Number(cacheData[i].key.substring(5,6)) - 2] =
          cacheData[i].value;
        } else if (cacheData[i].key.search("Hobart")!=-1) {
          tdata.Hobart[Number(cacheData[i].key.substring(5,6)) - 2] =
          cacheData[i].value;
        } else if (cacheData[i].key.search("Perth")!=-1) {
          tdata.Perth[Number(cacheData[i].key.substring(5,6)) - 2] =
          cacheData[i].value;
        } else {
          tdata.Sydney[Number(cacheData[i].key.substring(5,6)) - 2] =
          cacheData[i].value;
        }
      }
      console.log(tdata)
    };
    const getNegtive = listData => {
      let cacheData = listData;
      for (let i = 0; i < listData.length; ++i) {
        if (cacheData[i].city == "Adelaide") {
          udata.Adelaide[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Brisbane") {
          udata.Brisbane[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Darwin") {
          udata.Darwin[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Melbourne") {
          udata.Melbourne[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Hobart") {
          udata.Hobart[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Perth") {
          udata.Perth[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else {
          udata.Sydney[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        }
      }
    };
    onMounted(() => {
      getState().then(() => {
        console.log(NegData.data.data[0].key.substring(5,6));
        console.log(AllData.data.data[0].value);
      });
    });
    const goTo1 = () => {
      router.push({
        name: "homepage"
      });
    };
    return {
      goTo1,
      getState,
      getUnemployment,
      getTweets,
      getNegtive,
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
    height: 13rem;
    width: 6.5rem;
  }
}
</style>
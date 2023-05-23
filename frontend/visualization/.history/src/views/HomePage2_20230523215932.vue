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
          <PerthPage :tdata="tdata.Perth" :udata="udata.unemploymentData"></PerthPage>
        </ItemPage>
        <ItemPage>
          <DarwinPage :tdata="tdata.Darwin" :udata="udata.unemploymentData"></DarwinPage>
        </ItemPage>
      </section>
      <section class="mid">
        <ItemPage>
          <AdelaidePage :tdata="tdata.Adelaide" :udata="udata.unemploymentData"></AdelaidePage>
        </ItemPage>
        <ItemPage>
          <MelbournePage :tdata="tdata.Melbourne" :udata="udata.unemploymentData"></MelbournePage>
        </ItemPage>
      </section>
      <section class="right">
        <ItemPage>
          <BrisbanePage :tdata="tdata.Brisbane" :udata="udata.unemploymentData"></BrisbanePage>
        </ItemPage>
        <ItemPage>
          <SydneyPage :tdata="tdata.Sydney" :udata="udata.unemploymentData"></SydneyPage>
        </ItemPage>
      </section>
      <section class="right2">
        <ItemPage>
          <HobartPage :tdata="tdata.Hobart" :udata="udata.unemploymentData"></HobartPage>
        </ItemPage>
        <ItemPage>
          <PiePage :neg="mdata.matodonData[0]" :all="mdata.matodonData[1]"></PiePage>
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
import { inject, reactive, onMounted } from "vue";
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
    let NegMData = reactive({});
    let AllMData = reactive({});
    let NegData = reactive({});
    let UData = reactive({});
    let AllData = reactive({});
    const udata = reactive({
      unemploymentData: {
        Melbourne: [
          0.04875,
          0.047625,
          0.045375,
          0.044125,
          0.041749999999999995,
          0.039,
          0.037375
        ],
        Sydney: [
          0.044000000000000004,
          0.04271428571428571,
          0.03892857142857143,
          0.038214285714285715,
          0.03642857142857143,
          0.03442857142857143,
          0.03328571428571429
        ],
        Adelaide: [
          0.049249999999999995,
          0.049,
          0.0475,
          0.047,
          0.04650000000000001,
          0.044,
          0.04125
        ],
        Brisbane: [
          0.0354,
          0.035,
          0.034199999999999994,
          0.033,
          0.0316,
          0.027999999999999997,
          0.026399999999999996
        ],
        Darwin: [
          0.032,
          0.034,
          0.037000000000000005,
          0.038,
          0.038,
          0.037000000000000005,
          0.038
        ],
        Hobart: [
          0.04,
          0.040999999999999995,
          0.040999999999999995,
          0.040999999999999995,
          0.042,
          0.042,
          0.044000000000000004
        ],
        Perth: [
          0.037200000000000004,
          0.0362,
          0.0346,
          0.0338,
          0.0334,
          0.0318,
          0.0304
        ]
      }
    });
    const tdata = reactive({
        Melbourne: [
          0.06188203855697652,
          0.05836463100945572,
          0.059812274659093195,
          0.05993438980785586,
          0.058094127464720924,
          0.05971247146890516,
          0.05755107078936
        ],
        Sydney: [
          0.050913915678159095,
          0.05226645831113637,
          0.05116010952586828,
          0.05461471706781694,
          0.05415914136824305,
          0.05378854885311634,
          0.04881138932417564
        ],
        Adelaide: [
          0.052434456928838954,
          0.050966158879460176,
          0.05098321096678133,
          0.05700621186300918,
          0.055284552845528454,
          0.054729234314444326,
          0.052283362917540745
        ],
        Brisbane: [
          0.06770085224552332,
          0.06179335049815292,
          0.06168495135582695,
          0.06112984822934233,
          0.05799703379907892,
          0.06109238031018206,
          0.05985799207397622
        ],
        Darwin: [
          0.1120042872454448,
          0.11565034544908381,
          0.09301204819277109,
          0.05757891085674644,
          0.05442583732057416,
          0.04310344827586207,
          0.05443548387096774
        ],
        Hobart: [
          0.060810810810810814,
          0.055020632737276476,
          0.04809894640403115,
          0.05469012663902275,
          0.053945818610129564,
          0.06316812439261418,
          0.06666666666666667
        ],
        Perth: [
          0.057306770899003906,
          0.06321728783633362,
          0.064030131826742,
          0.05935200617911297,
          0.05538097526710784,
          0.05174742529123755,
          0.054692852249372
        ]
    });
    const mdata = reactive({
      matodonData: [0, 0]
    });
    const router = useRouter();
    // async function getState() {
    //   NegData = await $axios.get(
    //     "/getAllTweetNegativeData"
    //   );
    //   UData = await $axios.get("/getAllSudoData");
    //   AllData = await $axios.get("/getAllTweetData");
    //   NegMData = await $axios.get(
    //     "/getAllMastodonNegativeData"
    //   );
    //   AllMData = await $axios.get("/getAllMastodonData");
    // }
    async function getState() {
      NegData = await $axios.get(
        "http://localhost:8082/getAllTweetNegativeData"
      );
      UData = await $axios.get("http://localhost:8082/getAllSudoData");
      AllData = await $axios.get("http://localhost:8082/getAllTweetData");
      NegMData = await $axios.get(
        "http://localhost:8082/getAllMastodonNegativeData"
      );
      AllMData = await $axios.get("http://localhost:8082/getAllMastodonData");
    }
    const getUnemployment = listData => {
      let cacheData = listData;
      for (let i = 0; i < listData.length; ++i) {
        if (cacheData[i].city == "Adelaide") {
          udata.unemploymentData.Adelaide[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Brisbane") {
          udata.unemploymentData.Brisbane[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Darwin") {
          udata.unemploymentData.Darwin[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Melbourne") {
          udata.unemploymentData.Melbourne[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Hobart") {
          udata.unemploymentData.Hobart[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else if (cacheData[i].city == "Perth") {
          udata.unemploymentData.Perth[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        } else {
          udata.unemploymentData.Sydney[Number(cacheData[i].month) - 2] =
            cacheData[i].unemployment / 100;
        }
      }
    };
    const getTweets = listData => {
      let cacheData = listData;
      for (let i = 0; i < listData.length; ++i) {
        if (cacheData[i].key.search("Adelaide") != -1) {
          tdata.Adelaide[
            Number(cacheData[i].key.substring(5, 6)) - 2
          ] = cacheData[i].value;
        } else if (cacheData[i].key.search("Brisbane") != -1) {
          tdata.Brisbane[
            Number(cacheData[i].key.substring(5, 6)) - 2
          ] = cacheData[i].value;
        } else if (cacheData[i].key.search("Darwin") != -1) {
          tdata.Darwin[Number(cacheData[i].key.substring(5, 6)) - 2] =
            cacheData[i].value;
        } else if (cacheData[i].key.search("Melbourne") != -1) {
          tdata.Melbourne[
            Number(cacheData[i].key.substring(5, 6)) - 2
          ] = cacheData[i].value;
        } else if (cacheData[i].key.search("Hobart") != -1) {
          tdata.Hobart[Number(cacheData[i].key.substring(5, 6)) - 2] =
            cacheData[i].value;
        } else if (cacheData[i].key.search("Perth") != -1) {
          tdata.Perth[Number(cacheData[i].key.substring(5, 6)) - 2] =
            cacheData[i].value;
        } else {
          tdata.Sydney[Number(cacheData[i].key.substring(5, 6)) - 2] =
            cacheData[i].value;
        }
      }
      console.log('tdata',tdata)
    };
    const getNegtive = listData => {
      let cacheData = listData;
      for (let i = 0; i < listData.length; ++i) {
        if (cacheData[i].key.search("Adelaide") != -1) {
          tdata.Adelaide[Number(cacheData[i].key.substring(5, 6)) - 2] /=
            cacheData[i].value;
        } else if (cacheData[i].key.search("Brisbane") != -1) {
          tdata.Brisbane[Number(cacheData[i].key.substring(5, 6)) - 2] /=
            cacheData[i].value;
        } else if (cacheData[i].key.search("Darwin") != -1) {
          tdata.Darwin[Number(cacheData[i].key.substring(5, 6)) - 2] /=
            cacheData[i].value;
        } else if (cacheData[i].key.search("Melbourne") != -1) {
          tdata.Melbourne[Number(cacheData[i].key.substring(5, 6)) - 2] /=
            cacheData[i].value;
        } else if (cacheData[i].key.search("Hobart") != -1) {
          tdata.Hobart[Number(cacheData[i].key.substring(5, 6)) - 2] /=
            cacheData[i].value;
        } else if (cacheData[i].key.search("Perth") != -1) {
          tdata.Perth[Number(cacheData[i].key.substring(5, 6)) - 2] /=
            cacheData[i].value;
        } else {
          tdata.Sydney[Number(cacheData[i].key.substring(5, 6)) - 2] /=
            cacheData[i].value;
        }
      }
      console.log('succ',tdata)
    };
    onMounted(() => {
      getState().then(() => {
        getUnemployment(UData.data.data);
        getTweets(NegData.data.data);
        getNegtive(AllData.data.data);
        mdata.matodonData[0] = NegMData.data.data[0].value;
        mdata.matodonData[1] = AllMData.data.data[0].value;

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
      tdata,
      udata,
      mdata
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
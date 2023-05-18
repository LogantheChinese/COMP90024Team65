<template>
  <div>
    <header>
        <h1>COVID Discussion In Different Regions With Different Unemployment Rates</h1>
    </header>
    <section class="container">
      <!-- left -->
      <section class="left">
        <ItemPage/>
        <ItemPage/>
      </section>
      <!-- mid -->
      <section class="mid">

      </section>
      <!-- right -->
      <section class="right">
        <ItemPage/>
        <ItemPage/>
      </section>

    </section>
  </div>
</template>

<script>
import ItemPage from "@/components/ItemPage.vue"
export default {
  components:{
    ItemPage
  }
}
</script>

<style lang="less">
    header{
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
      .left, .right{
        flex: 3;
      }
      .mid{
        flex: 5;
      }
    }
</style>
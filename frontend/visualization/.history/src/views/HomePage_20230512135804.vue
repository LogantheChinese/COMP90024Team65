<template>
  <div>
    <header>
        <h1>COVID Discussion In Different Regions With Different Unemployment Rates</h1>
    </header>
    <section class="container">
      //left
      <section class="left">

      </section>
      //mid
      <section class="mid">

      </section>
      //right
      <section class="right">

      </section>

    </section>
  </div>
</template>

<script>
export default {

}
</script>

<style lang="less">
    header{
        height: 1rem;
        width: 100%;
        background-color: rgba(0, 0, 255, 0.2);
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
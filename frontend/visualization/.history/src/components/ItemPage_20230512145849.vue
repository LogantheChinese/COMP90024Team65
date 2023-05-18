<template>
  <div class="item">
     <slot></slot>
  </div>
</template>

<script>
export default {

}
</script>

<style lang="less">
.item{
     height: 5.125rem;
     border: 1px solid blue;
     margin: .25rem;
     background-color: rgba(12, 130, 240, .85);
}
</style>
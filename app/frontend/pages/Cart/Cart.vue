<template>
  <div>
    <h2 class="font-bold text-lg mb-3">Your Pragmatic Cart</h2>
    <ul class="list-disc list-inside">
      <li v-for="item in cart.line_items" :key="item.id">
        {{ item.product.title }}
      </li>
    </ul>
  </div>
</template>

<script setup lang="ts">
import { CartType } from './types'

const { cart } = defineProps<{ cart: CartType }>()
</script>

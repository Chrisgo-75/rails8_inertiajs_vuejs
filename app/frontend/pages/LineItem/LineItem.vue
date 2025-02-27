<template>
  <div>
    <p class="my-5">
      <strong class="block font-medium mb-1">Product:</strong>
      {{ line_item.product_id }}
    </p>
    <p class="my-5">
      <strong class="block font-medium mb-1">Cart:</strong>
      {{ line_item.cart_id }}
    </p>
  </div>
</template>

<script setup lang="ts">
import { LineItemType } from './types'

const { line_item } = defineProps<{ line_item: LineItemType }>()
</script>

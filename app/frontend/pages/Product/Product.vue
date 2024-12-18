<template>
  <div>
    <p class="my-5">
      <strong class="block font-medium mb-1">Title:</strong>
      {{ product.title }}
    </p>
    <p class="my-5">
      <strong class="block font-medium mb-1">Description:</strong>
      {{ product.description }}
    </p>
    <p class="my-5">
      <strong class="block font-medium mb-1">Image:</strong>
      <a v-if="product.image" :href="product.image.url">
        {{ product.image.filename }}
      </a>
    </p>
    <p class="my-5">
      <strong class="block font-medium mb-1">Price:</strong>
      {{ product.price }}
    </p>
  </div>
</template>

<script setup lang="ts">
import { ProductType } from './types'

const { product } = defineProps<{ product: ProductType }>()
</script>

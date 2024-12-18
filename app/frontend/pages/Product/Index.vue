<template>
  <Head title="Products" />

  <div className="mx-auto md:w-2/3 w-full px-8 pt-8">
    <p
      v-if="flash.notice"
      class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block"
    >
      {{ flash.notice }}
    </p>

    <div class="flex justify-between items-center">
      <h1 class="font-bold text-4xl">Products</h1>
      <Link
        href="/products/new"
        class="rounded-lg py-3 px-5 bg-blue-600 text-white block font-medium"
      >
        New product
      </Link>
    </div>

    <div class="min-w-full">
      <template v-for="product in products" :key="product.id">
        <Product :product="product" />
        <p>
          <Link
            :href="`/products/${product.id}`"
            class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
          >
            Show this product
          </Link>
        </p>
      </template>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import Product from './Product.vue'
import { ProductType } from './types'

const { products, flash } = defineProps<{
  products: ProductType[]
  flash: { notice?: string }
}>()
</script>

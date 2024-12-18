<template>
  <Head :title="`Product #${product.id}`" />

  <div className="mx-auto md:w-2/3 w-full px-8 pt-8">
    <div class="mx-auto">
      <p
        v-if="flash.notice"
        class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block"
      >
        {{ flash.notice }}
      </p>

      <h1 class="font-bold text-4xl">Product #{{ product.id }}</h1>

      <Product :product="product" />

      <Link
        :href="`/products/${product.id}/edit`"
        class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
      >
        Edit this product
      </Link>
      <Link
        href="/products"
        class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
      >
        Back to products
      </Link>

      <div class="inline-block ml-2">
        <Link
          :href="`/products/${product.id}`"
          as="button"
          method="delete"
          class="mt-2 rounded-lg py-3 px-5 bg-gray-100 font-medium"
        >
          Destroy this product
        </Link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import Product from './Product.vue'
import { ProductType } from './types'

const { product, flash } = defineProps<{
  product: ProductType
  flash: { notice?: string }
}>()
</script>

<template>
  <div class="w-full">
    <!-- Flash Notice -->
    <p
        v-if="page.props.flash?.notice"
        class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block"
    >
      {{ page.props.flash.notice }}
    </p>

    <!-- Page Title -->
    <div>
      <h1 class="font-bold text-xl mb-6 pb-2 border-b-2">
        Your Pragmatic Catalog
      </h1>
    </div>

    <ul>
      <li v-for="product in products" :key="product.id" class="flex mb-6">
        <img :src="product.image.url" alt="Product Image" class="object-contain w-40 h-48 shadow mr-6" />
        <div>
          <h2 class="font-bold text-lg mb-3">{{ product.title }}</h2>
          <p v-html="product.description"></p>
          <div class="mt-3">
            {{ product.price }}
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script setup lang="ts">
import { usePage} from "@inertiajs/vue3";
import { ProductType} from "../Product/types.ts";

// Props
const { products } = defineProps<{
  products: ProductType[]
}>();

// Debugging
//console.log("Products received:", products);

// Access Inertia.js page props
const page = usePage();
</script>
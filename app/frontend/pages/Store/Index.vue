<template>
  <div class="w-full">
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
            {{ formatCurrency(product.price) }}
            <!-- Add to Cart Button -->
            <button
              @click="addToCart(product.id)"
              class="ml-4 rounded-lg py-1 px-2 text-white bg-green-600"
              >
              Add to Cart
            </button>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script setup lang="ts">
import { usePage} from "@inertiajs/vue3";
import { defineOptions } from 'vue';
import Layout from '../../Layouts/Main.vue';
import { ProductType} from "../Product/types.ts";
import { formatCurrency} from "../../utils/format.ts";
import { ref } from 'vue';
// import axios from "axios";
import { router } from '@inertiajs/vue3';

defineOptions({
  layout: Layout
});

// Get CSRF token from meta tag
const csrfToken = document.querySelector('meta[name="csrf-token"]')?.getAttribute('content');

// Props
const { products } = defineProps<{
  products: ProductType[]
}>();

// Debugging
//console.log("Products received:", products);

// Access Inertia.js page props
const page = usePage();

// Methods
const addToCart = (productId: number) => {
  try {
    router.visit('/line_items', {
      method: 'POST',
      data: { product_id: productId },
    });
    // const response = await axios.post('/line_items',
    //     { product_id: productId },
    //     { headers: { 'X-CSRF-Token': csrfToken } } // Include CSRF token
    // );

    alert('Product added to cart!');
  } catch (error) {
    console.error('Error adding to cart: ', error);
    alert('Failed to add product to cart.');
  }
};
</script>
<template>
  <Head title="Products" />

  <div class="w-full">
    <!-- Flash Notice -->
    <p
        v-if="flash.notice"
        class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block"
    >
      {{ flash.notice }}
    </p>

    <!-- Page Title -->
    <div class="flex justify-between items-center pb-8">
      <h1 class="mx-auto font-bold text-4xl">Products</h1>
    </div>

    <!-- Products Table -->
    <table id="products" class="mx-auto">
      <!-- Table Footer -->
      <tfoot>
      <tr>
        <td colspan="3">
          <div class="mt-8">
            <Link
                href="/products/new"
                class="inline rounded-lg py-3 px-5 bg-green-600 text-white block font-medium"
            >
              New product
            </Link>
          </div>
        </td>
      </tr>
      </tfoot>

      <!-- Table Body -->
      <tbody>
      <template v-for="(product, index) in products" :key="product.id">
        <tr :class="index % 2 === 0 ? 'bg-green-50' : 'bg-white'">
          <!-- Product Image -->
          <td class="px-2 py-3">
            <img :src="product.image.url"
                 alt="Product Image"
                 class="w-40"
                 />
          </td>

          <!-- Product Details -->
          <td>
            <h1 class="text-xl font-bold">{{ product.title }}</h1>
            <p class="my-3">
              {{ truncate(product.description, 80) }}
            </p>
            <p>
              {{ formatCurrency(product.price) }}
            </p>
          </td>

          <!-- Actions -->
          <td class="px-3">
            <ul>
              <li>
                <Link
                    :href="`/products/${product.id}`"
                    class="hover:underline"
                >
                  Show
                </Link>
              </li>
              <li>
                <Link
                    :href="`/products/${product.id}/edit`"
                    class="hover:underline"
                >
                  Edit
                </Link>
              </li>
              <li>
                <button
                    @click="destroyProduct(product.id)"
                    class="hover:underline"
                >
                  Destroy
                </button>
              </li>
            </ul>
          </td>
        </tr>
      </template>
      </tbody>
    </table>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3';
import Product from './Product.vue';
import { ProductType } from './types';
import axios from 'axios';

// Props
const { products, flash } = defineProps<{
  products: ProductType[]
  flash: { notice?: string }
}>();

// Methods
const truncate = (text: string, length: number): string => {
  if (!text) return '';
  return text.length > length ? `${text.substring(0, length)}...` : text;
};

const formatCurrency = (value: number): string => {
  return new Intl.NumberFormat('en-US', {
    style: 'currency',
    currency: 'USD',
  }).format(value);
};

const destroyProduct = (productId: number): void => {
  if (confirm('Are you sure?')) {
    axios.delete(`/api/products/${productId}`)
        .then(() => {
          console.log(`Product with ID ${productId} deleted successfully`);
          // Refresh the product list or remove the deleted product from the UI
        })
        .catch((error) => {
          console.error('Error deleting product:', error);
        });
  }
};
</script>

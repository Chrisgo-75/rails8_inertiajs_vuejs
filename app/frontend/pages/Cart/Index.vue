<template>
  <Head title="Carts" />

  <div className="mx-auto md:w-2/3 w-full px-8 pt-8">
    <div class="flex justify-between items-center">
      <h1 class="font-bold text-4xl">Carts</h1>
      <Link
        href="/carts/new"
        class="rounded-lg py-3 px-5 bg-blue-600 text-white block font-medium"
      >
        New cart
      </Link>
    </div>

    <div class="min-w-full">
      <template v-for="cart in carts" :key="cart.id">
        <Cart :cart="cart" />
        <p>
          <Link
            :href="`/carts/${cart.id}`"
            class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
          >
            Show this cart
          </Link>
        </p>
      </template>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3';
import { defineOptions } from 'vue';
import Cart from './Cart.vue';
import { CartType } from './types';
import Layout from "../../Layouts/Main.vue";

defineOptions({
  layout: Layout
});

const { carts, flash } = defineProps<{
  carts: CartType[]
  flash: { notice?: string }
}>()
</script>

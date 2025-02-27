<template>
  <Head :title="`Cart #${cart.id}`" />

  <div className="mx-auto md:w-2/3 w-full px-8 pt-8">
    <div class="mx-auto">
      <p
        v-if="flash.notice"
        class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block"
      >
        {{ flash.notice }}
      </p>

      <h1 class="font-bold text-4xl">Cart #{{ cart.id }}</h1>

      <Cart :cart="cart" />

      <Link
        :href="`/carts/${cart.id}/edit`"
        class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
      >
        Edit this cart
      </Link>
      <Link
        href="/carts"
        class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
      >
        Back to carts
      </Link>

      <div class="inline-block ml-2">
        <Link
          :href="`/carts/${cart.id}`"
          as="button"
          method="delete"
          class="mt-2 rounded-lg py-3 px-5 bg-gray-100 font-medium"
        >
          Destroy this cart
        </Link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import Cart from './Cart.vue'
import { CartType } from './types'

const { cart, flash } = defineProps<{
  cart: CartType
  flash: { notice?: string }
}>()
</script>

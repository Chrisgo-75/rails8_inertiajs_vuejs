<template>
  <Head title="Editing cart" />

  <div className="mx-auto md:w-2/3 w-full px-8 pt-8">
    <h1 class="font-bold text-4xl">Editing cart</h1>

    <Form
      :cart="cart"
      submitText="Update Cart"
      @onSubmit="handleSubmit"
    />

    <Link
      :href="`/carts/${cart.id}`"
      class="mt-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
    >
      Show this cart
    </Link>
    <Link
      href="/carts"
      class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
    >
      Back to carts
    </Link>
  </div>
</template>

<script setup lang="ts">
import { Head, InertiaForm, Link } from '@inertiajs/vue3'
import Form from './Form.vue'
import { CartFormType, CartType } from './types'

const { cart } = defineProps<{ cart: CartType }>()

const handleSubmit = (form: InertiaForm<CartFormType>) => {
  form.transform((data) => ({ cart: data }))
  form.patch(`/carts/${cart.id}`)
}
</script>

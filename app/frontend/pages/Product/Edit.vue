<template>
  <Head title="Editing product" />

  <div className="mx-auto md:w-2/3 w-full px-8 pt-8">
    <h1 class="font-bold text-4xl">Editing product</h1>

    <Form
      :product="product"
      submitText="Update Product"
      @onSubmit="handleSubmit"
    />

    <Link
      :href="`/products/${product.id}`"
      class="mt-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
    >
      Show this product
    </Link>
    <Link
      href="/products"
      class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
    >
      Back to products
    </Link>
  </div>
</template>

<script setup lang="ts">
import { Head, InertiaForm, Link } from '@inertiajs/vue3'
import Form from './Form.vue'
import { ProductFormType, ProductType } from './types'

const { product } = defineProps<{ product: ProductType }>()

const handleSubmit = (form: InertiaForm<ProductFormType>) => {
  form.transform((data) => ({ product: data }))
  form.patch(`/products/${product.id}`)
}
</script>

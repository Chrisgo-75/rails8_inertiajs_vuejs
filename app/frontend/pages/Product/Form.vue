<template>
  <form @submit.prevent="emit('onSubmit', form)" class="contents">
    <div class="my-5">
      <label for="title">Title</label>
      <input
        type="text"
        name="title"
        id="title"
        v-model="form.title"
        class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
      />
      <div v-if="form.errors.title" :class="$style.error">
        {{ form.errors.title }}
      </div>
    </div>

    <div class="my-5">
      <label for="description">Description</label>
      <textarea
        name="description"
        id="description"
        v-model="form.description"
        rows="4"
        class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
      />
      <div v-if="form.errors.description" :class="$style.error">
        {{ form.errors.description }}
      </div>
    </div>

    <div class="my-5">
      <label for="image">Image</label>
      <input
        type="file"
        name="image"
        id="image"
        @input="form.image = (($event.target as HTMLInputElement).files || [])[0]"
        class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
      />
      <div v-if="form.errors.image" :class="$style.error">
        {{ form.errors.image }}
      </div>
    </div>

    <div class="my-5">
      <label for="price">Price</label>
      <input
        type="number"
        name="price"
        id="price"
        v-model="form.price"
        class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
      />
      <div v-if="form.errors.price" :class="$style.error">
        {{ form.errors.price }}
      </div>
    </div>

    <div class="inline">
      <button
        type="submit"
        :disabled="form.processing"
        class="rounded-lg py-3 px-5 bg-blue-600 text-white inline-block font-medium cursor-pointer"
      >
        {{ submitText }}
      </button>
    </div>
  </form>
</template>

<script setup lang="ts">
import { InertiaForm, useForm } from '@inertiajs/vue3'
import { ProductFormType, ProductType } from './types'

const { product, submitText } = defineProps<{
  product: ProductType
  submitText: string
}>()

const emit = defineEmits<{
  onSubmit: [form: InertiaForm<ProductFormType>]
}>()

const form = useForm<ProductFormType>({
  title: product.title,
  description: product.description,
  price: product.price,
})
</script>

<style module>
.label {
  display: block;
}
.error {
  color: red;
}
</style>

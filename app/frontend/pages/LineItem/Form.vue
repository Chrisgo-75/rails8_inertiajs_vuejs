<template>
  <form @submit.prevent="emit('onSubmit', form)" class="contents">
    <div class="my-5">
      <label for="product">Product</label>
      <input
        type="text"
        name="product"
        id="product"
        v-model="form.product_id"
        class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
      />
      <div v-if="form.errors.product_id" :class="$style.error">
        {{ form.errors.product_id }}
      </div>
    </div>

    <div class="my-5">
      <label for="cart">Cart</label>
      <input
        type="text"
        name="cart"
        id="cart"
        v-model="form.cart_id"
        class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
      />
      <div v-if="form.errors.cart_id" :class="$style.error">
        {{ form.errors.cart_id }}
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
import { LineItemFormType, LineItemType } from './types'

const { line_item, submitText } = defineProps<{
  line_item: LineItemType
  submitText: string
}>()

const emit = defineEmits<{
  onSubmit: [form: InertiaForm<LineItemFormType>]
}>()

const form = useForm<LineItemFormType>({
  product_id: line_item.product_id,
  cart_id: line_item.cart_id,
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

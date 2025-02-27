<template>
  <form @submit.prevent="emit('onSubmit', form)" class="contents">
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
import { CartFormType, CartType } from './types'

const { cart, submitText } = defineProps<{
  cart: CartType
  submitText: string
}>()

const emit = defineEmits<{
  onSubmit: [form: InertiaForm<CartFormType>]
}>()

const form = useForm<CartFormType>({
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

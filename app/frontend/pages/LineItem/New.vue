<template>
  <Head title="New line item" />

  <div className="mx-auto md:w-2/3 w-full px-8 pt-8">
    <h1 class="font-bold text-4xl">New line item</h1>

    <Form
      :line_item="line_item"
      submitText="Create Line item"
      @onSubmit="handleSubmit"
    />

    <Link
      href="/line_items"
      class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
    >
      Back to line items
    </Link>
  </div>
</template>

<script setup lang="ts">
import { Head, InertiaForm, Link } from '@inertiajs/vue3'
import Form from './Form.vue'
import { LineItemFormType, LineItemType } from './types'

const { line_item } = defineProps<{ line_item: LineItemType }>()

const handleSubmit = (form: InertiaForm<LineItemFormType>) => {
  form.transform((data) => ({ line_item: data }))
  form.post('/line_items')
}
</script>

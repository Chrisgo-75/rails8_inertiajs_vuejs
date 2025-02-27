<template>
  <Head title="Line items" />

  <div className="mx-auto md:w-2/3 w-full px-8 pt-8">
    <p
      v-if="flash.notice"
      class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block"
    >
      {{ flash.notice }}
    </p>

    <div class="flex justify-between items-center">
      <h1 class="font-bold text-4xl">Line items</h1>
      <Link
        href="/line_items/new"
        class="rounded-lg py-3 px-5 bg-blue-600 text-white block font-medium"
      >
        New line item
      </Link>
    </div>

    <div class="min-w-full">
      <template v-for="line_item in line_items" :key="line_item.id">
        <LineItem :line_item="line_item" />
        <p>
          <Link
            :href="`/line_items/${line_item.id}`"
            class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
          >
            Show this line item
          </Link>
        </p>
      </template>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import LineItem from './LineItem.vue'
import { LineItemType } from './types'

const { line_items, flash } = defineProps<{
  line_items: LineItemType[]
  flash: { notice?: string }
}>()
</script>

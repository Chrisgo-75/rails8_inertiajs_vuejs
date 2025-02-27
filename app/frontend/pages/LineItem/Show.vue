<template>
  <Head :title="`Line item #${line_item.id}`" />

  <div className="mx-auto md:w-2/3 w-full px-8 pt-8">
    <div class="mx-auto">
      <p
        v-if="flash.notice"
        class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block"
      >
        {{ flash.notice }}
      </p>

      <h1 class="font-bold text-4xl">Line item #{{ line_item.id }}</h1>

      <LineItem :line_item="line_item" />

      <Link
        :href="`/line_items/${line_item.id}/edit`"
        class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
      >
        Edit this line item
      </Link>
      <Link
        href="/line_items"
        class="ml-2 rounded-lg py-3 px-5 bg-gray-100 inline-block font-medium"
      >
        Back to line items
      </Link>

      <div class="inline-block ml-2">
        <Link
          :href="`/line_items/${line_item.id}`"
          as="button"
          method="delete"
          class="mt-2 rounded-lg py-3 px-5 bg-gray-100 font-medium"
        >
          Destroy this line item
        </Link>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Head, Link } from '@inertiajs/vue3'
import LineItem from './LineItem.vue'
import { LineItemType } from './types'

const { line_item, flash } = defineProps<{
  line_item: LineItemType
  flash: { notice?: string }
}>()
</script>

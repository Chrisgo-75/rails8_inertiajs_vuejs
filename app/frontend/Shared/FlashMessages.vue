<template>
  <div v-if="page.props.flash?.notice || page.props.flash?.alert" class="w-full">
    <p v-if="page.props.flash.notice" class="py-2 px-3 bg-green-50 mb-5 text-green-500 font-medium rounded-lg inline-block">
      {{ page.props.flash.notice }}
    </p>
    <p v-if="page.props.flash.alert" class="py-2 px-3 bg-red-50 mb-5 text-red-500 font-medium rounded-lg inline-block">
      {{ page.props.flash.alert }}
    </p>
  </div>
</template>

<script setup lang="ts">
import { usePage } from "@inertiajs/vue3";

const page = usePage();
</script>
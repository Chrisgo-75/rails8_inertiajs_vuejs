<template>
  <minimal-layout>
    <div class="w-full">
      <!-- Flash Notice -->
      <flash-messages />
      <slot /> <!-- This is where page content will be injected -->
    </div>
  </minimal-layout>
</template>

<script setup lang="ts">
import FlashMessages from '../Shared/FlashMessages.vue';


</script>
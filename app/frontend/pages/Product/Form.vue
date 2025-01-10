<template>
  <form @submit.prevent="handleSubmit" class="contents">
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
        rows="10"
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
        @change="handleFileChange"
        class="block shadow rounded-md border border-gray-400 outline-none px-3 py-2 mt-2 w-full"
      />
      <!-- Display file name if available -->
      <div v-if="fileName" class="mt-2 text-gray-600">
        Current file: {{ fileName }}
      </div>
      <div v-if="form.errors.image || validationError" :class="$style.error">
        {{ form.errors.image || validationError }}
      </div>
      <div v-if="previewUrl" class="mt-3">
        <img :src="previewUrl" alt="Preview" class="w-40 h-auto rounded-md" />
      </div>
    </div>

    <div class="my-5">
      <label for="price">Price</label>
      <input
        type="number"
        name="price"
        id="price"
        v-model="form.price"
        step="0.01"
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
import { InertiaForm, useForm } from '@inertiajs/vue3';
import { ref, onMounted, onUnmounted } from 'vue';
import { ProductFormType, ProductType } from './types';

// Props
const { product, submitText } = defineProps<{
  product: ProductType
  submitText: string
}>();

// Emits
const emit = defineEmits<{
  onSubmit: [form: InertiaForm<ProductFormType>]
}>();

// Form Setup
const form = useForm<ProductFormType>({
  title: product.title,
  description: product.description,
  price: product.price,
});

// Validation function
const validateForm = (): boolean => {
  let isValid = true;

  // Clear previous validation errors
  form.errors.title = null;
  form.errors.description = null;
  form.errors.price = null;

  // Validate title
  if (!form.title || form.title.trim().length === 0) {
    form.errors.title = 'Title is required.';
    isValid = false;
  }

  // Validate description
  if (!form.description || form.description.trim().length < 10) {
    form.errors.description = 'Description must be at least 10 characters long.';
    isValid = false;
  }

  // Validate price
  if (typeof(form.price) === 'string') {
    // Remove dollar sign and whitespace, then parse as a float.
    const sanitizedPrice = parseFloat(form.price.replace(/[$,\s]/g, ''));
    if (!Number.isFinite(sanitizedPrice)) {
      form.errors.price = 'Price must be a valid number.';
      isValid = false;
    } else {
      form.price = sanitizedPrice; // Store the valid price.
    }
  } else if (!Number.isFinite(form.price)) {
    form.errors.price = 'Price must be a valid number.';
    isValid = false;
  }

  return isValid;
};

// Handle form submission
const handleSubmit = () => {
  if (!validateForm()) {
    console.error('Form validation failed.');
    return; // Prevent submission if validation fails
  }

  emit('onSubmit', form); // Submit the form if validation passes
};

// Preview for Image Upload
const previewUrl = ref<string | null>(null);
const fileName = ref<string | null>(null);
const validationError = ref<string | null>(null);

// Handle file input changes
const handleFileChange = (event: Event) => {
  // console.log('Event:', event); // Inspect the entire event object
  // console.log('Event target:', event.target);
  const target = event.target;
  if (!(target instanceof HTMLInputElement)) {
    console.error('Event target is not an input element:', target);
    return;
  }
  const input = target as HTMLInputElement;
  // console.log('Input:', input);

  validationError.value = null; // Reset error message.

  if (input && input.files && input.files[0]) {
    const file = input.files[0];

    // File validation
    if (file) {
      // Validate file type
      const allowedTypes = ['image/jpeg', 'image/png', 'image/gif'];
      if (!allowedTypes.includes(file.type)) {
        // alert('Only JPEG, PNG, or GIF files are allowed.');
        validationError.value = 'Only JPEG, PNG, or GIF files are allowed.';
        return;
      }

      // Validate file size (e.g., 2MB limit)
      const maxSizeInBytes = 2 * 1024 * 1024; // 2MB
      if (file.size > maxSizeInBytes) {
        // alert('File size must be less than 2MB.');
        validationError.value = 'File size must be less than 2MB.';
        return;
      }
    } // END file validation.

    form.image = file; // Store the file in the form.
    fileName.value = file.name; // Set the file name.
    previewUrl.value = URL.createObjectURL(file); // Generate a preview URL.
    console.log('File selected:', file); // Log the file object for debugging.
  } else {
    console.log('No file selected or input is invalid.');
    form.image = null;
    fileName.value = null;
    previewUrl.value = null;
  }
};

// Set initial values on mount.
onMounted(() => {
  // alert(JSON.stringify(product.image));
  if (product.image) {
    // previewUrl.value = product.imageUrl; // Display the preview
    fileName.value = product.image.filename; // const filename = product.image?.filename;
  }
});

// Cleanup object URL on component unmount
onUnmounted(() => {
  if (previewUrl.value) {
    URL.revokeObjectURL(previewUrl.value);
  }
});
</script>

<style module>
.label {
  display: block;
}
.error {
  color: red;
}
</style>

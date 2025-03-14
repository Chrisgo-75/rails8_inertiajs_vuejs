<template>
  <div>
    <h2 class="font-bold text-lg mb-3">Your Cart</h2>
    <table class="table-auto w-full">
      <thead>
      <tr>
        <th class="text-right">Quantity</th>
        <th>&times;</th>
        <th>Product</th>
        <th class="text-right">Total Price</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="item in cart.line_items" :key="item.id">
        <td class="text-right">{{ item.quantity }}</td>
        <td>&times;</td>
        <td class="pr-2">{{ item.product.title }}</td>
        <td class="text-right font-bold">
          {{ lineitemTotalPrice(item.product.price, item.quantity) }}
        </td>
      </tr>
      </tbody>
      <tfoot>
      <tr>
        <th class="text-right pr-2 pt-2" colspan="3">Total:</th>
        <td class="text-right pt-2 font-bold border-t-2 border-black">
          {{ cartTotalPrice(cart.line_items) }}
        </td>
      </tr>
      </tfoot>
    </table>
  </div>
  <button
      @click="emptyCart(cart.id)"
      class="ml-4 rounded-lg py-1 px-2 text-white bg-green-600"
  >
    Empty Cart
  </button>
</template>

<script setup lang="ts">
import { CartType } from './types'
import { router } from '@inertiajs/vue3';

const { cart } = defineProps<{ cart: CartType }>()

// Methods
const emptyCart = (cartId: Number) => {
  if (confirm("Are you sure you want to empty the cart?")) {
    try {
      router.delete(`/carts/${cartId}`);
      alert('Request has been sent to backend to empty out Cart!');
    } catch (error) {
      console.error('Error deleting cart: ', error);
      alert('Failed to send request to backend to empty cart.');
    }
  }
};

const lineitemTotalPrice = (productPrice: number, itemQuantity: number) => {
  alert(`Product price: ${productPrice} and Item Quantity: ${itemQuantity}`);
  alert(`Price times quantity is: ${productPrice * itemQuantity}`);
  return `${(productPrice * itemQuantity).toFixed(2)}`;
};

// Method to calculate the total price for the entire cart
const cartTotalPrice = (lineItems: { quantity: number; product: { price: string } }[]) => {
  // alert('Line Items:');
  // alert(JSON.stringify(lineItems));
  return lineItems.reduce((sum, item) => sum + (parseFloat(item.product.price) * item.quantity), 0).toFixed(2);
};

</script>
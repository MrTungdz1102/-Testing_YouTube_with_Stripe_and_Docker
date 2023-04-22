<template>
    <stripe-checkout
      ref="checkoutRef"
      :pk="publishableKey"
      :line-items="lineItems"
      :mode="'payment'"
      @loading="v => loading = v"
    />
    <button @click="submit" style="margin-left: 50%; padding: 10px; margin-top: 10%; border-radius: 5px; color: white; background-color: #4c1ee3; cursor: pointer;">Thanh Toán</button> 
  </template>
  
  <script>
  import { defineComponent, ref } from 'vue';
  import { Stripe } from 'stripe';
  import { StripeCheckout } from 'vue-stripe-checkout';
  import { useRouter } from 'vue-router';
  import { supabase } from '../supabase';
  export default defineComponent({
    components: {
      StripeCheckout,
    },
    setup() {
      const publishableKey = import.meta.env.VITE_STRIPE_KEY;
      const loading = ref(false);
      const lineItems = [
        {
          price: 'price_1Mzi2pHpQ4WsUFgqUvZvKVZf',
          quantity: 1
        }
      ];
      const successUrl = 'http://localhost:5173/success';
      const cancelUrl = 'http://localhost:5173/patchmatch';
      const checkoutRef = ref(null);
      const router = useRouter();
  
      const submit = () => {
        if (checkoutRef.value) {
          checkoutRef.value.redirectToCheckout();
        }
      };
      
      const checkPaymentStatus = async () => {
      const sessionId = this.$route.query.session_id;
      const session = await Stripe.checkout.sessions.retrieve(sessionId);
      if (session.payment_status === 'paid') {
        // handle success
        const { user } = supabase.auth.user();
         const updatedUser = await supabase.from('user').eq('id', user.id).update({ role: 'paid' }).single();
      } else {
        // handle failure
      }
    };
      return {
        publishableKey,
        loading,
        lineItems,
        successUrl,
        cancelUrl,
        checkoutRef,
        submit,
        checkPaymentStatus
      };
    },
    mounted() {
    this.checkPaymentStatus();
  }
  });
  </script>
  
  <style>
  </style>
  
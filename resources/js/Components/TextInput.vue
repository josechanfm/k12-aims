<script setup>
import { onMounted, ref } from 'vue';

defineProps({
    modelValue: String,
});

defineEmits(['update:modelValue']);

const input = ref(null);

onMounted(() => {
    try {
        if (input.value.hasAttribute('autofocus')) {
            input.value.focus();
        }
    }catch (error) {
    }
});

defineExpose({ focus: () => input.value.focus() });
</script>

<template>
    <a-input
        ref="input"
        class="border-gray-300 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 rounded-md shadow-sm"
        :value="modelValue"
        @input="$emit('update:modelValue', $event.target.value)"
        autocomplete="off"
    >
    </a-input>
</template>

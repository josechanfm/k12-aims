<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Teacher Dashboard
            </h2>
        </template>
        <div>
            <p>The collection of route "teacher" is for the general operation management such as serach and preview, which not included setup of year, class or subject etc.</p>
            {{ teacher }}
        </div>
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['teacher'],
    data() {
        return {
        }
    },
    methods: {
    },
}
</script>


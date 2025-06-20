<template>
    <AdminLayout title="Admin">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                Statistic
            </h2>
        </template>
        <div>
            Dashboard
            {{ currentYear }}
        </div>
        <table width="100%" border="1">
            <tr v-for="grade in grades">
                <td>{{ grade.tag }}</td>
                <td>{{ grade.klass_count }}</td>
                <td v-for="klass in grade.klasses">
                    {{ klass.tag }} -- {{ klass.course_count }}
                </td>
            </tr>
        </table>

        
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout
    },
    props: ['currentYear','grades'],
    data() {
        return {
        }
    },
    methods: {
    }
}
</script>


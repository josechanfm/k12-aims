<template>
    <AdminLayout title="健康記錄" :breadcrumb="breadcrumb">
        <div class="py-5">
            <p>Medical Record dashboad, design to show general information and/or statistic of medical treatments.</p>
        </div>


    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import dayjs from 'dayjs';
import KlassSelector from '@/Components/KlassSelector.vue';

export default {
    components: {
        AdminLayout,
        dayjs,
        KlassSelector
    },
    props: [],
    data() {
        return {
            breadcrumb:[
                {label:"保健醫療" ,url:null},
            ],
            dateFormat: 'YYYY-MM-DD',
        }
    },
    created() {
    },
    mounted(){
    },
    methods: {
    },
}
</script>

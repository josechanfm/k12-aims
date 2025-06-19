<template>
    <AdminLayout title="分班">
        選擇學年
        <a-select v-model="yearCode" style="width: 120px">
            <a-select-option v-for="x in  years"  :value="x.code">{{x.code}}</a-select-option>
        </a-select>
        選擇𤥦別
        <a-select v-model="klassId" style="width: 120px">
            <a-select-option v-for="x in  klasses"  :value="x.id">{{x.tag}}</a-select-option>
        </a-select>
        <a-textarea>
            
        </a-textarea>
      

    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['years','klasses'],
    data() {
        return {
         yearCode:0,
        klassId:0,
        }
    },
    methods: {
    }
}
</script>
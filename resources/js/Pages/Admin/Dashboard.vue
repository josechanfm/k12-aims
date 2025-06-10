<template>
    <AdminLayout title="Admin">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                升班操作
            </h2>
        </template>
        <hr/>
        {{ $page.props.user }}
        <div v-role="['director']">
            director
        </div>
        <div v-role="['admin']">
            admin
        </div>
        <ul>
            <li v-for="grade in grades">{{ grade.tag }}</li>
        </ul>
        <p>You may change the additiveStyle from Config table "additive_styles"</p>
        <p>本前沒有報名的步聚,新生註冊表自行政人員直𢮷輸入新生資料,然後成為學生,未正式入學。</p>
        <p>所謂正式入學,指分派年級及班別, 可以新生註冊表選擇進入入學功能(分派年級及班別).</p>
        <p>
            報名:指適齡學童有意報讀本校,報名程序只需要輸入基本資料.資料保存有獨立表單(Candidate).報名表填寫後,可以直接轉入註冊程序,系統<br>
            <a-button as="link" :href="route('admin.candidates.index')" class="ant-btn">Candidate 報名</a-button>
        </p>
        
        <a-button as="link" :href="route('admin.registrations.create')" class="ant-btn">Registration 註冊</a-button>
        <a-button as="link" :href="route('admin.enrollments.index')" class="ant-btn">Enrollement 新生分班</a-button>
        
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


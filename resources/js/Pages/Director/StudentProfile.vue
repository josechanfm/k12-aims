<template>
    <AdminLayout title="個人信息" :breadcrumb="breadcrumb">
        <div class="bg-gradient-to-br from-white to-blue-50 rounded-xl shadow-lg overflow-hidden border border-gray-100 transform transition-all duration-300 hover:shadow-xl">
            <div class="bg-gradient-to-r from-blue-500 to-indigo-600 p-4 flex items-center justify-between">
                <h2 class="text-xl font-bold text-white flex items-center gap-2">
                    <UserOutlined /> 學生信息概覽
                </h2>
                <div class="flex items-center gap-3">
                    <span class="text-white font-medium">編輯模式:</span>
                    <a-switch 
                    v-model:checked="isEditMode" 
                    checkedChildren="開啟" 
                    unCheckedChildren="關閉"
                    class="font-semibold"
                    :class="isEditMode ? 'bg-blue-200' : 'bg-gray-200'"
                    />
                </div>
            </div>
            <div class="p-5">
                <div class="flex flex-col md:flex-row gap-6">
                    <div class="flex-shrink-0 flex justify-center">
                        <div class="bg-gradient-to-br from-blue-100 to-indigo-100 rounded-xl border-2 border-white shadow-md w-32 h-40 flex items-center justify-center overflow-hidden">
                            <div v-if="student.avatars[0] && student.avatars[0].avatar" class="rounded-lg overflow-hidden">
                                <a-image 
                                    width="2.8cm" 
                                    height="3.8cm"
                                    :src="student.avatars[0].avatar.original_url" 
                                    class="rounded-lg object-cover"
                                    :preview="false"
                                />
                            </div>
                            <div v-else>
                                <a-avatar shape="square" :size="158" class="bg-indigo-100">
                                    <template #icon><UserOutlined /></template>
                                </a-avatar>
                            </div>
                        </div>
                    </div>

                    <div class="flex-1 grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div class="space-y-3 text-base">
                            <div class="flex items-start">
                                <div class="w-28 flex-shrink-0 text-indigo-700 font-medium flex items-center">
                                    <i class="fas fa-signature mr-2"></i>中文姓名:
                                </div>
                                <div class="font-semibold text-gray-800 italic">{{ student.name_c || '未填寫' }}</div>
                                </div>
                                
                                <div class="flex items-start">
                                <div class="w-28 flex-shrink-0 text-indigo-700 font-medium flex items-center">
                                    <i class="fas fa-passport mr-2"></i>外文姓名:
                                </div>
                                <div class="font-semibold text-gray-800 italic">{{ student.name_p || '未填寫' }}</div>
                            </div>
                        </div>

                        <div class="space-y-3 text-base">
                            <div class="flex items-start">
                                <div class="w-28 flex-shrink-0 text-indigo-700 font-medium flex items-center">
                                    <i class="fas fa-venus-mars mr-2"></i>性别:
                                </div>
                                <div class="font-semibold text-gray-800">
                                    <span v-if="student.sex === 'M'" class="text-blue-600">{{ student.sex }}</span>
                                    <span v-else-if="student.sex === 'F'" class="text-pink-600">{{ student.sex }}</span>
                                    <span v-else>{{ student.sex || '未填寫' }}</span>
                                </div>
                                </div>
                                
                                <div class="flex items-start">
                                <div class="w-28 flex-shrink-0 text-indigo-700 font-medium flex items-center">
                                    <i class="fas fa-birthday-cake mr-2"></i>出生日期:
                                </div>
                                <div class="font-semibold text-gray-800">
                                    {{ student.b_date || '未填寫' }} 
                                    <span class="ml-2 bg-blue-100 text-blue-800 text-xs font-medium px-2 py-0.5 rounded-full">
                                        ({{ calculateAge(student.b_date) }}歲)
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div class="md:col-span-2 mt-3 pt-3 border-t border-gray-200">
                            <div class="flex items-start">
                                <div class="w-28 flex-shrink-0 text-indigo-700 font-medium flex items-center">
                                    <i class="fas fa-graduation-cap mr-2"></i>歷年年级:
                                </div>
                                <div class="flex flex-wrap gap-2">
                                    <a-tag 
                                    v-for="(klass, index) in student.klasses" 
                                    :key="index"
                                    :color="getTagColor(index)"
                                    class="px-3 py-1 rounded-full font-semibold shadow-sm transform transition-all duration-200 hover:scale-105"
                                    >
                                    {{ klass.school_year }} : {{ klass.tag }}
                                    </a-tag>
                                    <span v-if="!student.klasses || student.klasses.length === 0" class="text-gray-500 italic">
                                    暫無年級信息
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="flex items-center justify-end bg-gray-50 px-5 py-3 border-t border-gray-200 text-sm text-gray-500">
                <RetweetOutlined />最後更新于: {{ new Date().toLocaleDateString() }}
            </div>
        </div>

        
        <div :class="isEditMode ? 'formEditOn' : 'formEditOff'">
            <div class="my-4 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-2xl shadow-md p-3 border border-blue-100">
                <div class="flex flex-col md:flex-row items-center gap-3">
                <!-- 标题区域 -->
                <div class="flex items-center bg-gradient-to-r from-blue-600 to-indigo-700 text-white py-2 px-5 rounded-full shadow-lg min-w-max">
                    <i class="fas fa-sliders-h mr-2"></i>
                    <span class="font-bold text-lg">顯示類型</span>
                </div>
                
                <!-- 选择器区域 -->
                <div class="w-full py-4">
                    <a-checkbox-group 
                    v-model:value="activeKeys" 
                    class="flex flex-wrap gap-2"
                    >
                    <transition-group name="fade" tag="div" class="flex flex-wrap gap-8 md:gap-6">
                        <div v-for="(label, key) in header_zh" :key="key">
                        <a-checkbox 
                            :value="key" 
                            class="hidden"
                            :id="'checkbox-' + key"
                        />
                        <label 
                            :for="'checkbox-' + key"
                            class="option-btn cursor-pointer px-4 py-2 rounded-full text-sm font-medium transition-all duration-300 transform hover:scale-105"
                            :class="{
                            'bg-gradient-to-r from-blue-500 to-indigo-600 text-white shadow-md': activeKeys.includes(key),
                            'bg-white text-gray-700 border border-gray-300 hover:border-blue-400': !activeKeys.includes(key)
                            }"
                        >
                            {{ label }}
                        </label>
                        </div>
                    </transition-group>
                    </a-checkbox-group>
                </div>
                
                <!-- 操作按钮 -->
                <div class="flex gap-2">
                    <a-tooltip title="全選所有類型">
                    <button 
                        @click="selectAll"
                        class="flex items-center px-2 py-2 bg-blue-100 text-blue-700 rounded-full hover:bg-blue-200 transition-colors"
                    >
                        <CheckOutlined />
                    </button>
                    </a-tooltip>
                    <a-tooltip title="清除所有選擇">
                    <button 
                        @click="deselectAll"
                        class="flex items-center px-2 py-2 bg-gray-100 text-gray-700 rounded-full hover:bg-gray-200 transition-colors"
                    >
                        <CloseOutlined />
                    </button>
                    </a-tooltip>
                </div>
                </div>
                
                <!-- 计数器 -->
                <div class="mt-3 text-right text-sm text-gray-500">
                <span class="bg-blue-500 text-white px-2 py-1 rounded-full">
                    已選擇: {{ activeKeys.length }}/{{ Object.keys(header_zh).length }}
                </span>
                </div>
            </div>

        </div>
        <div class="p-6 bg-white rounded-xl shadow-lg">
            <!-- 表单主体 -->
            <a-form
            :model="student"
            layout="vertical"
            :disabled="!isEditMode"
            class="space-y-10"
            >
            <!-- 基本信息卡片 -->
            <a-card title="頭像信息" class="shadow-md" v-if="activeKeys.includes('avatar')">
                <div  class="flex flex-col gap-1 rounded-2xl p-2">
                    <div  v-for="avatar,idx in student.avatars" :key="idx">
                        <UploadAvatars :avatar="avatar"></UploadAvatars>
                        <!-- <div v-if="avatar.image">
                            
                        </div>
                        <div v-else>
                            <a-avatar shape="square" :size="92">
                            </a-avatar>                            
                        </div> -->
                    </div>
                </div>
            </a-card>
            <a-card title="基本信息" class="shadow-md" v-if="activeKeys.includes('basic')">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                <a-form-item label="學生代號" name="stud_id">
                    <a-input v-model:value="student.stud_id" placeholder="請輸入學生代號" />
                </a-form-item>
                <a-form-item label="學生證編號" name="code">
                    <a-input v-model:value="student.code" placeholder="請輸入學生證編號" />
                </a-form-item>
                <a-form-item label="中文姓名" name="name_c">
                    <a-input v-model:value="student.name_c" placeholder="請輸入中文姓名" />
                </a-form-item>
                <a-form-item label="葡文姓名" name="name_p">
                    <a-input v-model:value="student.name_p" placeholder="請輸入葡文姓名" />
                </a-form-item>
                <a-form-item label="性别" name="sex">
                    <a-select v-model:value="student.sex" placeholder="請選擇性別">
                    <a-select-option value="M">男</a-select-option>
                    <a-select-option value="F">女</a-select-option>
                    </a-select>
                </a-form-item>
                <a-form-item label="出生日期" name="b_date">
                    <a-date-picker v-model:value="student.b_date" class="w-full" :valueFormat="dateFormat"/>
                </a-form-item>
                <a-form-item label="出生地點" name="b_place">
                    <a-input v-model:value="student.b_place" placeholder="請輸入出生地點" />
                </a-form-item>
                <a-form-item label="國籍" name="nation">
                    <a-input v-model:value="student.nation" placeholder="請輸入國籍" />
                </a-form-item>
                <a-form-item label="籍貫" name="origin">
                    <a-input v-model:value="student.origin" placeholder="請輸入籍貫" />
                </a-form-item>
                </div>
            </a-card>

            <!-- 证件信息卡片 -->
            <a-card title="證件信息" class="shadow-md" v-if="activeKeys.includes('id_card')">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <a-form-item label="證件類型" name="id_type">
                        <a-select v-model:value="student.id_type" placeholder="請選擇證件類型">
                            <a-select-option value="身份證">身份證</a-select-option>
                            <a-select-option value="護照">護照</a-select-option>
                            <a-select-option value="港澳通行證">港澳通行證</a-select-option>
                        </a-select>
                    </a-form-item>
                    <a-form-item label="證件號碼" name="id_no">
                        <a-input v-model:value="student.id_no" placeholder="請輸入證件號碼" />
                    </a-form-item>
                    <a-form-item label="簽發地點" name="i_place">
                        <a-input v-model:value="student.i_place" placeholder="請輸入簽發地點" />
                    </a-form-item>
                    <a-form-item label="簽發日期" name="i_date">
                        <a-date-picker v-model:value="student.i_date" class="w-full" />
                    </a-form-item>
                    <a-form-item label="有效期" name="v_date">
                        <a-date-picker v-model:value="student.v_date" class="w-full" />
                    </a-form-item>
                    <a-form-item label="逗留許可" name="s6_type">
                        <a-select v-model:value="student.s6_type" placeholder="請選擇逗留許可">
                            <a-select-option :value="1">永久 S6</a-select-option>
                            <a-select-option :value="2">有限期 S6</a-select-option>
                            <a-select-option :value="3">其他逗留許可</a-select-option> 
                        </a-select>
                    </a-form-item>
                    <a-form-item label="簽證簽發日期" name="s6_idate" v-if="student.s6_type != null">
                        <a-date-picker v-model:value="student.s6_idate" class="w-full" />
                    </a-form-item>
                    <a-form-item label="簽證有效期" name="s6_vdate" v-if="student.s6_type == 2 || student.s6_type == 3">
                        <a-date-picker v-model:value="student.s6_vdate" class="w-full" />
                    </a-form-item>
                </div>
            </a-card>

            <!-- 聯絡信息卡片 -->
            <a-card title="聯絡信息" class="shadow-md" v-if="activeKeys.includes('contact')">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <a-form-item label="電話" name="tel">
                        <a-input v-model:value="student.tel" placeholder="請輸入電話號碼" />
                    </a-form-item>
                    <a-form-item label="手機" name="mobile">
                        <a-input v-model:value="student.mobile" placeholder="請輸入手機號碼" />
                    </a-form-item>
                    <a-form-item label="地區" name="area">
                        <a-input v-model:value="student.area" placeholder="請輸入地區" />
                    </a-form-item>
                    <a-form-item label="郵政編碼" name="postal_code">
                        <a-input v-model:value="student.postal_code" placeholder="請輸入郵政編碼" />
                    </a-form-item>
                    <a-form-item label="道路" name="road">
                        <a-input v-model:value="student.road" placeholder="請輸入道路名稱" />
                    </a-form-item>
                    <a-form-item label="詳細地址" name="address">
                        <a-textarea v-model:value="student.address" placeholder="請輸入詳細地址" />
                    </a-form-item>
                    <a-form-item label="住宿地址相同" name="sleep_same">
                        <a-checkbox v-model:checked="student.sleep_same">
                            與通訊地址相同
                        </a-checkbox>
                    </a-form-item>
                    <template v-if="!student.sleep_same">
                        <a-form-item label="住宿地區" name="r_area">
                            <a-input v-model:value="student.r_area" placeholder="請輸入住宿地區" />
                        </a-form-item>
                        <a-form-item label="住宿描述" name="ra_desc">
                            <a-input v-model:value="student.ra_desc" placeholder="請輸入住宿描述" />
                        </a-form-item>
                        <a-form-item label="住宿道路" name="s_road">
                            <a-input v-model:value="student.s_road" placeholder="請輸入住宿道路" />
                        </a-form-item>
                        <a-form-item label="住宿詳細地址" name="s_address">
                            <a-textarea v-model:value="student.s_address" placeholder="請輸入住宿詳細地址" />
                        </a-form-item>
                    </template>
                </div>
            </a-card>

            <!-- 家庭資訊卡片 -->
            <a-card title="家庭信息" class="shadow-md" v-if="activeKeys.includes('family')">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <a-form-item label="父親姓名" name="father">
                        <a-input v-model:value="student.father" placeholder="請輸入父親姓名" />
                    </a-form-item>
                    <a-form-item label="母親姓名" name="mother">
                        <a-input v-model:value="student.mother" placeholder="請輸入母親姓名" />
                    </a-form-item>
                    <a-form-item label="父親職業" name="f_prof">
                        <a-input v-model:value="student.f_prof" placeholder="請輸入父親職業" />
                    </a-form-item>
                    <a-form-item label="母親職業" name="m_prof">
                        <a-input v-model:value="student.m_prof" placeholder="請輸入母親職業" />
                    </a-form-item>
                    <a-form-item label="與監護人關係" name="guard">
                        <a-select v-model:value="student.guard" placeholder="請選擇與監護人關係"> 
                            <a-select-option value="M">母親</a-select-option>
                            <a-select-option value="F">父親</a-select-option>
                            <a-select-option value="O">其他</a-select-option> 
                        </a-select>
                    </a-form-item>
                    <a-form-item label="與監護人同住" name="live_same">
                        <a-checkbox v-model:checked="student.live_same">
                            與監護人同住
                        </a-checkbox>
                    </a-form-item>
                </div>
            </a-card>

            <!-- 緊急聯絡人卡片 -->
            <a-card title="緊急聯絡人信息" class="shadow-md" v-if="activeKeys.includes('emergency_contact')">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <a-form-item label="緊急聯絡人姓名" name="ec_name">
                        <a-input v-model:value="student.ec_name" placeholder="請輸入緊急聯絡人姓名" />
                    </a-form-item>
                    <a-form-item label="關係" name="ec_rel">
                        <a-input v-model:value="student.ec_rel" placeholder="請輸入關係" />
                    </a-form-item>
                    <a-form-item label="電話" name="ec_tel">
                        <a-input v-model:value="student.ec_tel" placeholder="請輸入電話" />
                    </a-form-item>
                    <a-form-item label="地區" name="ec_area">
                        <a-input v-model:value="student.ec_area" placeholder="請輸入地區" />
                    </a-form-item>
                    <a-form-item label="郵政編碼" name="ec_postal_code">
                        <a-input v-model:value="student.ec_postal_code" placeholder="請輸入郵政編碼" />
                    </a-form-item>
                    <a-form-item label="道路" name="ec_road">
                        <a-input v-model:value="student.ec_road" placeholder="請輸入道路名稱" />
                    </a-form-item>
                    <a-form-item label="詳細地址" name="ec_address">
                        <a-textarea v-model:value="student.ec_address" placeholder="請輸入詳細地址" />
                    </a-form-item>
                </div>
            </a-card>

            <!-- 監護人資訊卡片 -->
            <a-card title="監護人資訊" class="shadow-md" v-if="activeKeys.includes('guardian') && (student.guard == 'O' || !student.live_same)">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <template v-if="student.guard == 'O'">
                        <a-form-item label="監護人姓名" name="g_name">
                            <a-input v-model:value="student.g_name" placeholder="請輸入監護人姓名" />
                        </a-form-item>
                        <a-form-item label="關係" name="g_relation">
                            <a-input v-model:value="student.g_relation" placeholder="請輸入關係" />
                        </a-form-item>
                        <a-form-item label="職業" name="g_profession">
                            <a-input v-model:value="student.g_profession" placeholder="請輸入職業" />
                        </a-form-item>
                    </template>
                    <a-form-item label="地區" name="g_area">
                        <a-input v-model:value="student.g_area" placeholder="請輸入地區" />
                    </a-form-item>
                    <a-form-item label="郵政編碼" name="g_postal_code">
                        <a-input v-model:value="student.g_postal_code" placeholder="請輸入郵政編碼" />
                    </a-form-item>
                    <a-form-item label="道路" name="g_road">
                        <a-input v-model:value="student.g_road" placeholder="請輸入道路名稱" />
                    </a-form-item>
                    <a-form-item label="詳細地址" name="g_address">
                        <a-textarea v-model:value="student.g_address" placeholder="請輸入詳細地址" />
                    </a-form-item>
                    <a-form-item label="電話" name="g_tel">
                        <a-input v-model:value="student.g_tel" placeholder="請輸入電話" />
                    </a-form-item>
                    <a-form-item label="手機" name="guardmobile">
                        <a-input v-model:value="student.guardmobile" placeholder="請輸入監護人手機" />
                    </a-form-item>
                </div>
            </a-card>

            <!-- 學校資訊卡片 -->
            <a-card title="學校信息" class="shadow-md" v-if="activeKeys.includes('school')">
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <a-form-item label="校部編號" name="s_code">
                        <a-input v-model:value="student.s_code" placeholder="請輸入校部編號" />
                    </a-form-item>
                    <a-form-item label="年級" name="grade">
                        <a-input v-model:value="student.grade" placeholder="請輸入年級" />
                    </a-form-item>
                    <a-form-item label="班級" name="class">
                        <a-input v-model:value="student.class" placeholder="請輸入班級" />
                    </a-form-item>
                    <a-form-item label="班內序號" name="c_no">
                        <a-input v-model:value="student.c_no" placeholder="請輸入班內序號" />
                    </a-form-item>
                </div>
            </a-card>

            <div class="flex justify-center gap-4 mt-10">
                <a-button 
                v-if="isEditMode"
                type="primary" 
                size="large"
                class="min-w-[120px] bg-green-600 hover:bg-green-700 transition-colors"
                @click="submitForm"
                :loading="submitting"
                >
                保存信息
                </a-button>
                <a-button 
                v-if="isEditMode"
                size="large"
                class="min-w-[120px]"
                @click="toggleEditMode"
                :disabled="submitting"
                >
                取消
                </a-button>
            </div>
            </a-form>
        </div>
        <!-- <a-typography-title :level="3">個人文件檔案</a-typography-title> -->
        <!-- <ol>
            <li v-for="file in student.medias">
                {{file.collection_name }}: <a :href="file.original_url" target="_blank">{{ file.file_name }}</a>
            </li>
        </ol> -->
    </AdminLayout>
</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { Link,router } from '@inertiajs/vue3';
import { UserOutlined, RetweetOutlined,CheckOutlined,CloseOutlined } from '@ant-design/icons-vue';
import UploadAvatars from "../../Components/UploadAvatars.vue";

export default {
    components: {
        UploadAvatars,
        AdminLayout, Link,
        UserOutlined,
        RetweetOutlined,
        CheckOutlined,
        CloseOutlined
    },
    props: ['student','nations'],
    data() {
        return {
            header_zh:{'avatar':'頭像照片','basic':'基本信息','id_card':'證件信息',
                        'contact':'聯絡信息','school':'學校信息','family':'父母信息','guardian':'監護人信息'},
            breadcrumb: [
                { label: "主控台", url: route('director.dashboard') },
                { label: "學人個人檔案", url: null }
            ],
            columnSiblings:[
                {title:'姓名', dataIndex: 'name_c'},
                {title:'性別', dataIndex: 'gender'},
                {title:'出生日期', dataIndex: 'dob'},
                {title:'就讀班級', dataIndex: 'klasses'},
            ],
            rules: {
                name_c: { required: true },
                id_type: { required: true },
                id_type_other: { required: true },
                issue_place_other: { required: true },
                id_num: { required: true },
            },
            dateFormat: 'YYYY-MM-DD',
            idTypeOptions: [
                { value: 'MP', label: '永久居民身份證' },
                { value: 'MR', label: '居民身分證' },
                { value: 'MT', label: '非永久居民身份證' },
                { value: 'CT', label: '臨時逗留證' },
                { value: 'CN', label: '中國內地身份證' },
                { value: 'OT', label: '其他' }
            ],
            pobOptions: [
                { value: 'MO', label: '澳門' },
                { value: 'CN', label: '內地' },
                { value: 'OT', label: '其他' },
            ],
            issuePlaceOptions: [
                { value: 'MO', label: '澳門' },
                { value: 'CN', label: '內地' },
                { value: 'OT', label: '其他' },
            ],
            activeKeys: [ "avatar", "basic", "id_card", "contact", "school", "family", "guardian" ],
            labelCol: { span: 10 }, 
            wrapperCol: { span: 14 },
            isEditMode:false,
            submitting:false,
        }
    },
    created() {
        // this.init()    
    },
    mounted(){
    },  
    methods: {     
        init(){
            if (this.student.address == null) this.student.address = {}
            if (this.student.identity_document == null) this.student.identity_document = {}
            if (this.student.bank == null) this.student.bank = {}
            if (this.student.detail == null) this.student.detail = {}
            if (this.student.health == null) this.student.health = {}
            if(this.student.relatives){
                var mother=this.student.relatives.find(r=>r.relation=='MOTHER')
                var father=this.student.relatives.find(r=>r.relation=='FATHER')
                var guardian=this.student.relatives.find(r=>r.relation=='GUARDIAN')
            }else{
                this.student.relatives=[];
            }
            if(mother){
                this.student.mother=mother
            }else{
                this.student.mother={"relation":'MOTHER'}
                this.student.relatives.push({"relation":'MOTHER'})
            }
            if(father){
                this.student.father=father
            }else{
                this.student.father={"relation":'FATHER'}
                this.student.relatives.push(this.student.father)
            }
            if(guardian){
                this.student.guardian=guardian
            }else{
                this.student.guardian={"relation":'GUARDIAN'}
                this.student.relatives.push(this.student.guardian)
            }
            // this.student.father=father??{"relation":'1FATHER'};
            // this.student.mother=mother??{"relation":'0MONTHER'};
            // this.student.guardian=guardian??{"relation":'2GUARDIAN'};

            // this.student.father=this.student.relations.find(r=>r.relation=='1FATHER')
            // this.student.mother=this.student.relations.find(r=>r.relation=='0MOTHER')
            // this.student.guardian=this.student.relations.find(r=>r.relation=='2GUARDIAN')
        },
        onFinish() {
            console.log(this.student.health);
            this.$inertia.patch(route('director.students.update', this.student.id), this.student, {
                onSuccess: (page) => {
                    console.log(page)
                    this.init()                    
                },
                onError: (error) => {
                    console.log(error);
                }
            })
        },
        onFinishFailed(error) {
            console.log(error)
        },
        calculateAge(dob){
          let currentDate = new Date();
          let birthDate = new Date(dob);
          let difference = currentDate - birthDate;
          let age = Math.floor(difference/31557600000);
          return age
        },
        selectAll(){
            this.activeKeys = Object.keys(this.header_zh);
        },
        deselectAll() {
            this.activeKeys = [];
        },
        toggleEditMode(){
            router.reload({
                only: ['student'],
                preserveScroll: true,
                onFinish: () => {
                    this.isEditMode = false
                }
            })
        },
        resetForm (){

        },
        submitForm (){
            this.submitting = true
            try{
                router.put(route('director.students.update', this.student.id),this.student, {
                    preserveScroll: true,
                    onSuccess: () => {
                        this.isEditMode = false
                        this.submitting = false
                    },
                    onError: () => {
                        this.submitting = false
                    }
                })
            }catch(error){
                console.log(error);
                this.submitting = false
            }
        }
    },
}
</script>

<style>
.ant-input {
    border: none
}

.ant-form-item-label label {
    font-weight: bold;
}

.formEditOn .ant-input, .formEditOn .ant-picker {
    border: 1px solid #ccc
}

.formEditOff .ant-input, .formEditOff .ant-picker, .formEditOff .ant-select:not(.ant-select-customize-input) .ant-select-selector{
    border: none;
    pointer-events: none;
    
}

.ant-card {
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid #e8e8e8;
}

.ant-card-head {
  @apply bg-gradient-to-r from-blue-500 to-indigo-600 text-white !important;
}

/* 表单标签样式 */
.ant-form-item-label > label {
  font-weight: 500;
  color: #333;
}

/* 输入框在编辑模式下的样式 */
.ant-input, .ant-select-selector, .ant-picker {
  border-radius: 8px !important;
}

/* 添加一些间距和响应式调整 */
@media (max-width: 768px) {
  .grid-cols-3, .grid-cols-2 {
    grid-template-columns: 1fr;
  }
}

</style>
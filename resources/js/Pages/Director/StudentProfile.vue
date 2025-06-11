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
                    v-model:checked="isEdit" 
                    @change="onChangeEditMode"
                    checkedChildren="開啟" 
                    unCheckedChildren="關閉"
                    class="font-semibold"
                    :class="isEdit ? 'bg-blue-200' : 'bg-gray-200'"
                    />
                </div>
            </div>

            <div class="p-5">
                <div class="flex flex-col md:flex-row gap-6">
                    <div class="flex-shrink-0 flex justify-center">
                        <div class="bg-gradient-to-br from-blue-100 to-indigo-100 rounded-xl border-2 border-white shadow-md p-2 w-32 h-40 flex items-center justify-center overflow-hidden">
                            <div v-if="student.avatars[0] && student.avatars[0].image" class="rounded-lg overflow-hidden">
                                <a-image 
                                    width="2.4cm" 
                                    height="3.2cm"
                                    :src="student.avatars[0].image.original_url" 
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

        
        <div :class="isEdit ? 'formEditOn' : 'formEditOff'">
            <div class="my-2 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-2xl shadow-md p-3 border border-blue-100">
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
                    class="flex flex-wrap gap-2 h-auto xl:h-20 2xl:h-auto"
                    >
                    <transition-group name="fade" tag="div" class="flex flex-wrap gap-8 md:gap-4">
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
                            <i 
                            class="mr-2 text-xs" 
                            :class="activeKeys.includes(key) ? 'fas fa-check-circle' : 'far fa-circle'"
                            ></i>
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
                        class="p-2 bg-blue-100 text-blue-700 rounded-full hover:bg-blue-200 transition-colors"
                    >
                        <CheckOutlined />
                    </button>
                    </a-tooltip>
                    <a-tooltip title="清除所有選擇">
                    <button 
                        @click="deselectAll"
                        class="p-2 bg-gray-100 text-gray-700 rounded-full hover:bg-gray-200 transition-colors"
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
            <a-form ref="formRef" name="advanced_search" class="ant-advanced-search-form" :model="student"
                 :labelWrap='true'	  label-align="right"
                :rules="rules" @finish="onFinish" @finishFailed="onFinishFailed">
                <div class="flex flex-col gap-2 bg-white p-2">
                    <transition-group name="list">
                    <div class="ant-form-bg" key="avatar" header=""  v-if='activeKeys.includes("avatar")  ||  activeKeys.includes("all")' >
                        <div class="form-header">頭像照片</div>
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
                    </div>
                    <div class="ant-form-bg"  v-if='activeKeys.includes("basic")  ||  activeKeys.includes("all")' >
                        <div class="form-header">基本信息</div>
                        <div class="flex flex-col gap-1 rounded-2xl p-2">
                            <div class="flex flex-wrap gap-1">
                                <a-form-item class="student-form-layout" label="姓名" name="name_zh"   >
                                    <a-textarea autosize  v-model:value="student.name_zh" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="校內編號"   >
                                    <a-textarea autosize  v-model:value="student.sid" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="教青局編號"   >
                                    <a-textarea autosize  v-model:value="student.dsedj_num" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="衛生局金咭編號"   >
                                    <a-textarea autosize  v-model:value="student.ssm_num" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="學生手提電話"   >
                                    <a-textarea autosize  v-model:value="student.phone" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="外文姓名"     >
                                    <a-textarea autosize  v-model:value="student.name_fn" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="成績表顯示英文名稱"     >
                                    <a-textarea autosize  v-model:value="student.name_display" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="過往就請學校"     >
                                    <a-textarea autosize  v-model:value="student.previour_school" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="過往就年級"    >
                                    <a-textarea autosize  v-model:value="student.previour_grade" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="班別號"    >
                                    <a-textarea autosize  v-model:value="student.start_klass" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="接收短訊用手提電話"  >
                                    <a-textarea autosize  v-model:value="student.phone_sms" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="性別" >
                                    <a-textarea autosize  v-model:value="student.gender" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="出生日期"   >
                                    <a-date-picker v-model:value="student.dob" :format="dateFormat" :valueFormat="dateFormat" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="入學日期"   >
                                    <a-date-picker v-model:value="student.entry_date" :format="dateFormat" :valueFormat="dateFormat" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="監護人"   >
                                    display guardian
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="宗教"   >
                                    <a-textarea autosize  v-model:value="student.religion" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="住宅電話"   >
                                    <a-textarea autosize  v-model:value="student.phone_home" />
                                </a-form-item>
                            </div>
                        </div>
                    </div>
                    <div class="ant-form-bg" v-if='activeKeys.includes("id_card") ||  activeKeys.includes("all")' >
                        <div  class="form-header">證件信息</div>
                        <div class="flex flex-col ">
                            <div class="flex flex-wrap gap-1">
                                <a-form-item class="student-form-layout" label="證件類別" name="id_type">
                                    <a-select placeholder="請選擇證件類別" v-model:value="student.id_type" :options="idTypeOptions" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="請指明證件類別" name="id_type_other" v-if="student.id_type == 'OT'">
                                    <a-textarea autosize  v-model:value="student.id_type_other" />
                                </a-form-item>
                                <template v-if="student.id_type == 'OT'">
                                    <a-form-item class="student-form-layout" label="簽發地點">
                                        <a-select v-model:value="student.issue_place" :options="issuePlaceOptions" />
                                    </a-form-item>
                                    <a-form-item class="student-form-layout" label="請指明簽發地點" name="issue_place_other"
                                        v-if="student.issue_place == 'OT'">
                                        <a-textarea autosize  v-model:value="student.issue_place_other" />
                                    </a-form-item>
                                </template>
                                <a-form-item class="student-form-layout" label="證件編號" name="id_num">
                                    <a-textarea autosize  v-model:value="student.id_num" />
                                </a-form-item>
                                <template v-if="student.id_type == 'CT'">
                                    <a-form-item class="student-form-layout" label="逗留簽發日期">
                                        <a-date-picker v-model:value="student.stay_issue" :format="dateFormat"
                                            :valueFormat="dateFormat" />
                                    </a-form-item>
                                    <a-form-item class="student-form-layout" label="逗留至有效日期">
                                        <a-date-picker v-model:value="student.stay_expired" :format="dateFormat"
                                            :valueFormat="dateFormat" />
                                    </a-form-item>
                                </template>
                                <template v-else>
                                    <a-form-item class="student-form-layout" label="本次發出日期">
                                        <a-date-picker v-model:value="student.id_issue" :format="dateFormat"
                                            :valueFormat="dateFormat" />
                                    </a-form-item>
                                    <a-form-item class="student-form-layout" label="有效日期">
                                        <a-date-picker v-model:value="student.id_expired" :format="dateFormat"
                                            :valueFormat="dateFormat" />
                                    </a-form-item>
                                </template>
                                <a-form-item class="student-form-layout" label="回鄉證編號">
                                    <a-textarea autosize  v-model:value="student.hrc_num" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="回鄉證簽發日期">
                                    <a-date-picker v-model:value="student.hrc_issue" :format="dateFormat"
                                        :valueFormat="dateFormat" />
                                </a-form-item>
                                <a-form-item class="student-form-layout" label="回鄉證有效日期">
                                    <a-date-picker v-model:value="student.hrc_expired" :format="dateFormat"
                                        :valueFormat="dateFormat" />
                                </a-form-item>
                            </div>
                        </div>
                    </div>

                    <div class="ant-form-bg"  v-if='activeKeys.includes("detail") ||  activeKeys.includes("all")' >
                        <div  class="form-header">補充信息</div>
                        <div  v-if="student.detail" class="flex flex-wrap gap-1">
                            <a-form-item class="student-form-layout"  label="聖名">
                                <a-textarea autosize  v-model:value="student.detail.holy_name" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="領洗日期">
                                <a-date-picker v-model:value="student.detail.baptized" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="初領聖體日期">
                                <a-date-picker v-model:value="student.detail.first_communion" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="有效日期(逗留)">
                                <a-date-picker v-model:value="student.detail.stay_issue" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="兄弟姊妹總數">
                                <a-textarea autosize  v-model:value="student.detail.sibling" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="已工作兄弟姊妹總數">
                                <a-textarea autosize  v-model:value="student.detail.sibling_at_work" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="入校年級(過去就讀)">
                                <a-textarea autosize  v-model:value="student.detail.previour_grade" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="入校日期(過去就讀)">
                                <a-date-picker v-model:value="student.detail.entry_date" :format="dateFormat" :valueFormat="dateFormat" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="就讀年級(過去就讀)">
                                <a-textarea autosize  v-model:value="student.detail.entry_klass" />
                            </a-form-item >
                        </div >
                    </div>

                    <div class="ant-form-bg"  v-if='activeKeys.includes("address") ||  activeKeys.includes("all")'>
                        <div  class="form-header">住址信息</div>
                        <div   v-if="student.address"  class="flex flex-wrap gap-1">
                            <a-form-item class="student-form-layout"  label="住址街名"  >
                                <a-textarea autosize  v-model:value="student.address.road" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="門牌大廈">
                                <a-textarea autosize  v-model:value="student.address.building" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="居住地區">
                                <a-textarea autosize  v-model:value="student.address.zone" />
                            </a-form-item >
                        </div >
                    </div>

                    <div class="ant-form-bg" v-if='activeKeys.includes("bank") ||  activeKeys.includes("all")'  >
                        <div  class="form-header">銀行信息</div>
                        <div   class="flex flex-wrap gap-1">
                            <a-form-item class="student-form-layout"  label="銀行">
                                <a-textarea autosize  v-model:value="student.bank.bank_name" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="戶口名稱">
                                <a-textarea autosize  v-model:value="student.bank.account_name" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="銀行帳號">
                                <a-textarea autosize  v-model:value="student.bank.account_number" />
                            </a-form-item >
                        </div >
                    </div>


                    <div class="ant-form-bg" v-if='activeKeys.includes("parent") ||  activeKeys.includes("all")' header="父母信息" >
                        <div  class="form-header">父母信息</div>
                        <div  class="flex flex-wrap gap-1"  v-if="student.father">
                            <a-form-item class="student-form-layout" label="父親姓名">
                                <a-textarea autosize  v-model:value="student.father.name_zh" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="父親工作機構">
                                <a-textarea autosize  v-model:value="student.father.occupation" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="父親職業">
                                <a-textarea autosize  v-model:value="student.father.occupation" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="父親手提電話">
                                <a-textarea autosize  v-model:value="student.father.mobile" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="父親住址"  >
                                <a-textarea autosize  v-model:value="student.father.name_zh" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="母親姓名">
                                <a-textarea autosize  v-model:value="student.mother.name_zh" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="母親工作機構">
                                <a-textarea autosize  v-model:value="student.mother.organization" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="母親職業">
                                <a-textarea autosize  v-model:value="student.mother.occupation" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="母親手提電話">
                                <a-textarea autosize  v-model:value="student.mother.mobile" />
                            </a-form-item>
                            <a-form-item class="student-form-layout" label="母親住址">
                                <a-textarea autosize  v-model:value="student.mother.name_zh" />
                            </a-form-item>
                        </div >
                    </div>

                    <div class="ant-form-bg"   v-if='activeKeys.includes("guardian") ||  activeKeys.includes("all")'>
                        <div  class="form-header">監護人信息</div>
                        <div class="flex flex-wrap gap-1" v-if="student.guardian">
                            <a-form-item class="student-form-layout"  label="監護人姓名">
                                <a-textarea autosize  v-model:value="student.guardian.name_zh" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人職業">
                                <a-textarea autosize  v-model:value="student.guardian.occupation" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人機構電話">
                                <a-textarea autosize  v-model:value="student.guardian.mobile" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人關係">
                                <a-textarea autosize  v-model:value="student.guardian.kinship" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人工作機構"  >
                                <a-textarea autosize  v-model:value="student.guardian.organization" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人電話">
                                <a-textarea autosize  v-model:value="student.guardian.mobile" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人居住地區"  >
                                <a-textarea autosize  v-model:value="student.guardian.mobile" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人郵政編號">
                                <a-textarea autosize  v-model:value="student.guardian.mobile" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人街道名稱"  >
                                <a-textarea autosize  v-model:value="student.guardian.mobile" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="監護人門牌,大廈,樓座">
                                <a-textarea autosize  v-model:value="student.guardian.mobile" />
                            </a-form-item >
                        </div >
                    </div>

                    <div class="ant-form-bg" v-if='activeKeys.includes("health") ||  activeKeys.includes("all")' key="" >
                        <div  class="form-header">健康信息</div>
                        <div   class="flex flex-wrap gap-1" v-if="student.health">
                            <a-form-item class="student-form-layout"  label="醫院">
                                <a-textarea autosize  v-model:value="student.health.hospital" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="學生健康情況"  >
                                <a-textarea autosize  v-model:value="student.health.status" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="慢性疾患">
                                <a-textarea autosize  v-model:value="student.health.chronic" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="遺傳性疾病">
                                <a-textarea autosize  v-model:value="student.health.hereditary" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="（食物及藥物）過敏症">
                                <a-textarea autosize  v-model:value="student.health.disease" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="remark"  >
                                <a-textarea autosize  v-model:value="student.health.remark" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="創傷"  >
                                trauma
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="創傷治療"  >
                                trauma treatment
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="過敏"  >
                                <a-textarea autosize  v-model:value="student.health.allergy" />
                            </a-form-item >
                            <a-form-item class="student-form-layout"  label="藥物過敏"  >
                                medician allergy
                            </a-form-item >
                        </div >
                    </div>

                    <div class="ant-form-bg"  v-if='activeKeys.includes("siblings") ||  activeKeys.includes("all")'>
                    <div  class="form-header">本校兄弟姊妹</div>
                        <a-table :dataSource="student.siblings" :columns="columnSiblings">
                            <template #bodyCell="{ column, text, record, index }">
                                <template v-if="column.dataIndex == 'klasses'">
                                    <ol>
                                        <li v-for="klass in record.klasses">{{ klass.school_year }}-{{ klass.tag }}</li>
                                    </ol>
                                </template> 
                                <template v-else>
                                    {{record[column.dataIndex]}}
                                </template>
                            </template>
                        </a-table>

                        <a-button as="link" :href="route('director.student.siblings',student.id)" class="ant-btn">連結本校兄弟姊妹</a-button>
                    </div>
                    </transition-group>

                </div>
               <div class="flex" v-if='isEdit'>
                    <div class="flex-1"></div> 
                    <a-button type="create" @click="onFinish">提交並更改</a-button>
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
import { Link } from '@inertiajs/vue3';
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
    props: ['student'],
    data() {
        return {
            header_zh:{'avatar':'頭像照片','basic':'基本信息','id_card':'證件信息','detail':'補充信息',
                        'address':'住址信息','bank':'銀行信息','parent':'父母信息','guardian':'監護人信息','health':'健康信息','siblings':'本校兄弟姊妹'},
            breadcrumb: [
                { label: "主控台", url: route('director.dashboard') },
                { label: "學人個人檔案", url: null }
            ],
            columnSiblings:[
                {title:'姓名', dataIndex: 'name_zh'},
                {title:'性別', dataIndex: 'gender'},
                {title:'出生日期', dataIndex: 'dob'},
                {title:'就讀班級', dataIndex: 'klasses'},
            ],
            rules: {
                name_zh: { required: true },
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

            activeKeys: ['all'],
            isEdit: false,
            labelCol: { span: 10 }, 
            wrapperCol: { span: 14 },
        }
    },
    created() {
        this.init()        
    },
    mounted(){
    },  
    watch:{
        activeKeys: {
            handler (newVal, oldVal) {
                if(newVal.includes('all') && oldVal.includes('all')  &&  newVal.length>1){
                    this.activeKeys=this.activeKeys.filter(x=>x!='all')
                }else if(newVal.includes('all') && newVal.length>1){
                    this.activeKeys=["all"]
                }
            }
        }
       
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
        onChangeEditMode() {
            console.log(this.isEdit);
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


</style>
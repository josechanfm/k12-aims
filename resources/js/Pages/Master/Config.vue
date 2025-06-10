<template>
    <AdminLayout title="Dashboard">
        <template #header>
            <h2 class="font-semibold text-xl text-gray-800 leading-tight">
                總科目列表
            </h2>
        </template>
        <div>

        </div>
        <button @click="onClickCreate()"
            class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded my-3">Create Subject
            template</button>
        <a-table :dataSource="configs" :columns="columns">
            <template #bodyCell="{ column, text, record, index }">
                <template v-if="column.dataIndex == 'operation'">
                    <a-button @click="onClickEdit(record)">Edit</a-button>
                    <a-button @click="onClickDelete(record.id)">Delete</a-button>
                </template>
                <template v-else-if="column.dataIndex == 'courses'">
                    <ul>
                        <li v-for="klass in record['klasses']">Class: {{ klass.acronym }}</li>
                    </ul>
                </template>
                <template v-else>
                    {{ record[column.dataIndex] }}
                </template>
            </template>
        </a-table>

        <!-- Modal Start-->
        <a-modal v-model:open="modal.isOpen" :title="modal.title" width="60%" @update="updateRecord()"
            @onCancel="closeModal()">
            <a-form 
                name="Config" 
                ref="modalRef" 
                :model="modal.data" 
                :rules="rules"
                :validate-messages="validateMessages"
                :label-col="{ span: 4 }"
                :wrapper-col="{ span: 20 }"
            >
                <a-form-item label="Key" name="key">
                    <a-input v-model:value="modal.data.key" />
                </a-form-item>
                <a-form-item label="Value" name="value">
                    <a-textarea v-model:value="modal.data.value" placeholder="textarea with clear icon"  />
                </a-form-item>
                <!--  -->
                <div v-if="modal.data.key=='grade_years'" class="items-center flex gap-1 flex-col p-1 bg-gray-50 rounded-lg">
                    <table >
                        <thead>
                        <tr class="text-nowrap " >
                         <td  class=" text-center">系統代號 </td>
                            <td  class="text-center"></td>
                            <td  class=" text-center">本校年級代號</td>
                            <td  class=" text-center"> 本校年級數</td>
                            <td  class=" text-center">中文名稱  </td>
                         </tr>
                         </thead>
                        <tr class="" :key="grade" v-for="grade in modal.toJson ">
                            <!-- <div >{{ grade.value }}</div> -->
                            <td class="w-12 text-lg">{{ grade.label }}</td>
                            <td class="w-12 font-bold">></td>
                           <td>
                             <a-input size="small" @change="modal.data.value=JSON.stringify( modal.toJson) "  class="rounded-lg h-fit w-32 text-center"  v-model:value="grade.initial" />
                           </td> 
                           <td>
                             <a-input-number @change="modal.data.value=JSON.stringify( modal.toJson) " class="text-center " min="1" max="15" v-model:value="grade.level" />
                           </td> 
                           <td>
                             <a-input size="small" @change="modal.data.value=JSON.stringify( modal.toJson) "  class="rounded-lg h-fit w-32 text-center"  v-model:value="grade.zh_name" />
                           </td> 
                        </tr>
                    </table>
                </div>
                <!--  -->
                <!--  -->
                <div v-if="modal.data.key=='klass_letters'" class="items-center flex gap-1 flex-wrap text-nowrap p-1 bg-gray-50 rounded-lg">
                    <div  class="flex items-center bg-blue-100 rounded-lg p-2" :key="code" v-for="code in   modal.toJson">
                            <div class="text-blue-600 font-bold ">
                                {{ code.label}}
                            </div>
                            <div>-></div>
                            <div>
                                <a-input size="small" @change="modal.data.value=JSON.stringify( modal.toJson) "  class="!text-sm rounded-lg h-fit w-12 text-center"  v-model:value="code.value" />
                            </div>
                    </div>
                         
                </div>
                <!--  -->
                <a-form-item label="簡介" name="description">
                    <a-textarea v-model:value="modal.data.remark" placeholder="textarea with clear icon" allow-clear />
                </a-form-item>
            </a-form>
            <template #footer>
                <a-button key="back" @click="modalCancel">Return</a-button>
                <a-button v-if="modal.mode == 'EDIT'" key="Update" type="primary"
                    @click="updateRecord()">Update</a-button>
                <a-button v-if="modal.mode == 'CREATE'" key="Store" type="primary"
                    @click="storeRecord()">Create</a-button>
            </template>
        </a-modal>
        <!-- Modal End-->
    </AdminLayout>

</template>

<script>
import AdminLayout from '@/Layouts/AdminLayout.vue';
import { defineComponent, reactive } from 'vue';

export default {
    components: {
        AdminLayout,
    },
    props: ['configs'],
    data() {
        return {
            modal: {
                mode: null,
                isOpen: false,
                title: 'Configs',
                toJson:{},
                data: {}
            },
            columns: [
                {
                    title: 'Key',
                    dataIndex: 'key',
                }, {
                    title: 'Operation',
                    dataIndex: 'operation',
                },
            ],
            rules: {
                code: {
                    required: true,
                },
                title_zh: {
                    required: true,
                },
                title_en: {
                    required: true,
                },
                type: {
                    required: true,
                },
                stream: {
                    required: true,
                },
                eletive: {
                    required: true,
                },
            },
            validateMessages: {
                required: '${label} is required!',
                types: {
                    email: '${label} is not a valid email!',
                    number: '${label} is not a valid number!',
                },
                number: {
                    range: '${label} must be between ${min} and ${max}',
                },
            },
            labelCol: {
                style: {
                    width: '150px',
                },
            },
            layout2col: {
                labelCol: {
                    span: 8,
                },
                wrapperCol: {
                    span: 20,
                },
            }

        }
    },
    methods: {
        onClickCreate(record) {
            this.modal.data = {};
            this.modal.title = "Edit Config";
            this.modal.mode = 'CREATE';
            this.modal.isOpen = true;
        },
        onClickEdit(record) {
            this.modal.data = { ...record };
            this.modal.toJson=JSON.parse( this.modal.data.value)

            this.modal.title = "Edit Config";
            this.modal.mode = 'EDIT';
            this.modal.isOpen = true;
        },
        storeRecord() {
            this.$refs.modalRef.validateFields().then(() => {
                this.$inertia.post(route('master.configs.store'), this.modal.data, {
                    onSuccess: (page) => {
                        console.log(page);
                        this.modal.isOpen = false;
                    },
                    onError: (err) => {
                        console.log(err);
                    }
                });
            }).catch(err => {
                console.log(err);
            });
        },
        updateRecord() {
            this.$refs.modalRef.validateFields().then(() => {
                this.$inertia.put(route('master.configs.update', this.modal.data.id), this.modal.data, {
                    onSuccess: (page) => {
                        console.log(page);
                        this.modal.isOpen = false;
                    },
                    onError: (error) => {
                        console.log(error);
                    }
                });
            }).catch(err => {
                console.log("error", err);
            });

        },
        onClickDelete(recordId) {
            if (!confirm('Are you sure want to remove?')) return;
            this.$inertia.delete('/master/configs/' + recordId, {
                onSuccess: (page) => {
                    console.log(page);
                },
                onError: (error) => {
                    console.log(error);
                }
            });
            this.ChangeModalMode('Close');
        },
        modalCancel() {
            this.modal.data = {}
            this.modal.isOpen = false
        },
        onFinishFailed(errorInfo) {
            console.log('errorInfo: ' + errorInfo);
        }
    },
}
</script>
<style scoped>
:deep(.ant-input-number-input){
    @apply text-center
}
:deep(.ant-input-number-input){
    @apply text-center
}
</style>
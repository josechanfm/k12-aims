<template>
    <div class="flex flex-col items-center justify-center w-fit overflow-hidden border-2 rounded-lg border-gray-400">
            <a-image v-if='avatar.avatar' width="2.8cm" height="3.8cm"  :src="avatar.avatar.preview_url" />
            <div v-else >
                <div  class='bg-white rounded-lg w-[3.2cm] h-[4cm] flex flex-col items-center justify-center font-black'>
                    <UserOutlined class='text-4xl'  />
                    <div>未有相關</div>
                    <div>相片</div>
                    <div  class="text-blue-700 cursor-pointer hover:text-sky-500" @click="openFileDialog">點我新增 <ImportOutlined></ImportOutlined></div>
                </div>
            </div>
            <div class='bg-gray-600/80 text-white w-full text-center rounded-lg'>{{avatar.full_tag}} <ImportOutlined class="hover:text-sky-500" @click="openFileDialog"></ImportOutlined></div>
            <input hidden id="dropzone-file" type="file" :ref="'fileInput-'+avatar.klass_student_id" multiple  @change="handleFileChange" />
            <!-- 重複使用時會撞名所以用klass_student_id區分refs物件 -->
    </div>
</template>

<script>
import { InboxOutlined,UserOutlined,ImportOutlined } from '@ant-design/icons-vue';
import { AvatarGroup, message } from 'ant-design-vue';
import { router } from '@inertiajs/vue3';

export default {
    components: {
        InboxOutlined,UserOutlined,ImportOutlined,
        message
    },
    props: ['avatar'],
    data() {
        return {
            dragging: false,
        }
    },
    created() {
    },
    mounted() {

    },
    methods: {
        handleDragEnter(event) {
            event.preventDefault();
            this.dragging = true;
        },
        handleDragOver(event) {
            event.preventDefault();
        },
        handleDragLeave() {
            this.dragging = false;
        },
        handleDrop(event) {
            event.preventDefault();
            this.dragging = false;
            const file = event.dataTransfer.files[0];
            this.handleFile(file);
        },
        handleFileChange() {
            var files = this.$refs['fileInput-'+this.avatar.klass_student_id].files;
            Object.entries(files).forEach(([i,file])=>{
                this.verifyFile(file)
            })
        },
        uploadFile(klassStudentId, file){
            axios.post(route('teacher.avatars.store'),{
                avatar:file,
                klassStudentId:klassStudentId
            },{
            headers: {
                'Content-Type': 'multipart/form-data'
                }
            }).then(resp=>{
               router.reload()
            }).catch(err=>{
                console.log(err);
            })
        },
        handleFile(file) {
            console.log(file);
        },
        openFileDialog() {
            this.$refs['fileInput-'+this.avatar.klass_student_id].click();
        },
        handleChange(info) {
            const status = info.file.status
            if (status !== 'uploading') {
                console.log('uploading')
            }
            if (status === 'done') {
                message.success(`${info.file.name} file uploaded successfully.`);
            } else if (status === 'error') {
                message.error(`${info.file.name} file upload failed.`);
            }
        },
        verifyFile(file) {
            console.log(file);
            const isJpgOrPng = file.type === 'image/jpeg' || file.type === 'image/png';
            if (!isJpgOrPng) {
                message.error('You can only upload JPG file!');
                return false;
            }
            const isLt2M = file.size / 1024 / 1024 < 2;
            if (!isLt2M) {
                message.error('Image must smaller than 2MB!');
                return false;
            }
            this.uploadFile(this.avatar.klass_student_id,file)
        },
        handleDrop() {
            console.log('handle drop');
        }
    },
}
</script>

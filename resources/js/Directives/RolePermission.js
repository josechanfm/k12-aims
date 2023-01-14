import { usePage } from '@inertiajs/inertia-vue3';

const hasPermission = (permission) => {
    const permissions = usePage().props.value.currentUserPermissions
    return permissions.includes(permission)
}

function checkPermission(el, binding) {
    const { value } = binding
    if (!hasPermission(value)) {
        el.parentNode && el.parentNode.removeChild(el)
    }
}

const hasRole = (role) => {
    const roles = usePage().props.value.currentUserRoles

    console.log('hasRoles()', roles)
    return roles.includes(role)
}


function checkRole(el, binding) {
    const { value } = binding
    if (!hasRole(value)) {
        el.parentNode && el.parentNode.removeChild(el)
    }
}

const permission = {
    created (el, binding) {
        checkPermission(el, binding)
    },
    beforeUpdate (el, binding) {
        checkPermission(el, binding)
    }
}
const role = {
    created (el, binding) {
        checkRole(el, binding)
    },
    beforeUpdate (el, binding) {
        checkRole(el, binding)
    }
}


export default {
    install (app, options) {
        app.directive('can', permission)
        app.directive('role', role)
        app.config.globalProperties.$can = hasPermission
        app.config.globalProperties.$is = hasRole
    }
}
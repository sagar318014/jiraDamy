$(document).ready(() => {
    initializeSelect2ForAll();
})

function initializeSelect2ForAll() {
    $('select.select-2').each(function () {
        initializeSelect2ForDropdown(this)
    })
}

function initializeSelect2ForDropdown(source) {
    $(source).select2();
}

async function commonAjaxCall(request) {
    $.ajax({
        url: request.url,
        success: (response) => {
            request.success(response)
        },
        error: (error) => {
            alert('Something went wrong!')
            console.error(error)
        }
    })
}

function loadDropdownAjax(request) {
    let { id, url, htmlTemplate, isLazyload } = request;
    if (typeof (htmlTemplate) != 'function') {
        htmlTemplate = data => `<option value="${data.id}">${data.text}</option>`
    }
    if (!id) {
        throw 'Id not passed for loadDropdownAjax'
    }
    if (!url) {
        throw 'url not passed for loadDropdownAjax'
    }

    commonAjaxCall({
        url,
        success: (response) => {
            $('#' + id).html('');
            $('#' + id).html(response.data.map(x => htmlTemplate(x)).join(''));
        }
    })
}

const CommonNotifier = {
    showInformation: (msg, onConfirm) => {
        alert(msg)
        onConfirm()       
    },
    showError: (msg, onConfirm) => {
        alert(msg)
    },
    showConfirmationWithCallback: (msg, onConfirm, onCancel) => {
        confirm(msg) ? onConfirm() : onCancel()
    },
    showConfirmationWithPromise: (msg) => new Promise((resolve, reject) => {
        confirm(msg) ? resolve(true) : resolve(false)
    })
}
import Swal from 'sweetalert2';

const initSweetalert = (selector, options = {}) => {
  const swalButton = document.querySelector(selector);
  if (swalButton) { // protect other pages
    swalButton.addEventListener('click', (e) => {
        e.preventDefault();
        e.stopImmediatePropagation();
        Swal.fire(options).then((result) => {
            if (result.isConfirmed) {

                if (selector == '#delete_avatar') {
                    $.ajax({
                        url: '/avatar',
                        method: 'DELETE'
                    });
                }
                if (selector == '#delete_account') {
                    $.ajax({
                        url: '/users',
                        method: 'DELETE'
                    });
                }
            }
          })
    });
  }
};

const removeAvatar = (() => {
    initSweetalert('#delete_avatar', {
        title: 'Are you sure to delete your avatar?',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    });
});

const deleteAccount = (() => {
    initSweetalert('#delete_account', {
        title: 'Are you sure? Your Bintja account will be immediately and definitively destroyed.',
        text: "You won't be able to revert this!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Yes, delete it!'
    });
});

export { removeAvatar };
export { deleteAccount };
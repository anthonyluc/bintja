import Swal from 'sweetalert2';

const initSweetalert = (selector, title, url) => {
  const swalButton = document.querySelector(selector);
  if (swalButton) { // protect other pages
    swalButton.addEventListener('click', (e) => {
        e.preventDefault();
        e.stopImmediatePropagation();
        Swal.fire({
                title: title,
                text: "You won't be able to revert this!",
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Yes, delete it!'
            }).then((result) => {
            if (result.isConfirmed) {
                $.ajax({
                    url: url,
                    method: 'DELETE'
                });
            }
          })
    });
  }
};

const removeAvatar = (() => {
    initSweetalert('#delete_avatar', 'Are you sure to delete your avatar?', '/avatar');
});

const deleteAccount = (() => {
    initSweetalert('#delete_account', 'Are you sure? Your Bintja account will be immediately and definitively destroyed.', '/users');
});

const deleteRecipe = (() => {
    initSweetalert('#delete_recipe', 'Are you sure to delete this recipe?', location.pathname);
});

export { removeAvatar, deleteAccount, deleteRecipe };
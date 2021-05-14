import { Controller } from "stimulus";
import Swal from 'sweetalert2';

export default class extends Controller {
    static targets = ['review', 'btn'];

    static values = { id: Number };

    destroy(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      
      Swal.fire({
            title: 'Are you sure to delete this review?',
            text: "You won't be able to revert this!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, delete it!'
        }).then((result) => {
        if (result.isConfirmed) {
            $.ajax({
                url: e.target.getAttribute('href'),
                method: 'DELETE'
            });
            $(e.target).parent().parent().parent().parent().parent().remove('div');

            Swal.fire({
                toast: true,
                icon: 'success',
                title: 'Review deleted successfully.',
                animation: true,
                position: 'bottom-right',
                showConfirmButton: false,
                timer: 1500,
                timerProgressBar: true,
                didOpen: (toast) => {
                toast.addEventListener('mouseenter', Swal.stopTimer)
                toast.addEventListener('mouseleave', Swal.resumeTimer)
                }
            })
        }
        })
    }
}
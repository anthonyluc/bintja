import { Controller } from "stimulus";
import Swal from 'sweetalert2';

export default class extends Controller {
    static targets = ['btn'];

    destroy(e) {
      e.preventDefault();
      e.stopImmediatePropagation();
      
      Swal.fire({
            title: 'Are you sure to delete this recipe group?',
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
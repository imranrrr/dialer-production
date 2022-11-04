//$(window).ready(() => {
//	$(".form-control").on("input", () => {
	//	for ($i = 0; $i < $(".list > .fio"); $i++){
		//	$userName = $(".list > .fio").html();
		//	if ($userName.upper().indexOf($(".form-control").html()) > -1) {
			//	$('.list').hide();
		//	} else {
			//	$('.list').show();
		//	}
	//	}
//	})


//$('.form-control').on('input', () => {
 // console.log($(".form-control").val())
//})






// let myForm = document.querySelector(".form-control");
// myForm.addEventHandler('addEventListener', 'input', function(e) {
//        let inp = document.querySelector(".form-control"),
//                        btn = document.querySelector(".btn"),
//                        filter = inp.value.toUpperCase(),
//                        list = document.getElementsByClassName("list"),
//                        fio = document.querySelectorAll(".list > .fio"),
//                        userName;



//                for (let i = 0; i < fio.length; i++) {
//                        userName = fio[i].textContent || fio[i].innerText
//                        if (userName.toUpperCase().indexOf(filter) > -1) {
//                                list[i].style.display = ""
//                        } else {
//                                list[i].style.display = "none"
//                        }
//                }
//        });


function switcher_for_user(group_id, user_id) {
  console.log("Here will be nice USER script, user_params:" ,user_id, "group_params:",  group_id);
}

function switcher_for_group(group_id ) {
  console.log("Here will be nice GROUP script, group_params:",  group_id);
}
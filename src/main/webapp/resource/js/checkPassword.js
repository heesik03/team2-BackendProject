// 패스워드 조건 체크
document.getElementById("password-input").addEventListener("input", validatePassword);
document.getElementById("confirm_password-input").addEventListener("input", validateConfirmPassword);

function validatePassword() {
    const pw = document.getElementById("password-input").value;
    const pwMsg = document.getElementById("pw-message");

    const regex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[\W_]).{8,20}$/;

    if (!regex.test(pw)) {
        pwMsg.innerHTML = "<span style='color:red;'>문자+숫자+특수문자 포함 8~20자여야 합니다.</span>";
        return false;
    } else {
        pwMsg.innerHTML = "<span style='color:green;'>사용 가능한 비밀번호입니다.</span>";
        return true;
    }
}

function validateConfirmPassword() {
    const pw = document.getElementById("password-input").value;
    const cpw = document.getElementById("confirm_password-input").value;
    const checkMsg = document.getElementById("confirm-message");

    if (pw !== cpw) {
        checkMsg.innerHTML = "<span style='color:red;'>비밀번호가 일치하지 않습니다.</span>";
        return false;
    } else {
        checkMsg.innerHTML = "<span style='color:green;'>비밀번호가 일치합니다.</span>";
        return true;
    }
}
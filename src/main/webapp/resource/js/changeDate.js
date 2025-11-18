const createAt = document.getElementById("createAt");

const dateStr = createAt.dataset.date; 
const dateObj = new Date(dateStr); // JS Date 객체로 변환

const formatted = dateObj.getFullYear() + "-" + // 포맷 변환
                  String(dateObj.getMonth() + 1).padStart(2, '0') + "-" +
                  String(dateObj.getDate()).padStart(2, '0') + " " +
                  String(dateObj.getHours()).padStart(2, '0') + ":" +
                  String(dateObj.getMinutes()).padStart(2, '0');
				  
createAt.textContent = formatted;
const createAtElements = document.querySelectorAll(".createAt");

createAtElements.forEach(el => {
    const dateStr = el.dataset.date;
    const dateObj = new Date(dateStr);

    const formatted =
        dateObj.getFullYear() + "-" +
        String(dateObj.getMonth() + 1).padStart(2, '0') + "-" +
        String(dateObj.getDate()).padStart(2, '0') + " " +
        String(dateObj.getHours()).padStart(2, '0') + ":" +
        String(dateObj.getMinutes()).padStart(2, '0');

    el.textContent = formatted;
});

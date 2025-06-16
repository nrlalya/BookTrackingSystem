/* 
 Author     : S69935
 Document   : validate.js
 */

function validateForm() {
    const year = document.forms[0]["publication_year"].value;
    if (year < 1000 || year > new Date().getFullYear()) {
        alert("Invalid publication year.");
        return false;
    }
    return true;
}
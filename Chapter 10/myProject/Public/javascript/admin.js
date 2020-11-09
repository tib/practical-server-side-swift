function confirmDelete(path, id) {
    if (confirm("Press ok to confirm delete.")) {
        var xmlHttp = new XMLHttpRequest();
        xmlHttp.onreadystatechange = function() {
            if (xmlHttp.readyState != 4 || xmlHttp.status != 200) {
                return;
            }
            var element = document.getElementById(id);
            var tr = element.parentElement.parentElement;
            tr.parentNode.removeChild(tr);
        }
        xmlHttp.open("POST", path + id + "/delete/", true);
        xmlHttp.send(null);
    }
}

document.addEventListener("keydown", function(e) {
    if ( (window.navigator.platform.match("Mac") ? e.metaKey : e.ctrlKey) && e.keyCode == 83 ) {
        e.preventDefault();
        document.forms[0].submit();
    }
}, false);

function confirmDelete(path, id) {
  if (confirm("Press ok to confirm delete.")) {
     var xmlHttp = new XMLHttpRequest();
        xmlHttp.onreadystatechange = function() {
            if (xmlHttp.readyState != 4 || xmlHttp.status != 200) {
                return
            }
            var element = document.getElementById(id)
            var tr = element.parentElement.parentElement
            tr.parentNode.removeChild(tr)
        }
        xmlHttp.open("POST", path + id + "/delete", true);
        xmlHttp.send(null);
  }
}

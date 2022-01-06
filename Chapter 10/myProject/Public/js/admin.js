document.addEventListener("keydown", function(e) {
    if ( (window.navigator.platform.match("Mac") ? e.metaKey : e.ctrlKey) && e.keyCode == 83 ) {
        e.preventDefault();
        document.forms[0].submit();
    }
}, false);

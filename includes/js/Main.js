
function onPageLoaded() {
    findMenuLinkElement()
}

function findMenuLinkElement() {

    let urlValues = getUrlSlashValues()
    if (urlValues.length <= 1) {
        return null
    }

    for (let urlLength = urlValues.length; urlLength > 1; urlLength--) {

        let menuLinkId = "navMenu_"

        for (let y=1; y < urlLength; y++) {

            if (y > 1) {
                menuLinkId += "_"
            }
            menuLinkId += removeFileExtension(urlValues[y])
        }

        console.log("Looking for menu link with elementId: " + menuLinkId)
        let menuLinkElement = document.getElementById(menuLinkId);

        if (menuLinkElement != null) {
            console.log("Found menu link with elementId: " + menuLinkId)
            setCssClassOnNavMenuOfCurrentPage(menuLinkElement)
        }
    }

    return null
}

function getUrlSlashValues() {
    const relativeUrl = window.location.pathname+window.location.search
    return relativeUrl.split("/")
}

function setCssClassOnNavMenuOfCurrentPage(menuLinkElement) {
    const CSS_CLASS_NAME = "navMenuVisited"
    let arr = menuLinkElement.className.split(" ");
    if (arr.indexOf(CSS_CLASS_NAME) == -1) {
        menuLinkElement.className += " " + CSS_CLASS_NAME;
    }
}

function removeFileExtension(urlValue) {
    if (urlValue.includes(".")) {
        return urlValue.split(".")[0]
    }
    return urlValue
}

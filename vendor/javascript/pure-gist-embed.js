const axios = require('axios');
const jsonpAdapter = require('axios-jsonp');
const gistUrl = 'https://gist.github.com/';

const getData = (gistId) => {
    return new Promise((resolve, reject) => {
        const url = gistUrl + gistId + '.json'
        if(typeof document !== null) {
            // Browser
            axios.get(url, {
                    adapter: jsonpAdapter
                })
                .then((response) => {
                    resolve({
                        content: response.data.div
                    })
                })
                .catch((error) => {
                    reject(error)
                })
        } else {
            // Node.js
            axios.get(url, {
                })
                .then((response) => {
                    resolve({
                        content: response.data.div
                    })
                })
                .catch((error) => {
                    reject(error)
                })
        }
    })
}

const embed = async (pointer, elm) => {
    const gistId = getGistId(pointer)
    getData(gistId)
        .then((result) => {
            elm.innerHTML = result.content
        })
        .catch((error) => {
            console.log(error)
        })
}

const get = async (pointer) => {
    const gistId = getGistId(pointer)
    return getData(gistId)
}

const getGistId = (pointer) => {
    // Get GistId from URL
    if(pointer.indexOf('gist.github.com') > -1) {
        const splited = pointer.split('/')
        const id = splited[splited.length - 1].split('.')[0]
        return id
    }

    // ID
    return pointer
}

module.exports = {
    embed,
    get
}
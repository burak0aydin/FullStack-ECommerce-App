const fs = require('fs');
const path = require('path');

// extract the filename from a url 
const getFileNameFromUrl = (photoUrl) => {
    try {

        const url = new URL(photoUrl)
        const fileName = path.basename(url.pathname)
        return fileName

    } catch (error) {
        console.error('Invalid URL:', error)
        return null
    }
}

const deleteFile = (fileName) => {

    return new Promise((resolve, reject) => {
        if (!fileName) {
            return resolve()
        }

        const fullImagePath = path.join(__dirname, '../uploads', fileName);

        fs.access(fullImagePath, fs.constants.F_OK, (accessErr) => {
            if (accessErr) {
                console.error('File does not exist:', fullImagePath);
                return resolve(); // If the file doesn't exist, we consider it successfully "deleted"
            }
        })

        // If the file exists, delete it 
        fs.unlink(fullImagePath, (unlinkErr) => {
            if(unlinkErr) {
                console.error('Error deleting image:', unlinkErr);
                return reject(unlinkErr);
            } else {
                console.log('Image deleted successfully');
                return resolve();
            }
        })
    })

}

module.exports = {
    getFileNameFromUrl, 
    deleteFile 
}
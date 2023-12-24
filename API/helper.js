// Get offset for pagination of data
function getOffset(currentPage = 1, listPerPage) {
    return (currentPage - 1) * [listPerPage];
}

// Return rows of data
function emptyOrRows(rows) {
    if (!rows) {
        return [];
    }

    return rows;
}

module.exports = {
    getOffset,
    emptyOrRows
}
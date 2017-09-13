var db = LocalStorage.openDatabaseSync("QpostStorage", "", "QPost", 1000000);
var list = [];

function dbInit()
{
    try {
        db.transaction(function (tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS posts (id INTEGER PRIMARY KEY AUTOINCREMENT, url TEXT, parameters TEXT);');
        });
    } catch (err) {
        console.log("Error creating table in database: " + err);
    };
}

function dbInsertPost(url, parameters)
{
    var result;
    db.transaction(function (tx) {
        try {
            var id = tx.executeSql("INSERT INTO posts (url, parameters) VALUES (?, ?)", [url, JSON.stringify(parameters)]);
            result = {'id': id.insertId};
        } catch (err) {
            result = {'error': err};
        }
    });
    return result;
}

function dbUpdatePost(id, url, parameters)
{
    console.log(id, url, parameters);
    db.transaction(function (tx) {
        try {
            var id = tx.executeSql("UPDATE posts SET url=?, parameters=? WHERE id=?", [url, JSON.stringify(parameters), id]);
            result = {'id': id.insertId};
        } catch (err) {
            result = {'error': err};
        }
    });
    return result;
}

function dbSelectPosts()
{
    db.transaction(function (tx) {
        try {
            var select = tx.executeSql("SELECT * FROM posts");
            for (var it = 0; it < select.rows.length; it++) {
                list.push({
                      "id": select.rows[it].id,
                      "url": select.rows[it].url,
                      "parameters": select.rows[it].parameters
                });
            }
        } catch (err) {
            console.log("Error: " + err);
        }
    });
    return list;
}

function dbDeletePost(id)
{
    db.transaction(function (tx) {
        try {
            tx.executeSql("DELETE FROM posts WHERE id=?", [id]);
        } catch (err) {
            console.log("Error: " + err);
        }
    });
}

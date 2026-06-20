const { initializeApp, cert } = require('firebase-admin/app');
const { getAuth } = require('firebase-admin/auth');
const { getFirestore } = require('firebase-admin/firestore');
const serviceAccount = require('./serviceAccountKey.json');
initializeApp({
    credential: cert(serviceAccount),
});
const db = getFirestore();
async function deleteAllUsers(nextPageToken) {
    const listUsersResult = await getAuth().listUsers(1000, nextPageToken);
    const uids = listUsersResult.users.map((user) => user.uid);
    if (uids.length > 0) {
        const result = await getAuth().deleteUsers(uids);
        console.log(
            `Deleted ${result.successCount} auth users, failed ${result.failureCount}`
        );
    }
    if (listUsersResult.pageToken) {
        await deleteAllUsers(listUsersResult.pageToken);
    }
}
async function main() {
    try {
        await deleteAllUsers();
        await db.recursiveDelete(db.collection('Admin'));
        await db.recursiveDelete(db.collection('Users'));
        console.log('All Auth users and Firestore data deleted.');
    } catch (e) {
        console.error(e);
    }
}
main();
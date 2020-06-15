// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

// Take the text parameter passed to this HTTP endpoint and insert it into the
// Realtime Database under the path /messages/:pushId/original
exports.addMessage = functions.https.onRequest(async(req, res) => {
    // Grab the text parameter.
    const original = req.query.text;
    // Push the new message into the Realtime Database using the Firebase Admin SDK.
    const snapshot = await admin.database().ref('/messages').push({ original: original });
    // Redirect with 303 SEE OTHER to the URL of the pushed object in the Firebase console.
    res.redirect(303, snapshot.ref.toString());
});

exports.transactionWebHook = functions.https.onRequest(async(req, res) => {
    if (req.method === 'POST') {
        // console.log('POST Request');
        const type = req.body.type;
        if (type === 'transaction-update') {
            const data = req.body.data;
            const code = data.code;
            const content = data.content;
            const transaction = content.transactions;
            const status = transaction.status;
            const request_id = data.requestId;
            if (status === 'reversed') {
                var amount = Number.parseFloat(transaction.amount);
                db.collection('transactions').where('request_id', '===', request_id).get().then((doc) {
                    const transactionDoc = doc.docs[0];

                });
            }

        }
    } else {
        console.log('Please send a post request');
    }
});
/* eslint-disable consistent-return */
/* eslint-disable promise/always-return */
/* eslint-disable promise/catch-or-return */
/* eslint-disable promise/no-nesting */
// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();
const fcm = admin.messaging();

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
                const amount = Number.parseFloat(transaction.amount);
                const commission = Number.parseFloat((2 / 100) * amount);
                // eslint-disable-next-line promise/always-return
                db.collection('transactions').where('request_id', '==', request_id).get().then((result) => {
                    
                    if (result.docs.length === 0) {
                        res.send({
                            'response': 'success'
                        });
                        return;
                    }
                    const transactionDoc = result.docs[0];
                    const uid = transactionDoc['uid'];
                    // eslint-disable-next-line promise/always-return
                    db.collection('wallet').where('uid', '==', uid).get().then((walletResult) => {
                        const walletDoc = walletResult.docs[0];
                        const balance = Number.parseFloat(walletDoc['balance']);
                        const bonus = Number.parseFloat(walletDoc['bonus']);
                        walletDoc.ref.update({
                            'balance': balance + amount,
                            'bonus': bonus - commission,
                        }).then((update) => {
                            res.send({
                                'response': 'success'
                            });
                        });
                    });
                }).catch(error => {
                    print(error);
                    res.send({
                        'response': 'failed'
                    });
                    process.exit();
                });
                // transactionDoc.
            }
        }
    } else {
        res.send({
            'response': 'failed',
            'message': 'Please send a post request'
        });
    }
});

exports.onNewUser = functions.firestore.document('wallet/{walletId}').onUpdate(async(snapshot, context) => {
    if (snapshot.empty) {
        console.log('Snapshot is empty');
        return;
    }
    console.log(snapshot.after.data());
    console.log(snapshot.before.data());
    // snapshot.after.
    const newData = snapshot.after.data();
    
    const payload = {
        notification: {
            title: 'Smart Pay: New Wallet Balance',
            body: `You have a new balance of ${newData.balance}`,
            sound: 'true',
            icon: ''
        },
        data: {
            message: `You have a new balance of ${newData.balance}`,
            click_action: 'FLUTTER_NOTIFICATION_CLICK',
        }
    };
    const tokens = [
        'ehcRP4FHQa69-NbezZfcIm:APA91bE7fqkiWODdYsIKCU9KOZCCuwyozWRN8vKgwKMB9mFn9bhB9bjfLrIamPHv56dSWrP7XKXqdN1uUbvHlWTSHBHGGlzgBSrpNLaHej1aP11vEavvA_khn948dKBPeOiO5PoaVbtx'
    ];
    db.collection('users').where('uid', '==', newData.uid).get().then((userData) => {
        const user = userData.docs[0];
        console.log(user);
        tokens.push(user['device_id']);
    });
    return fcm.sendToDevice(tokens, payload).then((sent) => {
        console.log('Notification Sent');
    }).catch((error) => {
        console.log(`Notification not Sent. An error occurred! ${error}`);
        // return 'Unable to send notification because of error';
    });
});
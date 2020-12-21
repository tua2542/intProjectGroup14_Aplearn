const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

const firestore = admin.firestore();
const settings = { timestampInSnapshots: true };
firestore.settings(settings);
const stripe = require("stripe")(
  "sk_test_51GzJm8LlTCGQsQVIWZvsQFxBrxDC7giLpAH2vo0qxoRErvSplgxJ3FEGXRic5Jd2yCoFWBrR6HkAcVcs8IiQKvzp002cPp1mZN"); //TODO: ADD SECRET KEY
exports.createPaymentIntent = functions.https.onCall((data, context) => {
  return stripe.paymentIntents.create({
    amount: data.amount,
    currency: data.currency,
    payment_method_types: ["card"],
  });
});

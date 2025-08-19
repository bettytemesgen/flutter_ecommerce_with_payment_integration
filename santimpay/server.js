import express from 'express';
import axios from 'axios';
import jwt from 'jsonwebtoken';
import { PRODUCTION_BASE_URL, TEST_BASE_URL } from './utils/constants.js';

const app = express();
const port = 3000;

app.use(express.json());

const PRIVATE_KEY = `-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIF/mI9tSZxKbfEniC+3yfvwIS/D76+p/ky/oDmKAwu5roAoGCCqGSM49
AwEHoUQDQgAEqJl+TIowE6CAhoghgmH+cdzn5+WNax9/REqXJf6b1HdJCRZBCXWT
6coLZ23OyF5x9uVOUXixZeB7J7y9iSWDzw==
-----END EC PRIVATE KEY-----
`;

const MERCHANT_ID = '9e2dab64-e2bb-4837-9b85-d855dd878d2b';
const TEST_BED = false; // set to true for testnet, false for production

const BASE_URL = TEST_BED ? TEST_BASE_URL : PRODUCTION_BASE_URL;

app.post('/initiate-payment', async (req, res) => {
  const { id, amount, paymentReason, successRedirectUrl, failureRedirectUrl, notifyUrl, cancelRedirectUrl, phoneNumber } = req.body;

  if (!id || !amount || !paymentReason) {
    return res.status(400).json({ error: 'Missing required parameters: id, amount, paymentReason' });
  }

  try {
    const time = Math.floor(Date.now() / 1000);
    const payload = {
      amount,
      paymentReason,
      merchantId: MERCHANT_ID,
      generated: time
    };

    const signedToken = jwt.sign(payload, PRIVATE_KEY, { algorithm: 'ES256' });

    const santimpayPayload = {
      id,
      amount,
      reason: paymentReason,
      merchantId: MERCHANT_ID,
      signedToken: signedToken,
      successRedirectUrl,
      failureRedirectUrl,
      notifyUrl,
      cancelRedirectUrl
    };

    if (phoneNumber) {
      santimpayPayload.phoneNumber = phoneNumber;
    }

    const response = await axios.post(`${BASE_URL}/initiate-payment`, santimpayPayload);

    res.status(200).json({ paymentUrl: response.data.url });
  } catch (error) {
    console.error('Error initiating payment:', error.response?.data || error.message);
    res.status(500).json({ error: 'Failed to initiate payment' });
  }
});

app.listen(port, () => {
  console.log(`Backend server listening at http://localhost:${port}`);
});

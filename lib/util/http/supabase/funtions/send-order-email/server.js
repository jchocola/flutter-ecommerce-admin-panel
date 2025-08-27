const express = require('express');
const nodemailer = require('nodemailer');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

const transporter = nodemailer.createTransport({
  host: 'smtp.gmail.com',
  port: 465,
  secure: true,
  auth: {
    user: 'mohamedafrasai@gmail.com',        // Your Gmail address
    pass: 'afras4432',         // Your Gmail App Password (not your normal password!)
  },
});

app.post('/send-order-email', async (req, res) => {
  const { to, subject, html } = req.body;

  const mailOptions = {
    from: `"My Store" <${transporter.options.auth.user}>`,
    to,
    subject,
    html,
  };

  try {
    const info = await transporter.sendMail(mailOptions);
    console.log('Email sent:', info.response);
    res.status(200).json({ success: true, info: info.response });
  } catch (error) {
    console.error('Error sending email:', error);
    res.status(500).json({ success: false, error: error.message });
  }
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Email server running on port ${PORT}`);
});

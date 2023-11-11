import nodemailer from 'nodemailer';
import { google } from "googleapis";


const sendEmail = async (options) => {

    const oAuth2Client = new google.auth.OAuth2(process.env.CLIENT_ID, process.env.CLIENT_SECRET, process.env.REDIRECT_URI);
    oAuth2Client.setCredentials({ refresh_token: process.env.REFRESH_TOKEN });
    try {

        const accessToken = await oAuth2Client.getAccessToken();
        // create reusable transporter object using the default SMTP transport
        const transporter = nodemailer.createTransport({
            // host: process.env.SMTP_HOST,
            // name: options.name,
            // port: process.env.SMTP_PORT,
            // auth: {
            //     user: process.env.SMTP_EMAIL,
            //     pass: process.env.SMTP_PASSWORD,
            // },
            service: 'gmail',
            auth: {
                type: 'OAuth2',
                user: 'adityakmcs@gmail.com',
                clientId: process.env.CLIENT_ID,
                clientSecret: process.env.CLIENT_SECRET,
                refreshToken: process.env.REFRESH_TOKEN,
                accessToken: accessToken

            },
            tls: {
                rejectUnauthorized: false
            }
        }); 

        // send mail with defined transport object
        let message = {
            from: `${process.env.FROM_NAME} <${process.env.FROM_EMAIL}`, // sender address
            to: options.email,
            subject: options.subject,
            text: options.message,
        };


        const info = await transporter.sendMail(message);
        console.log('Message Sent %s %s', info.messageId, info.response);
        return info.rejected;
    } catch (e) {
        return e;
    }
}

export default sendEmail;
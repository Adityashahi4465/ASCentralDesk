import express from 'express';
import * as dotenv from 'dotenv';
import cors from 'cors';
import connectDB from './utils/db.js'
import errorHandler from './middlewares/error.js'

//Route Files, **add file extension
import authRouter from './routes/auth.js'
import userRouter from './routes/users.js'
import complaintRouter from './routes/complaint.js'
import eventRouter from './routes/event.js'
//configure environment variable
dotenv.config()

//connect to db
connectDB();

// PORT
const PORT = process.env.PORT || 5000; // Set the port (5000 by default)
//Initialize the app
const app = express();



//Middlewares--------------------- a function that has access to req, res life-cycle
//app.use() - It is used to mount middleware functions 

//Enable Cors 
app.use(cors());

//Body Parser Middleware
app.use(express.json());

//Mount Routers------------------
app.use('/api/v1/auth', authRouter);
app.use('/api/v1/auth/user', userRouter);
app.use('/api/v1/auth/complaint', complaintRouter);
app.use('/api/v1/auth/event', eventRouter);


//Error handler middleware, must be after Routers Mount,so that errors returned from routes can be handled
app.use(errorHandler);

// Start the server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});

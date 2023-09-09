import express from 'express';
import * as dotenv from 'dotenv';
import cors from 'cors';
import connectDB from './utils/db.js'
import errorHandler from './middlewares/error.js'

//Route Files, **add file extension
import authRouter from './routes/auth.js'

//configure environment variable
dotenv.config()

//connect to db
connectDB();

// PORT
const PORT = process.env.PORT || 5000; // Set the port (3000 by default)
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


//Error handler middleware, must be after Routers Mount,so that errors returned from routes can be handled
app.use(errorHandler);


app.get('/heel', (req, res) => {
  //express automatically sets content-type like: application/json; charset=utf-8 or text/html for simple string

  // res.send("Hello From Express");

  // res.send({
  //   name: "aditya",
  // })
  // or res.json({name:"inderjit"})

  res.sendStatus(400);
  // or res.status(400).send({success:false})
  // or res.status(200).send({success:true,data:{id:123}})
});


// Start the server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server is running on port ${PORT}`);
});

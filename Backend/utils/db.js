import mongoose from "mongoose";
const connectDB = async () => {
    const connection = await mongoose.connect(process.env.MONGODB_URI, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
    });
    console.log(`DB connected`);
}

export default connectDB;
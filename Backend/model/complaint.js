import mongoose from 'mongoose'

const complaintSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true,
    },
    description: {
        type: String,
        required: true,
    },
    images: [{
        type: String, // Assuming you're storing image bytes as Buffer
    }],
    category: {
        type: String,
        required: true,
    },
    consults: {
        type: String,
        required: false,
        default: "",
    },
    filingTime: {
        type: Date,
        required: true,
    },
    fund: {
        type: Number,
        required: false,
        default: 0
    },
    status: {
        type: String,
        required: true,
        default: "pending",
    },
    upvotes: {
        type: Number,
        default: 0, // Default value for upvotes
    },
    // Add other fields as needed
    createdBy: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User', // Assuming you have a User model for createdBy
        required: true,
    },
}, { timestamps: true });

const Complaint = mongoose.models.Complaint || mongoose.model('Complaint', complaintSchema);

export default Complaint;

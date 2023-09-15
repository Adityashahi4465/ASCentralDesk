import mongoose from 'mongoose'
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';

// Define the User Schema
const UserSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: [true, 'Please add a password'],
    minlength: 6,
    select: false, // will not fetch password on normal fetch call from the database
  },
  role: {
    type: String,
    enum: ['admin', 'student', 'moderator'],
    required: true,
  },
  emailVerified: {
    type : Boolean,
    default : false,
  },
  rollNo: {
    type: String,
  },
  campus: {
    type: String,
  },
  course: {
    type: String,
  },
  semester: {
    type: String,
  },
  section: {
    type: String,
  },
  photoUrl: {
    type: String,
    default: '',
  },
  linkedInProfileUrl: {
    type: String,
    default: '',
  },
  isAccountActive: {
    type: Boolean,
    default: false,
  },
  bookmarkedComplaints: {
    type: [String],
    default: [], // Default to an empty array
  },
  bookmarkedEvents: {
    type: [String],
    default: [], // Default to an empty array
  },
  bookmarkedNotifications: {
    type: [String],
    default: [], // Default to an empty array
  },
});


UserSchema.pre('save', async function (next) {
  //This middleware is running even for forgot password. forgotPassword user don't have a password
  if (!this.isModified('password')) {
    next();
  }
  const salt = await bcrypt.genSalt(12);
  this.password = await bcrypt.hash(this.password, salt);
  next();
});


//Sign JWT and return
UserSchema.methods.getJWTSignedToken = function () {
  //payload, secret,expiresIn
  return jwt.sign({
    id: this._id,
  }, process.env.JWT_SECRET, {
    expiresIn: process.env.JWT_EXPIRE
  });
}

//match user entered password
UserSchema.methods.matchPassword = async function (enteredPassword) {
  return await bcrypt.compare(enteredPassword, this.password);
}

// Create a Mongoose model for the User

const User = mongoose.models.User || mongoose.model('User', UserSchema);
export default User;

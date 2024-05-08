import mongoose from 'mongoose'

const Schema = mongoose.Schema;

const noticeSchema = new Schema({
    title: { type: String, required: true, },
    category: { type: String, required: true, },
    postedAt: { type: Date, default: Date.now, required: true, },
    expirationDate: { type: Date, default: Date.now, required: true, },
    startDate: { type: Date, default: Date.now, required: true },
    author: { type: String, required: true, },
    content: { type: String, required: true, },
    targetCampuses: { type: [String], default: ['All Campuses'], required: true, },
    priorityLevel: { type: String, required: true, },
    status: { type: String, required: true, },
    visibility: { type: String, required: true, },
    relatedNotices: { type: [String], default: [], required: true, },
    tags: { type: [String], default: [], required: true, },
    approvalStatus: { type: Boolean, default: false, required: true, },
    authorContact: { type: String, required: true, },
    lastModified: { type: Date, default: Date.now, required: true, },
});

const Notice = mongoose.model('Notice', noticeSchema);

export default Notice;

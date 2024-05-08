
/*
asyncHandler is a utility function to simplify error handling for asynchronous operations within
Express.js route handlers by automatically forwarding errors to the Express error handling middleware.
*/

const asyncHandler = fn => (req, res, next) =>
    Promise
        .resolve(fn(req, res, next))
        .catch(next)

export default asyncHandler;
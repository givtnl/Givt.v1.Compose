var express = require('express');
var server = express();
var port = process.env.PORT || 3000;
var options = {
    index: 'hostingstart.html'
};
server.get('/', (req, res) => res.send('Hello from the base image, if you see this, youve put the files in the wrong location!'))
server.listen(port, () => console.log(`Listening on port ${port}`));
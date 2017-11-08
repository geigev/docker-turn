This is a lightweight Stun/Turn server based on the COTURN project.
It uses alpine as its base image and the coturn package from alpines
testing branch -- this should be updated when the coturn package is
released into the main branch.

If you would like to test the file only locally, remove network_mode = "host"
from the docker-compose.yml file.

The entry command is Turn-Rest API and time-limited credentials. You must
generate these credentials yourself. Doing this in node.js looks something
like this:

`
var crypto = require('crypto');

function getTURNCredentials(name, secret){    

    var unixTimeStamp = parseInt(Date.now()/1000) + 24*3600,   // this credential would be valid for the next 24 hours
        username = [unixTimeStamp, name].join(':'),
        password,
        hmac = crypto.createHmac('sha1', secret);
    hmac.setEncoding('base64');
    hmac.write(username);
    hmac.end();
    password = hmac.read();
    return {
        username: username,
        password: password
    };
}
`

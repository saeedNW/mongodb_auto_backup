const express = require('express')
const app = express()
const port = 3000
const cron = require('node-cron');
const { spawn } = require('node:child_process');

(async ()=>{
    await cron.schedule('*/5 * * * * *', function () {
        let backupProcess = spawn('mongodump');
    
        backupProcess.on('exit', (code, signal) => {
            if(code) 
                console.log('Backup process exited with code ', code);
            else if (signal)
                console.error('Backup process was killed with singal ', signal);
            else 
                console.log('Successfully backedup the database')
        });
    });
})();


app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})